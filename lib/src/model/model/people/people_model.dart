import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'people_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
@immutable
@HiveType(typeId: 1)
class PeopleModel extends Equatable {
  const PeopleModel({
    this.id = '',
    this.name = '',
    this.imagePath,
    this.createdAt,
    this.updatedAt,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? imagePath;

  @HiveField(3)
  final DateTime? createdAt;

  @HiveField(4)
  final DateTime? updatedAt;

  factory PeopleModel.fromJson(Map<String, dynamic> json) => _$PeopleModelFromJson(json);
  Map<String, dynamic> toJson() => _$PeopleModelToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      name,
      imagePath,
      createdAt,
      updatedAt,
    ];
  }

  @override
  String toString() {
    return 'PeopleModel(id: $id, name: $name, imagePath: $imagePath, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  PeopleModel copyWith({
    String? id,
    String? name,
    String? imagePath,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PeopleModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
