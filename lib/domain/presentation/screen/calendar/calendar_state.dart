import 'package:flutter/material.dart';
import 'package:look_back/entities/models/memory.dart';
import 'package:look_back/global.dart';

class CalendarState extends ChangeNotifier {
  CalendarState();

  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  List<Memory> _memories = [];
  bool _isLoading = false;
  String? _errorMessage;

  DateTime get selectedDay => _selectedDay;
  DateTime get focusedDay => _focusedDay;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Memórias do dia atualmente selecionado.
  List<Memory> get selectedDayMemories => memoriesOnDay(_selectedDay);

  /// Carrega todas as memórias do banco.
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

  /// Memórias cujo `createdAt` cai no mesmo dia (ano/mês/dia) de [day].
  List<Memory> memoriesOnDay(DateTime day) {
    return _memories
        .where((memory) =>
            memory.createdAt.year == day.year &&
            memory.createdAt.month == day.month &&
            memory.createdAt.day == day.day)
        .toList();
  }

  bool hasMemoriesOnDay(DateTime day) => memoriesOnDay(day).isNotEmpty;

  int memoryCountOnDay(DateTime day) => memoriesOnDay(day).length;
}