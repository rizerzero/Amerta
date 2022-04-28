import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'people_model.g.dart';

@HiveType(typeId: 1)
class PeopleModel extends Equatable {
  const PeopleModel({
    this.id = '',
    this.name = '',
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String name;
  final Uint8List? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      image,
      createdAt,
      updatedAt,
    ];
  }

  @override
  String toString() {
    return 'PeopleModel(id: $id, name: $name, image: $image, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  PeopleModel copyWith({
    String? id,
    String? name,
    Uint8List? image,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PeopleModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
