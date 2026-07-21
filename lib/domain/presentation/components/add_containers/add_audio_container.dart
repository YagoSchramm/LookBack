import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddAudioField extends StatelessWidget {
  const AddAudioField({
    super.key,
    required this.onRecord,
    required this.audioPath,
    required this.duration,
    this.onRemove,
    this.label = 'Adicionar áudio',
  });

  final VoidCallback onRecord;
  final VoidCallback? onRemove;

  final String? audioPath;
  final Duration? duration;

  final String label;

  String _formatDuration(Duration? duration) {
    if (duration == null) return "00:00";

    final minutes = duration.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');

    final seconds = duration.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');

    return "$minutes:$seconds";
  }

  void _openSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        title: const Text("Adicionar áudio"),
        message: const Text("Escolha uma opção"),

        actions: [

          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              onRecord();
            },
            child: const Text("Gravar áudio"),
          ),

          if (audioPath != null)
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context);
                onRemove?.call();
              },
              child: const Text("Remover áudio"),
            ),
        ],

        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => _openSheet(context),
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: theme.colorScheme.onSecondary,
          ),
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
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface,
              ),
            ),

            const Spacer(),

            if (audioPath != null)
              Text(
                _formatDuration(duration),
                style: TextStyle(
                  fontSize: 14,
                  color: theme.colorScheme.onSurface.withOpacity(.7),
                ),
              )
            else
              Text(
                "Nenhum áudio",
                style: TextStyle(
                  fontSize: 14,
                  color: theme.colorScheme.onSurface.withOpacity(.4),
                ),
              ),

            const SizedBox(width: 8),

            Icon(
              CupertinoIcons.chevron_right,
              color: theme.colorScheme.onSurface.withOpacity(.4),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}