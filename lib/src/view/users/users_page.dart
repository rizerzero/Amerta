import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/utils.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: primary,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Daftar orang", style: bodyFont.copyWith()),
            Text(
              "Total : 0 Orang",
              style: bodyFont.copyWith(color: Colors.white60, fontSize: 12.0),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        itemCount: 100,
        itemBuilder: (ctx, index) {
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            margin: const EdgeInsets.only(bottom: 16.0),
            child: InkWell(
              onTap: () => context.pushNamed(
                userTransactionRouteNamed,
                params: {
                  "userId": index.toString(),
                },
              ),
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
                            child: Image.asset(
                              kLogo,
                              fit: BoxFit.cover,
                              height: 30,
                              width: 30,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Text(
                          "Zeffry Reynando",
                          style: bodyFont.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        const Spacer(),
                        Text.rich(
                          TextSpan(
                            text: "3x ",
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
                              fn.rupiahCurrency.format(250000),
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
                              fn.rupiahCurrency.format(250000),
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
  }
}
