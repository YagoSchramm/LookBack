import 'package:image_picker/image_picker.dart';

import 'package:look_back/domain/services/impl/audio_service.dart';
import 'package:look_back/domain/services/impl/image_sevice.dart';
import 'package:look_back/domain/services/impl/location_service.dart';
import 'package:look_back/domain/services/impl/theme_service.dart';
import 'package:look_back/domain/services/impl/storage_service.dart';

final imageService = newImageService(ImagePicker());
final audioService = newAudioService();
final locationService = newLocationService();
final storageService = newStorageService();
final themeService = newThemeService();
