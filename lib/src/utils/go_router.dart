import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'utils.dart';

const splashRouteNamed = 'splash';
const appRouteNamed = 'welcome';
const homeRouteNamed = 'home';
const settingRouteNamed = 'setting';
const peopleRouteNamed = 'people';

enum AppBottomNavigationMenu { home, people, setting, unknown }

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

final goRouter = Provider<GoRouter>((ref) {
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/splash',
    redirect: (state) => null,
    errorBuilder: (ctx, state) {
      return const Scaffold(
        body: Center(
          child: Text("error"),
        ),
      );
    },
    routes: [
      GoRoute(
        path: "/splash",
        name: splashRouteNamed,
        builder: (ctx, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/app',
        name: appRouteNamed,

        /// [0]  = Home
        /// [1]  = People
        /// [2]  = Setting
        redirect: (state) => "/app/${AppBottomNavigationMenu.home.toStr()}",
        routes: [
          GoRoute(
            path: ":section",
            builder: (ctx, state) {
              final param = state.params['section'];
              return WelcomePage(
                appBottomNavigationMenu: AppBottomNavigationMenu.values.firstWhere(
                  (element) => element.toStr() == param,
                  orElse: () => AppBottomNavigationMenu.unknown,
                ),
              );
            },
          ),
        ],
      ),
    ],
  );
});

class SplashPage extends StatefulWidget {
  const SplashPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _initApplication();
    });
  }

  Future<void> _initApplication() async {
    await Future.delayed(const Duration(seconds: 2));
    context.goNamed(appRouteNamed);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: primary,
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const HomePage(),
        const PeoplePage(),
        const SettingPage(),
      ].elementAt(_selectedIndex),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(60.0)),
        child: Theme(
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
                  Icons.people_alt_outlined,
                  color: primaryShade2,
                ),
                selectedIcon: Icon(
                  Icons.people_alt,
                  color: Colors.white,
                ),
                label: "People",
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
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Text("home"),
      ),
    );
  }
}

class PeoplePage extends StatelessWidget {
  const PeoplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: const Center(
        child: Text("people"),
      ),
    );
  }
}

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: const Center(
        child: Text("setting"),
      ),
    );
  }
}
