import 'package:equatable/equatable.dart';

import 'people_model.dart';

class PeopleFormParameter extends Equatable {
  const PeopleFormParameter({
    required this.people,
  });

  final PeopleModel people;

  @override
  List<Object> get props => [people];

  @override
  String toString() => 'PeopleFormParameter(people: $people)';

  PeopleFormParameter copyWith({
    PeopleModel? people,
  }) {
    return PeopleFormParameter(
      people: people ?? this.people,
    );
  }
}
