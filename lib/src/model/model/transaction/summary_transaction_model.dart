import 'package:equatable/equatable.dart';

import '../people/people_model.dart';

class SummaryTransactionModel extends Equatable {
  const SummaryTransactionModel({
    required this.people,
    this.totalHutang = 0,
    this.totalPiutang = 0,
  });

  final PeopleModel people;
  final int totalHutang;
  final int totalPiutang;
  @override
  List<Object> get props => [people, totalHutang, totalPiutang];

  @override
  String toString() =>
      'SummaryTransactionModel(people: $people, totalHutang: $totalHutang, totalPiutang: $totalPiutang)';

  SummaryTransactionModel copyWith({
    PeopleModel? people,
    int? totalHutang,
    int? totalPiutang,
  }) {
    return SummaryTransactionModel(
      people: people ?? this.people,
      totalHutang: totalHutang ?? this.totalHutang,
      totalPiutang: totalPiutang ?? this.totalPiutang,
    );
  }
}
