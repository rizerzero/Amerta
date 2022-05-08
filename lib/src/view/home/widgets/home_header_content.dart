import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection.dart';
import '../../../model/model/people/people_top_ten_model.dart';
import '../../../utils/utils.dart';
import '../../../view_model/people/people_latest_ten_notifier.dart';
import 'summary_amount.dart';

part 'home_people_item.dart';

class HomeHeaderContent extends StatelessWidget {
  const HomeHeaderContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;

        final isCollapse = height <= kToolbarHeight + fn.notchTop(context);
        return FlexibleSpaceBar(
          titlePadding: EdgeInsets.zero,
          title: Builder(
            builder: (context) {
              if (!isCollapse) return const SizedBox();
              return Container(
                color: primary,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Consumer(
                    builder: (context, ref, child) {
                      final _future = ref.watch(peopleSummaryTransactionNotifier(null));
                      return _future.items.when(
                        data: (data) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Hutang : ${fn.rupiahCurrency(_future.balance(TransactionType.hutang))}",
                                style: bodyFont.copyWith(fontSize: 12.0),
                              ),
                              Text(
                                "Piutang : ${fn.rupiahCurrency(_future.balance(TransactionType.piutang))}",
                                style: bodyFont.copyWith(fontSize: 12.0),
                              ),
                            ],
                          );
                        },
                        error: (error, trace) {
                          return Center(
                            child: Text("$error"),
                          );
                        },
                        loading: () => const Center(child: CircularProgressIndicator()),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          background: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    final _future = ref.watch(peopleSummaryTransactionNotifier(null));
                    return _future.items.when(
                      data: (data) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: SummaryAmount(
                                title: "Hutang",
                                amount: _future.balance(TransactionType.hutang),
                              ),
                            ),
                            const SizedBox(width: 24.0),
                            Expanded(
                              child: SummaryAmount(
                                title: "Piutang",
                                amount: _future.balance(TransactionType.piutang),
                              ),
                            ),
                            const SizedBox(width: 16.0),
                          ],
                        );
                      },
                      error: (error, trace) => Center(child: Text("$error")),
                      loading: () => const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Daftar orang",
                          style: bodyFontWhite.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        InkWell(
                          onTap: () {
                            context.pushNamed(peoplesSummaryRouteNamed);
                          },
                          child: Text(
                            "Selengkapnya",
                            style: bodyFontWhite.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: fn.vh(context) / 5,
                    child: Consumer(
                      builder: (context, ref, child) {
                        final _future = ref.watch(getLatestTenPeople);
                        return _future.when(
                          data: (data) {
                            if (data.isEmpty) {
                              return Center(
                                child: Text(
                                  "Daftar orang masih kosong",
                                  style: headerFontWhite.copyWith(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: data.length,
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              itemBuilder: (ctx, index) {
                                final item = data[index];
                                return _HomePeopleItem(item: item);
                              },
                            );
                          },
                          error: (error, trace) {
                            return Center(child: Text("$error", style: bodyFontWhite));
                          },
                          loading: () => const Center(
                            child: CircularProgressIndicator(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
