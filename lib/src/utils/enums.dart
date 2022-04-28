import 'package:hive/hive.dart';
part 'enums.g.dart';

enum AppBottomNavigationMenu { home, people, setting, unknown }

@HiveType(typeId: 3)
enum TransactionType {
  @HiveField(0)
  hutang,
  @HiveField(1)
  piutang,
  @HiveField(2)
  unknown
}

@HiveType(typeId: 4)
enum PaymentStatus {
  @HiveField(0)
  paidOff,
  @HiveField(1)
  notPaidOff,
  @HiveField(2)
  unknown,
}
