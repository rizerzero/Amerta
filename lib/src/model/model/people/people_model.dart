import 'package:equatable/equatable.dart';

class PeopleModel extends Equatable {
  const PeopleModel({
    this.peopleId = '',
    this.name = '',
    this.imagePath,
    this.createdAt,
    this.updatedAt,
  });

  final String peopleId;
  final String name;
  final String? imagePath;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props {
    return [
      peopleId,
      name,
      imagePath,
      createdAt,
      updatedAt,
    ];
  }

  @override
  String toString() {
    return 'PeopleModel(peopleId: $peopleId, name: $name, imagePath: $imagePath, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  PeopleModel copyWith({
    String? peopleId,
    String? name,
    String? imagePath,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PeopleModel(
      peopleId: peopleId ?? this.peopleId,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
