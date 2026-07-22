import 'package:look_back/entities/models/memory.dart';
import 'package:look_back/entities/models/user.dart';

abstract class StorageService {
  /// Create a new memory in the database returning ID.
  Future<int> createMemory(Memory memory);

  /// List all the memories
  Future<List<Memory>?> listAllMemories();

  /// Find memory by the id in the database
  Future<Memory?> getMemoryById(int id);

  /// Update an existing memory in the database
  Future<void> updateMemory(Memory memory);

  /// Deletes the memory by the id in the database
  Future<void> deleteMemory(int id);

  /// Find memories by title in the database
  Future<List<Memory>?> searchMemoriesByTitle(String title);

  /// Count the total of the memories in the database
  Future<int> countMemories();

  /// Delete all the memories in the database
  Future<void> deleteAllMemories();

  /// Create a new user in the database returning ID.
  Future<int> createUser(User user);

  /// Find users by the id in the database
  Future<User?> getUserById(int id);

  /// Updates the user in the database
  Future<void> updateUser(User user);

  /// Delete the user by the id in the database
  Future<void> deleteUser(int id);
}
