import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/utils.dart';
import '../../../view_model/people/future_provider.dart';
import '../../../view_model/transaction/future_provider.dart';
import 'summary_amount.dart';

class HomeHeaderContent extends StatelessWidget {
  const HomeHeaderContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;

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
                      final _future = ref.watch(getMySummaryTransaction);
                      return _future.when(
                        data: (data) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Hutang : ${fn.rupiahCurrency.format(250000)}",
                                style: bodyFont.copyWith(fontSize: 12.0),
                              ),
                              Text(
                                "Piutang : ${fn.rupiahCurrency.format(250000)}",
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
                    final _future = ref.watch(getMySummaryTransaction);
                    return _future.when(
                      data: (items) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Expanded(
                              child: SummaryAmount(amount: 0),
                            ),
                            Expanded(
                              child: SummaryAmount(title: "Piutang"),
                            ),
                          ],
                        );
                      },
                      error: (error, trace) {
                        return Center(child: Text("$error"));
                      },
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
                            context.pushNamed(peopleListRouteNamed);
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
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: 10,
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              itemBuilder: (ctx, index) {
                                return SizedBox(
                                  width: width / 3.5,
                                  child: Card(
                                    margin: const EdgeInsets.only(right: 16.0),
                                    child: InkWell(
                                      onTap: () {
                                        context.pushNamed(
                                          peopleDetailRouteNamed,
                                          params: {
                                            "peopleId": index.toString(),
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
