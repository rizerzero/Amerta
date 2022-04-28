import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'utils/utils.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _goRouter = ref.watch(goRouter);
    final theme = ThemeData();

    return MaterialApp.router(
      title: "Amerta",
      debugShowCheckedModeBanner: false,
      theme: theme.copyWith(
        textTheme: bodyFontTheme(context),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: theme.colorScheme.copyWith(
          primary: primary,
          secondary: secondaryDark,
        ),
      ),
      color: primary,
      routeInformationParser: _goRouter.routeInformationParser,
      routerDelegate: _goRouter.routerDelegate,
    );
  }
}
