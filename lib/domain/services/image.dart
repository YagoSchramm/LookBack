import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class ImageService {
  /// Opens the image picker and returns the selected file.
  Future<File?> pickImage(ImageSource source);

  /// Opens the gallery to select an image.
  Future<File?> pickImageFromGallery() => pickImage(ImageSource.gallery);

  /// Opens the camera to take a photo.
  Future<File?> pickImageFromCamera() => pickImage(ImageSource.camera);
}
