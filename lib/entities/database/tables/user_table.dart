class UserTable {
  static const String tableName = 'users';

  static const String columnID = 'id';
  static const String columnName = 'name';
  static const String columnMemoriesCount = 'memories_count';
  static const String columnHasCompletedOnboarding = 'has_completed_onboarding';
  static const String columnCreatedAt = 'created_at';
  static const String columnUpdatedAt = 'updated_at';

  static String createUserTable() => '''
    CREATE TABLE $tableName (
      $columnID                      INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnName                    TEXT NOT NULL,
      $columnMemoriesCount           INTEGER NOT NULL DEFAULT 0,
      $columnHasCompletedOnboarding  INTEGER NOT NULL DEFAULT 0,
      $columnCreatedAt               DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
      $columnUpdatedAt               DATETIME
    );
  ''';
}
