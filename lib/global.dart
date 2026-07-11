import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import 'package:look_back/domain/services/impl/audio_service.dart';
import 'package:look_back/domain/services/impl/image_sevice.dart';

final imageService = newImageService(ImagePicker());
final audioService = newAudioService(FilePicker.platform);