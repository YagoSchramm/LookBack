import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:look_back/entities/models/memory.dart';
import 'package:look_back/utils/date_formatter.dart';

class AudioMemoryCard extends StatefulWidget {
  const AudioMemoryCard({super.key, required this.memory});

  final Memory memory;

  @override
  State<AudioMemoryCard> createState() => _AudioMemoryCardState();
}

class _AudioMemoryCardState extends State<AudioMemoryCard> {
  late final PlayerController _playerController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _playerController = PlayerController();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    try {
      await _playerController.preparePlayer(
        path: widget.memory.audioPath!,
        shouldExtractWaveform: true,
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _togglePlayback() async {
    if (_playerController.playerState.isPlaying) {
      await _playerController.pausePlayer();
    } else {
      await _playerController.startPlayer();
    }
  }

  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
  }

  Widget _waveform(BuildContext context, {required double height}) {
    final theme = Theme.of(context);

    if (_isLoading) {
      return SizedBox(
        height: height,
        child: Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      );
    }

    return AudioFileWaveforms(
      size: Size(double.infinity, height),
      playerController: _playerController,
      waveformType: WaveformType.fitWidth,
      playerWaveStyle: PlayerWaveStyle(
        fixedWaveColor: theme.colorScheme.primary.withOpacity(0.3),
        liveWaveColor: theme.colorScheme.primary,
        spacing: 6,
        waveThickness: 3,
      ),
    );
  }

  void _showOverlay(BuildContext context) {
    final theme = Theme.of(context);

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Fechar',
      barrierColor: Colors.black.withOpacity(0.85),
      transitionDuration: const Duration(milliseconds: 220),
      transitionBuilder: (context, animation, _, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.95, end: 1.0).animate(animation),
            child: child,
          ),
        );
      },
      pageBuilder: (context, _, __) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Material(
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.memory.title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.memory.description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.75),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _waveform(context, height: 80),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        StreamBuilder<PlayerState>(
                          stream: _playerController.onPlayerStateChanged,
                          builder: (context, snapshot) {
                            final isPlaying =
                                snapshot.data?.isPlaying ?? false;
                            return GestureDetector(
                              onTap: _togglePlayback,
                              child: Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isPlaying
                                      ? Icons.pause_rounded
                                      : Icons.play_arrow_rounded,
                                  color: theme.colorScheme.onPrimary,
                                  size: 30,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 16),
                        Text(
                          formatTime(widget.memory.createdAt),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.5),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => _showOverlay(context),
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: theme.colorScheme.outline.withOpacity(0.12),
          ),
          boxShadow: [
            BoxShadow(
              color: theme.brightness == Brightness.dark
                  ? Colors.black.withOpacity(0.30)
                  : Colors.black.withOpacity(0.08),
              blurRadius: 18,
              spreadRadius: 1,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            StreamBuilder<PlayerState>(
              stream: _playerController.onPlayerStateChanged,
              builder: (context, snapshot) {
                final isPlaying = snapshot.data?.isPlaying ?? false;
                return GestureDetector(
                  onTap: _togglePlayback,
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      color: theme.colorScheme.onPrimary,
                      size: 32,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 18),
            Expanded(child: _waveform(context, height: 48)),
            const SizedBox(width: 18),
            Text(
              formatTime(widget.memory.createdAt),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}