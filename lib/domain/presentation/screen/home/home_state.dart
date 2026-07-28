import 'package:flutter/material.dart';
import 'package:look_back/domain/presentation/components/memory_cards/audio_memory_card.dart';
import 'package:look_back/domain/presentation/components/memory_cards/image_memory_card.dart';
import 'package:look_back/domain/presentation/components/memory_cards/location_memory_card.dart';
import 'package:look_back/domain/presentation/components/memory_cards/text_memory_card.dart';
import 'package:look_back/entities/models/memory.dart';
import 'package:look_back/global.dart';

const monthNames = [
  'January', 'February', 'March', 'April', 'May', 'June',
  'July', 'August', 'September', 'October', 'November', 'December',
];

class HomeState extends ChangeNotifier {
  HomeState();

  List<Memory> _memories = [];
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  int get memoriesCount => _memories.length;

  int get streakDays {
    if (_memories.isEmpty) return 0;

    final daysWithMemory = _memories
        .map((m) => DateTime(m.createdAt.year, m.createdAt.month, m.createdAt.day))
        .toSet();

    var cursor = DateTime.now();
    cursor = DateTime(cursor.year, cursor.month, cursor.day);

    var streak = 0;
    while (daysWithMemory.contains(cursor)) {
      streak++;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return streak;
  }

  // Retorna um map ordenado do dia mais recente pro mais antigo.
  // A chave é o DateTime zerado (só dia/mês/ano) e o valor é a lista de memórias daquele dia.
  Map<DateTime, List<Memory>> get memoriesByDay {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final result = <DateTime, List<Memory>>{};

    // Inicializa os 6 dias (hoje + 5 anteriores) para garantir a ordem
    for (var i = 0; i < 6; i++) {
      final day = today.subtract(Duration(days: i));
      result[day] = [];
    }

    for (final memory in _memories) {
      final day = DateTime(
        memory.createdAt.year,
        memory.createdAt.month,
        memory.createdAt.day,
      );
      // Só adiciona se o dia estiver dentro da janela dos 6 dias
      if (result.containsKey(day)) {
        result[day]!.add(memory);
      }
    }

    return result;
  }

  String dayLabel(DateTime day) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (day == today) return 'Today, ${day.day} ${monthNames[day.month - 1]}';
    if (day == yesterday) return 'Yesterday, ${day.day} ${monthNames[day.month - 1]}';
    return '${day.day} ${monthNames[day.month - 1]}';
  }

  String greeting(DateTime now) {
    if (now.hour < 12) return 'Good morning';
    if (now.hour < 18) return 'Good afternoon';
    return 'Good evening';
  }

  Widget memoryCard(Memory memory) {
    if (memory.imagePath != null && memory.imagePath!.isNotEmpty) {
      return ImageMemoryCard(
        memory: memory,
        isFromGallery: memory.imagePath!.startsWith('/'),
      );
    }

    if (memory.audioPath != null && memory.audioPath!.isNotEmpty) {
      return AudioMemoryCard(memory: memory);
    }

    if (memory.latitude != null && memory.longitude != null) {
      return LocationMemoryCard(memory: memory);
    }

    return TextMemoryCard(memory: memory);
  }

  Future<void> loadMemories() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final memories = await storageService.listAllMemories();
      _memories = memories ?? [];
    } catch (_) {
      _errorMessage = 'Não foi possível carregar as memórias.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}