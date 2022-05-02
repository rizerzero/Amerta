import 'package:equatable/equatable.dart';

class PeopleTopTenModel extends Equatable {
  const PeopleTopTenModel({
    this.id = '',
    this.name = '',
    this.imagePath,
  });
  final String id;
  final String name;
  final String? imagePath;

  @override
  List<Object?> get props => [id, name, imagePath];

  @override
  String toString() => 'PeopleTopTenModel(id: $id, name: $name, imagePath: $imagePath)';

  PeopleTopTenModel copyWith({
    String? id,
    String? name,
    String? imagePath,
  }) {
    return PeopleTopTenModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
