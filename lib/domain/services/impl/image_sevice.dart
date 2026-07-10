import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../image.dart';

ImageService newImageService(ImagePicker picker){
  return _ImageService(picker);
}

class _ImageService implements ImageService {
  final ImagePicker _picker;

  _ImageService([ImagePicker? picker]) : _picker = picker ?? ImagePicker();

  @override
  Future<File?> pickImage(ImageSource source) async {
    final picked = await _picker.pickImage(
      source: source,
      imageQuality: 85,
      maxWidth: 2000,
    );

    if (picked == null) return null;

    return File(picked.path);
  }
  
  @override
  Future<File?> pickImageFromCamera() => pickImage(ImageSource.camera);
  
  @override
  Future<File?> pickImageFromGallery() => pickImage(ImageSource.gallery);
}


