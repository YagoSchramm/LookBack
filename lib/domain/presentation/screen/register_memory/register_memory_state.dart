import 'dart:io';

import 'package:flutter/material.dart';

class RegisterMemoryState extends ChangeNotifier {
  RegisterMemoryState();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  File? selectedImage;
  File? selectedAudio;
  String? selectedLocation;
  bool isSaving = false;

  bool get canSave => titleController.text.trim().isNotEmpty && !isSaving;

  bool get hasAdditionalContent =>
      selectedImage != null || selectedAudio != null || selectedLocation != null;

  void updateImage(File? image) {
    selectedImage = image;
    notifyListeners();
  }

  void updateAudio(File? audio) {
    selectedAudio = audio;
    notifyListeners();
  }

  void updateLocation(String? location) {
    selectedLocation = location;
    notifyListeners();
  }

  void setSaving(bool value) {
    isSaving = value;
    notifyListeners();
  }

  Future<void> saveMemory(BuildContext context) async {
    if (titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Adicione um título para a sua lembrança.')),
      );
      return;
    }

    setSaving(true);
    await Future<void>.delayed(const Duration(milliseconds: 600));

    if (!context.mounted) return;

    setSaving(false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Lembrança criada com sucesso!')),
    );

    Navigator.of(context).maybePop();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
