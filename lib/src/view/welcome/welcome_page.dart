import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../home/home_page.dart';
import '../setting/setting_page.dart';
import 'widgets/modal_option_tile.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({
    Key? key,
    required this.appBottomNavigationMenu,
  }) : super(key: key);

  final AppBottomNavigationMenu appBottomNavigationMenu;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _selectedIndex = AppBottomNavigationMenu.home.toIndex();

  final _pages = [
    const HomePage(),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
            context: context,
            builder: (ctx) => const ModalOptionTile(),
          );
        },
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          navigationBarTheme: NavigationBarThemeData(
            labelTextStyle: MaterialStateProperty.resolveWith(
              (states) {
                /// Ubah warna text jika terselected
                if (states.contains(MaterialState.selected)) {
                  return const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  );
                }
                return null;
              },
            ),
          ),
        ),
        child: NavigationBar(
          onDestinationSelected: (index) => setState(() => _selectedIndex = index),
          backgroundColor: primary,
          selectedIndex: _selectedIndex,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: const [
            NavigationDestination(
              icon: Icon(
                Icons.home_outlined,
                color: primaryShade2,
              ),
              selectedIcon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(
                Icons.settings_outlined,
                color: primaryShade2,
              ),
              selectedIcon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              label: "Setting",
            ),
          ],
        ),
      ),
    );
  }
}
