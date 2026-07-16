import 'package:look_back/entities/models/memory.dart';
import 'package:look_back/entities/models/user.dart';

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

  /// Cria um novo usuário no banco de dados
  Future<int> createUser(User user);

  /// Lista todos os usuários
  Future<List<User>?> listAllUsers();

  /// Busca um usuário pelo ID
  Future<User?> getUserById(int id);

  /// Atualiza um usuário existente
  Future<void> updateUser(User user);

  /// Deleta um usuário pelo ID
  Future<void> deleteUser(int id);

  /// Conta o total de usuários
  Future<int> countUsers();

  /// Limpa todos os usuários do banco de dados
  Future<void> deleteAllUsers();
}
