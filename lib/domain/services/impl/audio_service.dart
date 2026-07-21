import 'dart:async';
import 'dart:io';

import 'package:look_back/domain/services/audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
AudioService newAudioService(){
  return _AudioService();
}
class _AudioService implements AudioService {
  _AudioService();

  final AudioRecorder _recorder = AudioRecorder();

  StreamSubscription<Amplitude>? _amplitudeSubscription;

  void Function(double amplitude)? onAmplitudeChanged;

  Future<bool> get isRecording => _recorder.isRecording();

  Future<bool> hasPermission() async {
    return await _recorder.hasPermission();
  }

  Future<String> startRecording() async {
    if (!await hasPermission()) {
      throw Exception("Permissão para gravar negada.");
    }

    final directory = await getApplicationDocumentsDirectory();

    final audioDirectory = Directory("${directory.path}/audios");

    if (!await audioDirectory.exists()) {
      await audioDirectory.create(recursive: true);
    }

    final path =
        "${audioDirectory.path}/${DateTime.now().millisecondsSinceEpoch}.m4a";

    await _recorder.start(
      const RecordConfig(
        encoder: AudioEncoder.aacLc,
        sampleRate: 44100,
        bitRate: 128000,
      ),
      path: path,
    );

    _listenAmplitude();

    return path;
  }

  Future<String?> stopRecording() async {
    await _amplitudeSubscription?.cancel();
    _amplitudeSubscription = null;

    return await _recorder.stop();
  }

  Future<void> cancelRecording() async {
    final path = await stopRecording();

    if (path != null) {
      final file = File(path);

      if (await file.exists()) {
        await file.delete();
      }
    }
  }

  void _listenAmplitude() {
    _amplitudeSubscription?.cancel();

    _amplitudeSubscription = _recorder
        .onAmplitudeChanged(const Duration(milliseconds: 100))
        .listen((Amplitude amplitude) {
      onAmplitudeChanged?.call(amplitude.current);
    });
  }

  Future<void> dispose() async {
    await _amplitudeSubscription?.cancel();
    await _recorder.dispose();
  }

}