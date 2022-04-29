import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'utils.dart';

const splashRouteNamed = 'splash';
const appRouteNamed = 'welcome';

const userTransactionRouteNamed = 'user-transaction';

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
      GoRoute(
        path: '/user/:userId/transaction',
        name: userTransactionRouteNamed,
        builder: (ctx, state) {
          final userId = state.params['userId'] ?? "-";
          return UserTransaction(userId: userId);
        },
      ),
    ],
  );
});

class UserTransaction extends StatelessWidget {
  const UserTransaction({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final String userId;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TransactionType.values.length,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              snap: true,
              floating: true,
              expandedHeight: fn.vh(context) / 2.5,
              backgroundColor: primary,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  final height = constraints.maxHeight;
                  final isCollapse = height <= kToolbarHeight + fn.notchTop(context);
                  return FlexibleSpaceBar(
                    title: isCollapse ? const Text("Zeffry Reynando") : null,
                    background: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Hero(
                              tag: userId,
                              child: const Center(
                                child: CircleAvatar(radius: 40.0),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              "Zeffry Reynando",
                              style: bodyFontWhite.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16.0),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Expanded(
                                    child: HeaderSummaryAmount(),
                                  ),
                                  Expanded(
                                    child: HeaderSummaryAmount(title: "Piutang"),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverTabBarTransactionType(
                tabBar: TabBar(
                  unselectedLabelStyle: bodyFont.copyWith(color: black),
                  unselectedLabelColor: black,
                  indicator: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                  tabs: TransactionType.values
                      .map((e) => Tab(
                            text: toBeginningOfSentenceCase(e.name),
                          ))
                      .toList(),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((ctx, index) {
                return ListTile(
                  title: Text('$index'),
                );
              }, childCount: 1000),
            ),
          ],
        ),
      ),
    );
  }
}

class SliverTabBarTransactionType extends SliverPersistentHeaderDelegate {
  const SliverTabBarTransactionType({
    required this.tabBar,
  });
  final TabBar tabBar;
  @override
  Widget build(BuildContext context, shrinkOffset, overlapsContent) {
    return Container(
      color: scaffoldColor,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        margin: const EdgeInsets.only(top: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        child: tabBar,
      ),
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height + 16.0;

  @override
  double get minExtent => tabBar.preferredSize.height + 16.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

class SplashPage extends StatefulWidget {
  const SplashPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _isLoading = false;
  bool _isError = false;
  String? _message;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _initApplication();
    });
  }

  Future<void> _initApplication() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await Future.delayed(const Duration(seconds: 2));
    } catch (e) {
      setState(() {
        _isError = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });

      if (!_isError) {
        log("good, can be navigate to main screen");
        context.goNamed(appRouteNamed);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Builder(builder: (ctx) {
        if (_isError) {
          return Center(
            child: Text("Error $_message"),
          );
        }
        if (_isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }

        return const SizedBox();
      }),
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

class ModalOptionTile extends StatelessWidget {
  const ModalOptionTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OptionTile(
            title: "Tambah Piutang",
            subtitle: "Kamu ingin memberikan / meminjami uang kamu",
            icon: Icons.money_off_outlined,
            sideColor: Colors.green,
            margin: const EdgeInsets.only(bottom: 16.0),
            onTap: () {
              log("tes");
            },
          ),
          const OptionTile(
            title: "Tambah Hutang",
            subtitle: "Kamu ingin meminjam uang dari seseorang",
            icon: Icons.handshake_outlined,
            sideColor: Colors.deepOrange,
            margin: EdgeInsets.only(bottom: 16.0),
          ),
          const OptionTile(
            title: "Tambah Orang",
            subtitle: "Menambahkan daftar orang yang ingin dipinjami atau meminjami",
            icon: Icons.people_outline,
            sideColor: primary,
            margin: EdgeInsets.only(bottom: 16.0),
          ),
        ],
      ),
    );
  }
}

