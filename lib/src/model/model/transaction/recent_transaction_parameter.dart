import 'package:equatable/equatable.dart';

import '../../../utils/enums.dart';

class RecentTransactionParameter extends Equatable {
  const RecentTransactionParameter({
    required this.type,
    this.limit,
    this.peopleId,
  });

  final TransactionType type;
  final int? limit;
  final String? peopleId;

  @override
  List<Object?> get props => [type, limit, peopleId];

  @override
  String toString() =>
      'RecentTransactionParameter(type: $type, limit: $limit, peopleId: $peopleId)';

  RecentTransactionParameter copyWith({
    TransactionType? type,
    int? limit,
    String? peopleId,
  }) {
    return RecentTransactionParameter(
      type: type ?? this.type,
      limit: limit ?? this.limit,
      peopleId: peopleId ?? this.peopleId,
    );
  }
}
