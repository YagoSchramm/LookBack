import 'package:look_back/entities/models/memory.dart';

abstract class StorageService {
  /// Cria uma nova memória no banco de dados
  Future<int> createMemory(Memory memory);

  /// Lista todas as memórias
  Future<List<Memory>?> listAllMemories();

  /// Busca uma memória pelo ID
  Future<Memory?> getMemoryById(int id);

  /// Atualiza uma memória existente
  Future<void> updateMemory(Memory memory);

  /// Deleta uma memória pelo ID
  Future<void> deleteMemory(int id);

  /// Busca memórias por título
  Future<List<Memory>?> searchMemoriesByTitle(String title);

  /// Conta o total de memórias
  Future<int> countMemories();

  /// Limpa todas as memórias do banco de dados
  Future<void> deleteAllMemories();
}
