import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../view/form_transaction/form_transaction_page.dart';
import '../view/people_detail/people_detail_page.dart';
import '../view/people_transaction/people_transaction_page.dart';
import '../view/peoples_summary/peoples_summary_page.dart';
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
const peoplesSummaryRouteNamed = 'peoples-summary';

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
          builder: (ctx, state) => const WelcomePage(
            appBottomNavigationMenu: AppBottomNavigationMenu.home,
          ),
          routes: [
            /// [/app/peoples-summary]
            GoRoute(
              path: "peoples-summary",
              name: peoplesSummaryRouteNamed,
              builder: (ctx, state) => const PeoplesSummaryPage(),
              routes: [
                /// [/app/peoples-summary/:peopleId/transaction]
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
                final transactionId = state.params['transactionId'];
                return FormTransactionPage(transactionId: transactionId);
              },
            )
          ],
        ),
      ],
    );
  },
);
