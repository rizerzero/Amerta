import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/utils/colors.dart';
import 'src/utils/fonts.dart';
import 'src/utils/go_router.dart';

/// Hive Type List :
/// 1. People Model
/// 2. Transaction Model
/// 3. TransactionType Enum
/// 4. PaymentStatus Enum

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // turn off the # in the URLs on the web
  GoRouter.setUrlPathStrategy(UrlPathStrategy.path);
  runApp(const ProviderScope(child: App()));
}

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
