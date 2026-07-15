class MemoryTable {
  static const String tableName = 'memories';

  // Colunas definidas como constantes para reutilização
  static const String columnID = 'id';
  static const String columnTitle = 'title';
  static const String columnDescription = 'description';
  static const String columnImagePath = 'image_path';
  static const String columnAudioPath = 'audio_path';
  static const String columnLatitude = 'latitude';
  static const String columnLongitude = 'longitude';
  static const String columnCreatedAt = 'created_at';
  static const String columnUpdatedAt = 'updated_at';

  static String createMemoryTable() => '''
    CREATE TABLE $tableName (
      $columnID          INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnTitle       TEXT     NOT NULL,
      $columnDescription TEXT     NOT NULL,
      $columnImagePath   TEXT,
      $columnAudioPath   TEXT,
      $columnLatitude    REAL,
      $columnLongitude   REAL,
      $columnCreatedAt   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
      $columnUpdatedAt   DATETIME
    );
  ''';
}
