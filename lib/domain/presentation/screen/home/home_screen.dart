import 'package:flutter/material.dart';
import 'package:look_back/domain/presentation/components/memory_cards/audio_memory_card.dart';
import 'package:look_back/domain/presentation/components/memory_cards/image_memory_card.dart';
import 'package:look_back/domain/presentation/components/memory_cards/location_memory_card.dart';
import 'package:look_back/domain/presentation/components/memory_cards/text_memory_card.dart';
import 'package:look_back/domain/presentation/screen/home/home_state.dart';
import 'package:look_back/domain/presentation/screen/register_memory/register_memory_screen.dart';
import 'package:look_back/entities/models/memory.dart';
import 'package:provider/provider.dart';

const _monthNames = [
  'January', 'February', 'March', 'April', 'May', 'June',
  'July', 'August', 'September', 'October', 'November', 'December',
];

String _timeLabel(DateTime dateTime) {
  final hour24 = dateTime.hour;
  final period = hour24 >= 12 ? 'PM' : 'AM';
  final hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
  final minute = dateTime.minute.toString().padLeft(2, '0');
  return '$hour12:$minute $period';
}

String _greeting(DateTime now) {
  if (now.hour < 12) return 'Good morning';
  if (now.hour < 18) return 'Good afternoon';
  return 'Good evening';
}

Widget _memoryCard(Memory memory) {
  final time = _timeLabel(memory.createdAt);

  if (memory.imagePath != null && memory.imagePath!.isNotEmpty) {
    return ImageMemoryCard(
      imagePath: memory.imagePath!,
      description: memory.description,
      time: time,
    );
  }

  if (memory.audioPath != null && memory.audioPath!.isNotEmpty) {
    return AudioMemoryCard(
      time: time,
      onTap: () {
      },
    );
  }

  if (memory.latitude != null && memory.longitude != null) {
    return LocationMemoryCard(
      latitude: memory.latitude!,
      longitude: memory.longitude!,
      locationName: memory.description,
      time: time,
      onTap: () {
      },
    );
  }

  return TextMemoryCard(
    text: memory.title,
    time: time,
    onTap: () {
    },
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeState(),
      child: const HomeScreenContent(),
    );
  }
}

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeState>().loadMemories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final now = DateTime.now();

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: CircleAvatar(
            backgroundColor: theme.colorScheme.primary,
            child: Icon(Icons.person, color: theme.colorScheme.onPrimary),
          ),
        ),
        title: Text('Lookback', style: theme.textTheme.headlineMedium),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: Consumer<HomeState>(
        builder: (context, state, _) {
          return RefreshIndicator(
            onRefresh: () => state.loadMemories(),
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_greeting(now)}, User!',
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your journey starts here.',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.75),
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (state.isLoading)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    else ...[
                      if (state.errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            state.errorMessage!,
                            style: theme.textTheme.bodySmall
                                ?.copyWith(color: theme.colorScheme.error),
                          ),
                        ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              constraints: const BoxConstraints(minHeight: 85),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surface,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: theme.colorScheme.outline,
                                  width: 0.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        theme.colorScheme.shadow.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 6),
                                        Text(
                                          '${state.streakDays}',
                                          style: theme.textTheme.titleLarge
                                              ?.copyWith(fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Days streak',
                                          style: theme.textTheme.bodyMedium?.copyWith(
                                            color: theme.colorScheme.onSurface
                                                .withOpacity(0.7),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              constraints: const BoxConstraints(minHeight: 85),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surface,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: theme.colorScheme.outline,
                                  width: 0.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        theme.colorScheme.shadow.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 6),
                                        Text(
                                          '${state.memoriesCount}',
                                          style: theme.textTheme.titleLarge
                                              ?.copyWith(fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Memories',
                                          style: theme.textTheme.bodyMedium?.copyWith(
                                            color: theme.colorScheme.onSurface
                                                .withOpacity(0.7),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const RegisterMemoryScreen(),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 18,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.primary.withOpacity(0.25),
                                blurRadius: 18,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color:
                                      theme.colorScheme.onPrimary.withOpacity(0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.add_rounded,
                                  color: theme.colorScheme.onPrimary,
                                  size: 26,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Create a new memory',
                                      style: theme.textTheme.titleMedium?.copyWith(
                                        color: theme.colorScheme.onPrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Save your moments now',
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        color: theme.colorScheme.onPrimary
                                            .withOpacity(0.85),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 18,
                                color: theme.colorScheme.onPrimary,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Text(
                            'Today, ${now.day} ${_monthNames[now.month - 1]}',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: theme.colorScheme.onSurface.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (state.todaysMemories.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Center(
                            child: Text(
                              'Nenhuma memória hoje ainda',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface.withOpacity(0.6),
                              ),
                            ),
                          ),
                        )
                      else
                        for (final memory in state.todaysMemories) ...[
                          _memoryCard(memory),
                          const SizedBox(height: 12),
                        ],
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}