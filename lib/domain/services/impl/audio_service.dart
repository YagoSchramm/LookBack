import 'dart:io';

import 'package:file_picker/file_picker.dart';

import '../audio.dart';

AudioService newAudioService([FilePicker? picker]) {
  return _AudioService(picker);
}

class _AudioService implements AudioService {
  final FilePicker _picker;

  _AudioService( FilePicker? picker)
      : _picker = picker ?? FilePicker.platform;

  @override
  Future<File?> pickAudio() async {
    final result = await _picker.pickFiles(
      type: FileType.audio,
      allowCompression: false,
    );

    final path = result?.files.single.path;
    if (path == null || path.isEmpty) return null;

    return File(path);
  }

  @override
  Future<File?> pickAudioFromFiles() => pickAudio();
}
