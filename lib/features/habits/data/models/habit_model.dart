import 'dart:convert';

class HabitModel {
  final int? id;
  final String? text;
  final String? createdBy;
  final bool? isCollaborative;
  final DateTime? createdAt;

  HabitModel({
    required this.id,
    required this.text,
    required this.createdBy,
    required this.isCollaborative,
    required this.createdAt,
  });

  HabitModel copyWith({
    int? id,
    String? text,
    String? createdBy,
    bool? isCollaborative,
    DateTime? createdAt,
  }) {
    return HabitModel(
      id: id ?? this.id,
      text: text ?? this.text,
      createdBy: createdBy ?? this.createdBy,
      isCollaborative: isCollaborative ?? this.isCollaborative,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': text,
      'created_by': createdBy,
      'is_collaborative': isCollaborative,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  factory HabitModel.fromMap(Map<String, dynamic> map) {
    return HabitModel(
      id: map['id'] as int,
      text: map['name'] as String,
      createdBy: map['created_by'] as String,
      isCollaborative: map['is_collaborative'] as bool,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory HabitModel.fromJson(String source) => HabitModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HabitModel(id: $id, text: $text, createdBy: $createdBy, isCollaborative: $isCollaborative, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HabitModel && other.id == id && other.text == text && other.createdBy == createdBy && other.isCollaborative == isCollaborative && other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ text.hashCode ^ createdBy.hashCode ^ isCollaborative.hashCode ^ createdAt.hashCode;
  }
}
