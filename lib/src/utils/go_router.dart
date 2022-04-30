import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../view/form_transaction/form_transaction_page.dart';
import '../view/splash/splash_page.dart';
import '../view/user_transaction/user_transaction_page.dart';
import '../view/welcome/welcome_page.dart';
import 'utils.dart';

const splashRouteNamed = 'splash';
const appRouteNamed = 'welcome';

const userTransactionRouteNamed = 'user-transaction';

const formNewTransactionRouteNamed = 'form-new-transaction';
const formEditTransactionRouteNamed = 'form-edit-transaction';

final goRouter = Provider<GoRouter>(
  (ref) {
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
          path: '/transaction/user/:userId',
          name: userTransactionRouteNamed,
          builder: (ctx, state) {
            final userId = state.params['userId'] ?? "-";
            return UserTransactionPage(userId: userId);
          },
        ),
        GoRoute(
          path: "/transaction/form",
          name: formNewTransactionRouteNamed,
          redirect: (state) => "/transaction/form/new",
          routes: [
            GoRoute(
              path: ":transactionId",
              name: formEditTransactionRouteNamed,
              builder: (ctx, state) {
                // final transactionId = state.params['transactionId']!;
                return const FormTransactionPage();
              },
            )
          ],
        ),
      ],
    );
  },
);
