import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';

class PeoplesModel extends Equatable {
  const PeoplesModel({
    this.peopleId = '',
    this.name = '',
    this.imagePath = '',
    this.createdAt,
    this.updatedAt,
    this.totalTransaksi = 0,
    this.totalHutang = 0,
    this.totalPiutang = 0,
  });

  final String peopleId;
  final String name;
  final String imagePath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int totalTransaksi;
  final int totalHutang;
  final int totalPiutang;

  factory PeoplesModel.fromQueryRow(QueryRow row) {
    return PeoplesModel(
      peopleId: row.read("id"),
      name: row.read("name"),
      totalHutang: row.read("total_hutang"),
      totalPiutang: row.read("total_piutang"),
      imagePath: row.read("image_path"),
      totalTransaksi: row.read("total_transaksi"),
    );
  }

  @override
  List<Object?> get props {
    return [
      peopleId,
      name,
      imagePath,
      createdAt,
      updatedAt,
      totalTransaksi,
      totalHutang,
      totalPiutang,
    ];
  }

  @override
  String toString() {
    return 'PeoplesModel(peopleId: $peopleId, name: $name, imagePath: $imagePath, createdAt: $createdAt, updatedAt: $updatedAt, totalTransaksi: $totalTransaksi, totalHutang: $totalHutang, totalPiutang: $totalPiutang)';
  }

  PeoplesModel copyWith({
    String? peopleId,
    String? name,
    String? imagePath,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? totalTransaksi,
    int? totalHutang,
    int? totalPiutang,
  }) {
    return PeoplesModel(
      peopleId: peopleId ?? this.peopleId,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      totalTransaksi: totalTransaksi ?? this.totalTransaksi,
      totalHutang: totalHutang ?? this.totalHutang,
      totalPiutang: totalPiutang ?? this.totalPiutang,
    );
  }
}
