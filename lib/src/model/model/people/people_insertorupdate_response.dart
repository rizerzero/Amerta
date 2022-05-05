import 'package:equatable/equatable.dart';

class PeopleInsertOrUpdateResponse extends Equatable {
  const PeopleInsertOrUpdateResponse({
    this.message = '',
    this.isNewPeople = false,
  });

  final String message;
  final bool isNewPeople;

  @override
  List<Object> get props => [message, isNewPeople];

  @override
  String toString() => 'PeopleInsertOrUpdateResponse(message: $message, isNewPeople: $isNewPeople)';

  PeopleInsertOrUpdateResponse copyWith({
    String? message,
    bool? isNewPeople,
  }) {
    return PeopleInsertOrUpdateResponse(
      message: message ?? this.message,
      isNewPeople: isNewPeople ?? this.isNewPeople,
    );
  }
}
