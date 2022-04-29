import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/utils.dart';
import 'summary_amount.dart';

class HomeHeaderContent extends StatelessWidget {
  const HomeHeaderContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: fn.vh(context) / 2.5,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final height = constraints.maxHeight;
          final width = constraints.maxWidth;

          final floatingHeight = height / 2;
          final mainHeight = height - (floatingHeight / 2);
          final mainPaddingBottom = (floatingHeight / 2);

          return Stack(
            children: [
              Positioned.fill(
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Container(
                    height: mainHeight,
                    width: width,
                    decoration: const BoxDecoration(color: primary),
                    padding: EdgeInsets.only(
                      top: 16.0,
                      bottom: mainPaddingBottom,
                      left: 16.0,
                      right: 16.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Expanded(
                          child: SummaryAmount(),
                        ),
                        Expanded(
                          child: SummaryAmount(title: "Piutang"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                height: floatingHeight,
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Selengkapnya",
                        style: bodyFontWhite.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 10,
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        itemBuilder: (ctx, index) {
                          if (index == 0) {
                            return Card(
                              margin: const EdgeInsets.only(right: 16.0, left: 16.0),
                              child: InkWell(
                                onTap: () {},
                                child: const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Center(
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              ),
                            );
                          }

                          return SizedBox(
                            width: width / 3.5,
                            child: Card(
                              margin: const EdgeInsets.only(right: 16.0),
                              child: InkWell(
                                onTap: () {
                                  context.pushNamed(
                                    userTransactionRouteNamed,
                                    params: {
                                      "userId": index.toString(),
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
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
