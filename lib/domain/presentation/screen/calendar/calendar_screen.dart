import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:look_back/domain/presentation/screen/calendar/calendar_state.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:look_back/entities/models/memory.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalendarState(),
      child: const CalendarScreenContent(),
    );
  }
}

class CalendarScreenContent extends StatefulWidget {
  const CalendarScreenContent({super.key});

  @override
  State<CalendarScreenContent> createState() => _CalendarScreenContentState();
}

class _CalendarScreenContentState extends State<CalendarScreenContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CalendarState>().loadMemories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text('LookBack', style: theme.textTheme.headlineLarge),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: Consumer<CalendarState>(
        builder: (context, state, _) {
          return RefreshIndicator(
            onRefresh: () => state.loadMemories(),
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      SizedBox(height: 8),
                      Row(
                        children: [
                          SizedBox(width: 12),
                          Text(
                            'Memory calendar',
                            style: theme.textTheme.headlineSmall,
                          ),
                        ],
                      ),
                      Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        color: theme.colorScheme.surfaceContainerHighest,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: TableCalendar<Memory>(
                            firstDay: DateTime(2000, 1, 1),
                            lastDay: DateTime(2100, 12, 31),
                            focusedDay: state.focusedDay,
                            selectedDayPredicate: (day) =>
                                isSameDay(state.selectedDay, day),
                            onDaySelected: (selected, focused) {
                              state.selectDay(selected, focused);
                            },
                            onPageChanged: (focused) {
                              state.changeFocusedDay(focused);
                            },
                            locale: 'pt_BR',
                            calendarFormat: CalendarFormat.month,
                            availableCalendarFormats: const {
                              CalendarFormat.month: 'Mês'
                            },
                            headerStyle: HeaderStyle(
                              formatButtonVisible: false,
                              titleCentered: true,
                              titleTextStyle:
                                  theme.textTheme.titleMedium ?? const TextStyle(),
                              leftChevronIcon: Icon(Icons.chevron_left,
                                  color: theme.colorScheme.onSurface),
                              rightChevronIcon: Icon(Icons.chevron_right,
                                  color: theme.colorScheme.onSurface),
                            ),
                            daysOfWeekStyle: DaysOfWeekStyle(
                              weekdayStyle:
                                  theme.textTheme.bodySmall ?? const TextStyle(),
                              weekendStyle: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.primary) ??
                                  const TextStyle(),
                            ),
                            calendarStyle: CalendarStyle(
                              outsideDaysVisible: false,
                              defaultTextStyle:
                                  theme.textTheme.bodyMedium ?? const TextStyle(),
                              weekendTextStyle: theme.textTheme.bodyMedium
                                      ?.copyWith(color: theme.colorScheme.primary) ??
                                  const TextStyle(),
                              todayDecoration: BoxDecoration(
                                color: theme.colorScheme.primary.withValues(alpha: 0.3),
                                shape: BoxShape.circle,
                              ),
                              todayTextStyle:
                                  TextStyle(color: theme.colorScheme.onSurface),
                              selectedDecoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                              selectedTextStyle:
                                  TextStyle(color: theme.colorScheme.onPrimary),
                              markersMaxCount: 1,
                              markerDecoration: BoxDecoration(
                                color: theme.colorScheme.secondary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            eventLoader: (day) => state.memoriesOnDay(day),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (state.errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            state.errorMessage!,
                            style: theme.textTheme.bodySmall
                                ?.copyWith(color: theme.colorScheme.error),
                          ),
                        ),
                      Expanded(
                        child: state.selectedDayMemories.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(CupertinoIcons.tray,
                                        size: 48,
                                        color: theme.colorScheme.onSurfaceVariant),
                                    const SizedBox(height: 12),
                                    Text(
                                      'Nenhuma memória neste dia',
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                          color: theme.colorScheme.onSurfaceVariant),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.separated(
                                padding: const EdgeInsets.all(12),
                                itemCount: state.selectedDayMemories.length,
                                separatorBuilder: (_, __) => const SizedBox(height: 8),
                                itemBuilder: (context, index) => _MemoryTile(
                                  memory: state.selectedDayMemories[index],
                                  theme: theme,
                                ),
                              ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}

class _MemoryTile extends StatelessWidget {
  final Memory memory;
  final ThemeData theme;

  const _MemoryTile({required this.memory, required this.theme});

  @override
  Widget build(BuildContext context) {
    final hasImage = memory.imagePath != null && memory.imagePath!.isNotEmpty;
    final hasLocation = memory.latitude != null && memory.longitude != null;

    return Card(
      color: theme.colorScheme.surfaceContainerHigh,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // TODO: navegar para a tela de detalhes da memória
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasImage) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(memory.imagePath!),
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 56,
                      height: 56,
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: Icon(Icons.broken_image_outlined,
                          color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            memory.title,
                            style: theme.textTheme.titleSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${memory.createdAt.hour.toString().padLeft(2, '0')}:'
                          '${memory.createdAt.minute.toString().padLeft(2, '0')}',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                    if (memory.description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        memory.description,
                        style: theme.textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    if (memory.audioPath != null && memory.audioPath!.isNotEmpty ||
                        hasLocation) ...[
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          if (memory.audioPath != null &&
                              memory.audioPath!.isNotEmpty) ...[
                            Icon(Icons.mic_none,
                                size: 16, color: theme.colorScheme.primary),
                            const SizedBox(width: 4),
                          ],
                          if (hasLocation)
                            Icon(Icons.location_on_outlined,
                                size: 16, color: theme.colorScheme.primary),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}