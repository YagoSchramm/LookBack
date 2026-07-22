import 'package:flutter/material.dart';
import 'package:look_back/domain/services/storage.dart';
import 'package:look_back/entities/models/memory.dart';
class CalendarState extends ChangeNotifier {
  final StorageService _storageService;

  CalendarState(this._storageService);

  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List<Memory>> _memoriesByDay = {};
  bool _isLoading = false;
  String? _errorMessage;

  DateTime get selectedDay => _selectedDay;
  DateTime get focusedDay => _focusedDay;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Memórias do dia atualmente selecionado.
  List<Memory> get selectedDayMemories =>
      _memoriesByDay[_normalizeDate(_selectedDay)] ?? [];

  DateTime _normalizeDate(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  /// Carrega todas as memórias do banco e as agrupa por dia.
  Future<void> loadMemories() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final memories = await _storageService.listAllMemories();
      final Map<DateTime, List<Memory>> grouped = {};

      if (memories != null) {
        for (final memory in memories) {
          final day = _normalizeDate(memory.createdAt);
          grouped.putIfAbsent(day, () => []).add(memory);
        }
      }

      _memoriesByDay = grouped;
    } catch (_) {
      _errorMessage = 'Não foi possível carregar as memórias.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectDay(DateTime selected, DateTime focused) {
    if (_selectedDay == selected) return;
    _selectedDay = selected;
    _focusedDay = focused;
    notifyListeners();
  }

  void changeFocusedDay(DateTime focused) {
    _focusedDay = focused;
    notifyListeners();
  }

  bool hasMemoriesOnDay(DateTime day) =>
      _memoriesByDay.containsKey(_normalizeDate(day));

  int memoryCountOnDay(DateTime day) =>
      _memoriesByDay[_normalizeDate(day)]?.length ?? 0;
}