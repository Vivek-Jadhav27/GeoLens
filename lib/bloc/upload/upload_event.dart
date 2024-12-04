import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class UploadEvent {}

class PickImageEvent extends UploadEvent {}

class RetakeImageEvent extends UploadEvent {}

class ConvertImageEvent extends UploadEvent {
  final XFile image;

  ConvertImageEvent(this.image);
}

class PredictImageEvent extends UploadEvent {
  final File image;

  PredictImageEvent(this.image);
}
