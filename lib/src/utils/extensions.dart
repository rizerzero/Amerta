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
