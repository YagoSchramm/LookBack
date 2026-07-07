import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// iOS (ios/Runner/Info.plist), adicione:
///   <key>NSCameraUsageDescription</key>
///   <string>Usamos a câmera para adicionar fotos às suas lembranças.</string>
///   <key>NSPhotoLibraryUsageDescription</key>
///   <string>Usamos sua galeria para adicionar fotos às suas lembranças.</string>
///
/// Android (android/app/src/main/AndroidManifest.xml), adicione dentro de <manifest>:
///   <uses-permission android:name="android.permission.CAMERA" />
class AddImageField extends StatefulWidget {
  const AddImageField({
    super.key,
    this.onImageSelected,
    this.initialImage,
    this.label = 'Adicionar foto',
  });
 
  final ValueChanged<File?>? onImageSelected;
  final File? initialImage;
  final String label;
 
  @override
  State<AddImageField> createState() => _AddImageFieldState();
}
 
class _AddImageFieldState extends State<AddImageField> {
  File? _image;
  final _picker = ImagePicker();
 
  @override
  void initState() {
    super.initState();
    _image = widget.initialImage;
  }
 
  Future<void> _pickImage(ImageSource source) async {
    final picked = await _picker.pickImage(
      source: source,
      imageQuality: 85,
      maxWidth: 2000,
    );
    if (picked == null) return;
 
    setState(() => _image = File(picked.path));
    widget.onImageSelected?.call(_image);
  }
 
  void _removeImage() {
    setState(() => _image = null);
    widget.onImageSelected?.call(null);
  }
 
  void _openSourceSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Adicionar foto'),
        message: const Text('Escolha de onde a imagem vai vir'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.photo_on_rectangle),
                SizedBox(width: 8),
                Text('Tirar foto'),
              ],
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.photo),
                SizedBox(width: 8),
                Text('Escolher da galeria'),
              ],
            ),
          ),
          if (_image != null)
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context);
                _removeImage();
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.trash),
                  SizedBox(width: 8),
                  Text('Remover foto'),
                ],
              ),
            ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
      ),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
 
    return GestureDetector(
      onTap: () => _openSourceSheet(context),
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.colorScheme.onSecondary),
        ),
        child: Row(
          children: [
            Icon(
              CupertinoIcons.photo,
              color: theme.colorScheme.primary,
              size: 22,
            ),
            const SizedBox(width: 12),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const Spacer(),
            if (_image != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.file(
                  _image!,
                  width: 32,
                  height: 32,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
            ] else
              Text(
                'Nenhuma foto',
                style: TextStyle(
                  fontSize: 14,
                  color: theme.colorScheme.onSurface.withOpacity(0.4),
                ),
              ),
            const SizedBox(width: 4),
            Icon(
              CupertinoIcons.chevron_right,
              color: theme.colorScheme.onSurface.withOpacity(0.4),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}