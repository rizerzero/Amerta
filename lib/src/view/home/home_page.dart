import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import 'widgets/home_header_content.dart';
import 'widgets/transaction_debt_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HomeHeaderContent(),
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
