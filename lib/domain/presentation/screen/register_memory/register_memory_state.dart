import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:look_back/domain/presentation/components/app_snackbar.dart';
import 'package:look_back/entities/models/memory.dart';
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

  /// Tenta interpretar [selectedLocation] no formato "latitude,longitude".
  /// Retorna null se o texto não estiver nesse formato.
  ({double latitude, double longitude})? _parseLocation(String? location) {
    if (location == null) return null;

    final parts = location.split(',');
    if (parts.length != 2) return null;

    final latitude = double.tryParse(parts[0].trim());
    final longitude = double.tryParse(parts[1].trim());
    if (latitude == null || longitude == null) return null;

    return (latitude: latitude, longitude: longitude);
  }

  Future<void> saveMemory(BuildContext context) async {
    if (titleController.text.trim().isEmpty) {
      AppSnackBar.showError(context, 'Adicione um título para a sua lembrança.');
      return;
    }

    setSaving(true);

    try {
      final resolvedAudioPath = _audioPath ?? selectedAudio?.path;
      final coordinates = _parseLocation(selectedLocation);

      final memory = Memory(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        imagePath: selectedImage?.path,
        audioPath: resolvedAudioPath,
        latitude: coordinates?.latitude,
        longitude: coordinates?.longitude,
        createdAt: DateTime.now(),
      );

      await storageService.createMemory(memory);

      if (!context.mounted) return;

      AppSnackBar.showSuccess(context, 'Lembrança criada com sucesso!');

      Navigator.of(context).maybePop();
    } catch (_) {
      if (!context.mounted) return;
      AppSnackBar.showError(context, 'Não foi possível salvar a lembrança.');
    } finally {
      setSaving(false);
    }
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