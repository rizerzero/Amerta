import 'utils.dart';

extension AppBottomNavigationMenuMenuExt on AppBottomNavigationMenu {
  int toIndex() {
    switch (this) {
      case AppBottomNavigationMenu.home:
        return 0;
      case AppBottomNavigationMenu.people:
        return 1;
      case AppBottomNavigationMenu.setting:
        return 2;
      default:
        return -1;
    }
  }

  bool toBool() {
    return true;
  }
}

extension TransactionTypeExt on TransactionType {
  int toIndex() {
    switch (this) {
      case TransactionType.hutang:
        return 0;
      case TransactionType.piutang:
        return 1;
      default:
        return -1;
    }
  }
}

extension PrintTransactionTypeExt on PrintTransactionType {
  TransactionType toTransactionType() {
    switch (this) {
      case PrintTransactionType.hutang:
        return TransactionType.hutang;
      case PrintTransactionType.piutang:
        return TransactionType.piutang;
      default:
        return TransactionType.piutang;
    }
  }

  String toReadableString() {
    switch (this) {
      case PrintTransactionType.hutang:
        return "Hutang";
      case PrintTransactionType.piutang:
        return "Piutang";
      case PrintTransactionType.hutangDanPiutang:
        return "Hutang & Piutang";
      default:
        return "-";
    }
  }
}
