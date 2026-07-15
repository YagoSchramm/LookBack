import 'package:flutter/foundation.dart';

@immutable
final class Memory {
  final int? id;
  final String title;
  final String description;
  final String? imagePath;
  final String? audioPath;
  final double? latitude;
  final double? longitude;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Memory({
    this.id,
    required this.title,
    required this.description,
    this.imagePath,
    this.audioPath,
    this.latitude,
    this.longitude,
    required this.createdAt,
    this.updatedAt,
  });

  /// Converte Memory → Map (para inserir no DB)
  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image_path': imagePath,
      'audio_path': audioPath,
      'latitude': latitude,
      'longitude': longitude,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  /// Converte Map (do DB) → Memory
  factory Memory.fromMap(Map<String, dynamic> map) {
    return Memory(
      id: map['id'] as int?,
      title: map['title'] as String,
      description: map['description'] as String,
      imagePath: map['image_path'] as String?,
      audioPath: map['audio_path'] as String?,
      latitude: map['latitude'] as double?,
      longitude: map['longitude'] as double?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : null,
    );
  }

  /// Cria uma cópia com campos atualizados
  Memory copyWith({
    int? id,
    String? title,
    String? description,
    String? imagePath,
    String? audioPath,
    double? latitude,
    double? longitude,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Memory(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      audioPath: audioPath ?? this.audioPath,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() =>
      'Memory(id: $id, title: $title, description: $description, createdAt: $createdAt)';
}