class OptionTile extends StatelessWidget {
  const OptionTile({
    Key? key,
    this.title = '-',
    this.subtitle = '-',
    this.icon = Icons.home,
    this.sideColor,
    this.margin,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final IconData icon;
  final Color? sideColor;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: sideColor ?? primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4.0),
          bottomLeft: Radius.circular(4.0),
          topRight: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 2.0,
            color: black.withOpacity(.25),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 4.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
          ),
        ),
        child: ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon),
            ],
          ),
          title: Text(
            title,
            style: bodyFont,
          ),
          subtitle: Text(
            subtitle,
            style: bodyFont.copyWith(
              fontSize: 10.0,
              color: grey,
            ),
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
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HeaderContent(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Aktifitas Terbaru",
                    style: bodyFont.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  DefaultTabController(
                    length: TransactionType.values.length,
                    child: Card(
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                      child: TabBar(
                        onTap: (index) {},
                        indicator: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(60.0),
                        ),
                        unselectedLabelColor: grey,
                        tabs: TransactionType.values
                            .map(
                              (e) => Tab(text: e.name.toUpperCase()),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(height: 32.0),
                    shrinkWrap: true,
                    itemCount: 20,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) => const TransactionDebtTile(),
                  ),
                  const SizedBox(height: 100.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionDebtTile extends StatelessWidget {
  const TransactionDebtTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: primary,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                blurRadius: 2.0,
                color: black.withOpacity(.25),
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.only(left: 4.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0).copyWith(
                bottomLeft: const Radius.circular(4.0),
                topLeft: const Radius.circular(4.0),
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              isThreeLine: true,
              title: Text(
                "Buat buka puasa bersama",
                style: bodyFont.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8.0),
                  Text(
                    fn.rupiahCurrency.format(250000),
                    style: bodyFont.copyWith(
                      color: secondaryDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text.rich(
                    TextSpan(
                      text: "Reference : ",
                      children: [
                        const TextSpan(text: "Zeffry Reynando "),
                        TextSpan(
                          text: "#${const Uuid().v4()}",
                          style: bodyFont.copyWith(
                            fontWeight: FontWeight.bold,
                            color: primary,
                          ),
                        ),
                      ],
                    ),
                    style: bodyFont.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 8.0,
                      color: grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: -15,
          right: -15,
          child: RotationTransition(
            turns: const AlwaysStoppedAnimation(45 / 360),
            child: Card(
              color: Colors.deepPurple,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Piutang",
                  style: bodyFont.copyWith(
                    fontSize: 10.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class HeaderContent extends StatelessWidget {
  const HeaderContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: fn.vh(context) / 2.5,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final height = constraints.maxHeight;
          final width = constraints.maxWidth;

          final floatingHeight = height / 2;
          final mainHeight = height - (floatingHeight / 2);
          final mainPaddingBottom = (floatingHeight / 2);

          return Stack(
            children: [
              Positioned.fill(
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Container(
                    height: mainHeight,
                    width: width,
                    decoration: const BoxDecoration(color: primary),
                    padding: EdgeInsets.only(
                      top: 16.0,
                      bottom: mainPaddingBottom,
                      left: 16.0,
                      right: 16.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Expanded(
                          child: HeaderSummaryAmount(),
                        ),
                        Expanded(
                          child: HeaderSummaryAmount(title: "Piutang"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                height: floatingHeight,
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Selengkapnya",
                        style: bodyFontWhite.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 10,
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        itemBuilder: (ctx, index) {
                          if (index == 0) {
                            return Card(
                              margin: const EdgeInsets.only(right: 16.0, left: 16.0),
                              child: InkWell(
                                onTap: () {},
                                child: const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Center(
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              ),
                            );
                          }

                          return SizedBox(
                            width: width / 3.5,
                            child: Card(
                              margin: const EdgeInsets.only(right: 16.0),
                              child: InkWell(
                                onTap: () {
                                  context.pushNamed(
                                    userTransactionRouteNamed,
                                    params: {
                                      "userId": index.toString(),
                                    },
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Hero(
                                          tag: index.toString(),
                                          child: const CircleAvatar(),
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          child: Text(
                                            index.isEven
                                                ? "zeffry reynando sad ada dsadasd"
                                                : "nakia",
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: bodyFont.copyWith(
                                              fontSize: 10.0,
                                              color: grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class HeaderSummaryAmount extends StatelessWidget {
  const HeaderSummaryAmount({
    Key? key,
    this.title = 'Hutang',
    this.amount = 0,
    this.onTap,
  }) : super(key: key);

  final String title;
  final int amount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: bodyFontWhite.copyWith(
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 8.0),
        FittedBox(
          fit: BoxFit.fitWidth,
          child: InkWell(
            onTap: onTap,
            child: Text(
              fn.rupiahCurrency.format(amount),
              style: headerFontWhite.copyWith(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dashed,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PeoplePage extends StatelessWidget {
  const PeoplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
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
      child: Center(
        child: Text("setting"),
      ),
    );
  }
}
