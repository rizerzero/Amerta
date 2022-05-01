import 'package:equatable/equatable.dart';

import 'people_model.dart';

class PeopleCreateOrUpdateResponse extends Equatable {
  const PeopleCreateOrUpdateResponse({
    this.isNewPeople = true,
    this.message = '',
    this.people = const PeopleModel(),
  });

  final bool isNewPeople;
  final String message;
  final PeopleModel people;

  @override
  List<Object> get props => [isNewPeople, message, people];

  @override
  String toString() =>
      'PeopleCreateOrUpdateResponse(isNewPeople: $isNewPeople, message: $message, people: $people)';

  PeopleCreateOrUpdateResponse copyWith({
    bool? isNewPeople,
    String? message,
    PeopleModel? people,
  }) {
    return PeopleCreateOrUpdateResponse(
      isNewPeople: isNewPeople ?? this.isNewPeople,
      message: message ?? this.message,
      people: people ?? this.people,
    );
  }
}
