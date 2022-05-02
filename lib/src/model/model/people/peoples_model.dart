import 'package:equatable/equatable.dart';

import 'people_model.dart';

class PeoplesModel extends Equatable {
  const PeoplesModel({
    required this.people,
    this.totalTransaksi = 0,
    this.totalHutang = 0,
    this.totalPiutang = 0,
  });

  final PeopleModel people;
  final int? totalTransaksi;
  final int? totalHutang;
  final int? totalPiutang;

  @override
  List<Object?> get props => [people, totalTransaksi, totalHutang, totalPiutang];

  @override
  String toString() {
    return 'PeoplesModel(people: $people, totalTransaksi: $totalTransaksi, totalHutang: $totalHutang, totalPiutang: $totalPiutang)';
  }

  PeoplesModel copyWith({
    PeopleModel? people,
    int? totalTransaksi,
    int? totalHutang,
    int? totalPiutang,
  }) {
    return PeoplesModel(
      people: people ?? this.people,
      totalTransaksi: totalTransaksi ?? this.totalTransaksi,
      totalHutang: totalHutang ?? this.totalHutang,
      totalPiutang: totalPiutang ?? this.totalPiutang,
    );
  }
}
