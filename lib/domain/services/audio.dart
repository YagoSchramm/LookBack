import 'dart:io';

abstract class AudioService {
  /// Opens the audio picker and returns the selected file.
  Future<File?> pickAudio();

  /// Opens the device audio picker to select an audio file.
  Future<File?> pickAudioFromFiles() => pickAudio();
}
