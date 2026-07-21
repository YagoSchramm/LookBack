import 'dart:io';

abstract class AudioService {
  Future<bool> hasPermission();

  Future<String> startRecording();

  Future<String?> stopRecording();

  Future<void> cancelRecording();

  void Function(double amplitude)? onAmplitudeChanged;
}
