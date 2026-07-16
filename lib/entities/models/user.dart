import 'package:flutter/foundation.dart';

@immutable
final class User {
  final int? id;
  final String name;
  final int memoriesCount;
  final bool hasCompletedOnboarding;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const User({
    this.id,
    required this.name,
    this.memoriesCount = 0,
    this.hasCompletedOnboarding = false,
    required this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'name': name,
      'memories_count': memoriesCount,
      'has_completed_onboarding': hasCompletedOnboarding ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int?,
      name: map['name'] as String,
      memoriesCount: map['memories_count'] as int? ?? 0,
      hasCompletedOnboarding: (map['has_completed_onboarding'] as int?) == 1,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : null,
    );
  }

  User copyWith({
    int? id,
    String? name,
    int? memoriesCount,
    bool? hasCompletedOnboarding,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      memoriesCount: memoriesCount ?? this.memoriesCount,
      hasCompletedOnboarding:
          hasCompletedOnboarding ?? this.hasCompletedOnboarding,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() =>
      'User(id: $id, name: $name, memoriesCount: $memoriesCount, hasCompletedOnboarding: $hasCompletedOnboarding)';
}
