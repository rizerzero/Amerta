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

  String toStr() {
    switch (this) {
      case AppBottomNavigationMenu.home:
        return "home";
      case AppBottomNavigationMenu.people:
        return "people";
      case AppBottomNavigationMenu.setting:
        return "setting";
      default:
        return "-";
    }
  }
}

extension TransactionTypeExt on TransactionType {
  String toStr() {
    switch (this) {
      case TransactionType.hutang:
        return "hutang";
      case TransactionType.piutang:
        return "piutang";
      default:
        return "unknown";
    }
  }

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

extension PaymentStatusExt on PaymentStatus {
  String toStr() {
    switch (this) {
      case PaymentStatus.paidOff:
        return "paid_off";
      case PaymentStatus.notPaidOff:
        return "not_paid_off";
      default:
        return "unknown";
    }
  }
}
