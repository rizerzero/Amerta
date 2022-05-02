import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../view/form_transaction/form_transaction_page.dart';
import '../view/people_detail/people_detail_page.dart';
import '../view/people_transaction/people_transaction_page.dart';
import '../view/peoples/peoples_page.dart';
import '../view/splash/splash_page.dart';
import '../view/welcome/welcome_page.dart';
import 'utils.dart';

const splashRouteNamed = 'splash';
const appRouteNamed = 'welcome';

/// people Section
const peopleFormNewRouteNamed = 'people-form-new';
const peopleFormEditRouteNamed = 'people-form-edit';
const peopleTransactionRouteNamed = 'people-transaction';
const peopleDetailRouteNamed = 'people-detail';
const peopleListRouteNamed = 'people-list';

/// Transaction Section
const transactionFormNewRouteNamed = 'transaction-form-new';
const transactionFormEditRouteNamed = 'transaction-form-edit';

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
          /// [1]  = Setting
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
          path: "/people",
          name: peopleListRouteNamed,
          builder: (ctx, state) => const PeoplesPage(),
          routes: [
            /// [people/$peopleId/transaction]
            GoRoute(
              path: ':peopleId/transaction',
              name: peopleDetailRouteNamed,
              builder: (ctx, state) {
                final peopleId = state.params['peopleId'] ?? "-";
                return PeopleDetailPage(peopleId: peopleId);
              },
              routes: [
                /// [people/$peopleId/transaction/$transactionId]
                GoRoute(
                  path: ":transactionId",
                  name: peopleTransactionRouteNamed,
                  builder: (ctx, state) {
                    final transactionId = state.params["transactionId"] ?? "-";
                    final peopleId = state.params['peopleId'] ?? "-";

                    return PeopleTransactionPage(
                      transactionId: transactionId,
                      peopleId: peopleId,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: "/transaction/form",
          name: transactionFormNewRouteNamed,
          redirect: (state) => "/transaction/form/new",
          routes: [
            GoRoute(
              path: ":transactionId",
              name: transactionFormEditRouteNamed,
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
