import 'package:equatable/equatable.dart';

import 'people_model.dart';

class PeopleSummaryModel extends Equatable {
  const PeopleSummaryModel({
    required this.people,
    required this.totalTransaksi,
    required this.totalHutang,
    required this.totalPiutang,
  });

  final PeopleModel people;
  final int? totalTransaksi;
  final int? totalHutang;
  final int? totalPiutang;

  @override
  List<Object?> get props => [people, totalTransaksi, totalHutang, totalPiutang];

  @override
  String toString() {
    return 'PeopleSummaryModel(people: $people, totalTransaksi: $totalTransaksi, totalHutang: $totalHutang, totalPiutang: $totalPiutang)';
  }

  PeopleSummaryModel copyWith({
    PeopleModel? people,
    int? totalTransaksi,
    int? totalHutang,
    int? totalPiutang,
  }) {
    return PeopleSummaryModel(
      people: people ?? this.people,
      totalTransaksi: totalTransaksi ?? this.totalTransaksi,
      totalHutang: totalHutang ?? this.totalHutang,
      totalPiutang: totalPiutang ?? this.totalPiutang,
    );
  }
}
