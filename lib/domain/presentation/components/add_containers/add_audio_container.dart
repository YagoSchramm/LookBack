import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:look_back/global.dart';

class AddAudioField extends StatefulWidget {
  const AddAudioField({
    super.key,
    this.onAudioSelected,
    this.initialAudio,
    this.label = 'Adicionar áudio',
  });

  final ValueChanged<File?>? onAudioSelected;
  final File? initialAudio;
  final String label;

  @override
  State<AddAudioField> createState() => _AddAudioFieldState();
}

class _AddAudioFieldState extends State<AddAudioField> {
  File? _audio;

  @override
  void initState() {
    super.initState();
    _audio = widget.initialAudio;
  }

  Future<void> _pickAudio() async {
    final picked = await audioService.pickAudio();
    if (picked == null) return;

    setState(() => _audio = picked);
    widget.onAudioSelected?.call(_audio);
  }

  void _removeAudio() {
    setState(() => _audio = null);
    widget.onAudioSelected?.call(null);
  }

  void _openSourceSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Adicionar áudio'),
        message: const Text('Escolha um áudio para a sua lembrança'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              _pickAudio();
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.waveform),
                SizedBox(width: 8),
                Text('Escolher áudio'),
              ],
            ),
          ),
          if (_audio != null)
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context);
                _removeAudio();
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.trash),
                  SizedBox(width: 8),
                  Text('Remover áudio'),
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
              CupertinoIcons.waveform,
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
            if (_audio != null) ...[
              Expanded(
                child: Text(
                  _audio!.path.split(Platform.pathSeparator).last,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ] else
              Text(
                'Nenhum áudio',
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
