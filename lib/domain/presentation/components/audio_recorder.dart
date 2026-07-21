import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:look_back/domain/presentation/screen/register_memory/register_memory_state.dart';
import 'package:provider/provider.dart';

class AudioRecorderBottomSheet extends StatelessWidget {
  const AudioRecorderBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.watch<RegisterMemoryState>();

    final minutes = state.duration.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');

    final seconds = state.duration.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(28),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(99),
              ),
            ),

            const SizedBox(height: 24),

            Icon(
              CupertinoIcons.mic_fill,
              size: 42,
              color: theme.colorScheme.primary,
            ),

            const SizedBox(height: 16),

            Text(
              state.isRecording
                  ? "Gravando..."
                  : "Pronto para gravar",
              style: theme.textTheme.titleLarge,
            ),

            const SizedBox(height: 10),

            Text(
              "$minutes:$seconds",
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 28),

            _Wave(amplitude: state.amplitude),

            const SizedBox(height: 36),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      await state.cancelRecording();

                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.close),
                    label: const Text("Cancelar"),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: FilledButton.icon(
                    onPressed: () async {
                      if (state.isRecording) {
                        await state.stopRecording();

                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      } else {
                        await state.startRecording();
                      }
                    },
                    icon: Icon(
                      state.isRecording
                          ? Icons.stop
                          : Icons.mic,
                    ),
                    label: Text(
                      state.isRecording
                          ? "Finalizar"
                          : "Gravar",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Wave extends StatelessWidget {
  const _Wave({
    required this.amplitude,
  });

  final double amplitude;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final value = ((amplitude + 60) / 60).clamp(0.15, 1.0);

    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(25, (index) {
          final factor =
              (index.isEven ? 1.0 : .7) * value;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 80),
              width: 4,
              height: 10 + (40 * factor),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          );
        }),
      ),
    );
  }
}