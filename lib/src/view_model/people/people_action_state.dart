part of 'people_action_notifier.dart';

class PeopleActionState extends Equatable {
  const PeopleActionState({
    this.deleteAsync = const AsyncData(null),
    this.insertOrUpdateAsync = const AsyncData(null),
  });
  final AsyncValue<int?> deleteAsync;
  final AsyncValue<PeopleInsertOrUpdateResponse?> insertOrUpdateAsync;

  @override
  List<Object> get props => [deleteAsync, insertOrUpdateAsync];

  @override
  String toString() =>
      'PeopleActionState(deleteAsync: $deleteAsync, insertOrUpdateAsync: $insertOrUpdateAsync)';

  PeopleActionState copyWith({
    AsyncValue<int?>? deleteAsync,
    AsyncValue<PeopleInsertOrUpdateResponse?>? insertOrUpdateAsync,
  }) {
    return PeopleActionState(
      deleteAsync: deleteAsync ?? this.deleteAsync,
      insertOrUpdateAsync: insertOrUpdateAsync ?? this.insertOrUpdateAsync,
    );
  }
}
