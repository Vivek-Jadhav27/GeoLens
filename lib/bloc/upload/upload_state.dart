import 'dart:io';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class UploadState  extends Equatable{}

class UploadInitial extends UploadState {
  @override
  List<Object?> get props => [];
}

class ImagePicked extends UploadState {
  final File image;
  final Uint8List convertedImage;

  ImagePicked(this.image , this.convertedImage);

  @override
  List<Object?> get props => [image];

}


class PredictionLoading extends UploadState {
  @override
  List<Object?> get props => [];
}

class PredictionResult extends UploadState {
  final String result;

  PredictionResult(this.result);

  @override
  List<Object?> get props => [result];
}

class UploadError extends UploadState {
  final String message;

  UploadError(this.message);

  @override
  List<Object?> get props => [message];
}
