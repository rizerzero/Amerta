import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../injection.dart';
import '../../utils/utils.dart';
import '../../view_model/people/peoples_summary_notifier.dart';

part 'widgets/appbar.dart';

class PeoplesSummaryPage extends ConsumerWidget {
  const PeoplesSummaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: primary,
      appBar: const _AppBar(),
      body: Builder(
        builder: (context) {
          final future = ref.watch(peoplesSummaryNotifier).items;
          return future.when(
            data: (_) {
              final items = ref.watch(filteredPeoplesSummary);
              return RefreshIndicator(
                onRefresh: () async => ref.invalidate(peoplesSummaryNotifier),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16.0),
                  itemCount: items.length,
                  itemBuilder: (ctx, index) {
                    final item = items[index];
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      margin: const EdgeInsets.only(bottom: 16.0),
                      child: InkWell(
                        onTap: () {
                          context.pushNamed(
                            peopleDetailRouteNamed,
                            params: {"peopleId": item.people.peopleId},
                          );
                        },
                        borderRadius: BorderRadius.circular(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Hero(
                                    tag: index.toString(),
                                    child: ClipOval(
                                      child: Builder(
                                        builder: (context) {
                                          final imageDefault = Image.asset(
                                            kLogo,
                                            fit: BoxFit.cover,
                                            height: 30,
                                            width: 30,
                                          );
                                          if (item.people.imagePath == null) return imageDefault;

                                          return Image.file(
                                            File(item.people.imagePath!),
                                            fit: BoxFit.cover,
                                            width: 30,
                                            height: 30,
                                            errorBuilder: (context, error, trace) => imageDefault,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: Text(
                                      item.people.name,
                                      style: bodyFont.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      text: "${item.totalTransaksi}x ",
                                      children: [
                                        TextSpan(
                                          text: "Transaksi",
                                          style: bodyFont.copyWith(
                                            fontWeight: FontWeight.normal,
                                            color: grey,
                                            fontSize: 8.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    style: bodyFont.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: secondaryDark,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Piutang", style: bodyFont.copyWith(color: grey)),
                                  Card(
                                    color: primary,
                                    margin: EdgeInsets.zero,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        fn.rupiahCurrency(item.totalPiutang ?? 0),
                                        style: bodyFontWhite,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Hutang", style: bodyFont.copyWith(color: grey)),
                                  Card(
                                    color: secondaryDark,
                                    margin: EdgeInsets.zero,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        fn.rupiahCurrency(item.totalHutang ?? 0),
                                        style: bodyFontWhite,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            error: (error, trace) => Center(child: Text("$error")),
            loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
          );
        },
      ),
    );
  }
}
