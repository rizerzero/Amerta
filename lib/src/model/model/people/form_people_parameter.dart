import 'dart:io';

import 'package:equatable/equatable.dart';

class FormPeopleParameter extends Equatable {
  const FormPeopleParameter({
    required this.id,
    required this.name,
    this.image,
    required this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String name;
  final File? image;
  final DateTime createdAt;
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
    return 'FormPeopleParameter(id: $id, name: $name, image: $image, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  FormPeopleParameter copyWith({
    String? id,
    String? name,
    File? image,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FormPeopleParameter(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
