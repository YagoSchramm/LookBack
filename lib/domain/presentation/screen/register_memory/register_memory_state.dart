import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:look_back/global.dart';

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



  bool _isRecording = false;

  bool get isRecording => _isRecording;

  String? _audioPath;

  String? get audioPath => _audioPath;

  Duration _duration = Duration.zero;

  Duration get duration => _duration;

  double _amplitude = 0;

  double get amplitude => _amplitude;

  Timer? _timer;

  Future<void> startRecording() async {
    if (_isRecording) return;

    _duration = Duration.zero;

    audioService.onAmplitudeChanged = (value) {
      _amplitude = value;
      notifyListeners();
    };

    await audioService.startRecording();

    _isRecording = true;

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        _duration += const Duration(seconds: 1);
        notifyListeners();
      },
    );

    notifyListeners();
  }

  Future<void> stopRecording() async {
    if (!_isRecording) return;

    _audioPath = await audioService.stopRecording();

    _timer?.cancel();

    _isRecording = false;

    notifyListeners();
  }

  Future<void> cancelRecording() async {
    await audioService.cancelRecording();

    _timer?.cancel();

    _audioPath = null;

    _duration = Duration.zero;

    _isRecording = false;

    notifyListeners();
  }

  void removeAudio() {
    _audioPath = null;
    _duration = Duration.zero;

    notifyListeners();
  }
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
     _timer?.cancel();
    super.dispose();
  }
}
