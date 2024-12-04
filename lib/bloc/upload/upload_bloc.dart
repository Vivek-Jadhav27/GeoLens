import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolens/bloc/upload/upload_event.dart';
import 'package:geolens/bloc/upload/upload_state.dart';
import 'package:geolens/service/api_service.dart';
import 'package:image_picker/image_picker.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final ApiService apiService = ApiService();
  final ImagePicker imagePicker = ImagePicker();

  UploadBloc() : super(UploadInitial()) {
    on<PickImageEvent>(_onPickImage);
    on<PredictImageEvent>(_onPredictImage);
    // on<ConvertImageEvent>(_onConvertImage);
    on<RetakeImageEvent>(_onRetakeImageEvent);
  }

  void _onRetakeImageEvent(RetakeImageEvent event, Emitter<UploadState> emit) {
    emit(UploadInitial());
  }

  Future<void> _onPickImage(
      PickImageEvent event, Emitter<UploadState> emit) async {
    try {
      final XFile? photo =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (photo != null) {
        if (photo.path.toLowerCase().endsWith('.tiff')) {
          final bytes = await photo.readAsBytes();
          final tiffImage = img.decodeTiff(bytes);
          if (tiffImage != null) {
            final pngBytes = Uint8List.fromList(img.encodePng(tiffImage));
            emit(ImagePicked(File(photo.path), pngBytes));
          } else {
            emit(UploadError('Not a valid TIFF file or decoding failed.'));
          }
        }
      } else {
        emit(UploadError('No image selected'));
      }
    } catch (e) {
      emit(UploadError('Error picking image: $e'));
    }
  }

  // Future<void> _onConvertImage(
  //     ConvertImageEvent event, Emitter<UploadState> emit) async {
  //   try {
  //     emit(PredictionLoading());
  //     final bytes = await event.image.readAsBytes();
  //     final tiffImage = img.decodeTiff(bytes);
  //     if (tiffImage != null) {
  //       final pngBytes = Uint8List.fromList(img.encodePng(tiffImage));
  //       emit(ImageConverted(pngBytes));
  //     } else {
  //       emit(UploadError('Not a valid TIFF file or decoding failed.'));
  //     }
  //   } catch (e) {
  //     emit(UploadError('Error converting TIFF image: $e'));
  //   }
  // }

  Future<void> _onPredictImage(
      PredictImageEvent event, Emitter<UploadState> emit) async {
    try {
      emit(PredictionLoading());
      final response = await apiService.uploadImage(event.image.path);

      if (response['status'] == 'success') {
        emit(PredictionResult( response['class_index']));
      } else {
        emit(UploadError('Error: ${response['message']}'));
      }
    } catch (e) {
      emit(UploadError('Error uploading image: $e'));
    }
  }
}
