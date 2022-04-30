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
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;

        final isCollapse = height <= kToolbarHeight + fn.notchTop(context);
        return FlexibleSpaceBar(
          titlePadding: EdgeInsets.zero,
          title: isCollapse
              ? Container(
                  color: primary,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
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
                    ),
                  ),
                )
              : null,
          background: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Expanded(
                      child: SummaryAmount(amount: 0),
                    ),
                    Expanded(
                      child: SummaryAmount(title: "Piutang"),
                    ),
                  ],
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
                            context.pushNamed(userListRouteNamed);
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
            ],
          ),
          // background: Stack(
          //   children: [
          //     Positioned.fill(
          //       child: Align(
          //         alignment: AlignmentDirectional.topStart,
          //         child: Container(
          //           height: mainHeight,
          //           width: width,
          //           decoration: const BoxDecoration(color: primary),
          //           padding: EdgeInsets.only(
          //             top: 16.0,
          //             bottom: mainPaddingBottom,
          //             left: 16.0,
          //             right: 16.0,
          //           ),
          //           child: Row(
          //             children: [
          //               Expanded(
          //                 child: SummaryAmount(amount: 0),
          //               ),
          //               Expanded(
          //                 child: SummaryAmount(title: "Piutang"),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //     Positioned(
          //       height: floatingHeight,
          //       bottom: 0,
          //       left: 0,
          //       right: 0,
          //       child: Column(
          //         mainAxisSize: MainAxisSize.min,
          //         crossAxisAlignment: CrossAxisAlignment.stretch,
          //         children: [
          //           Padding(
          //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //             child: Row(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Text(
          //                   "Daftar orang",
          //                   style: bodyFontWhite.copyWith(
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 12.0,
          //                   ),
          //                   textAlign: TextAlign.right,
          //                 ),
          //                 Text(
          //                   "Selengkapnya",
          //                   style: bodyFontWhite.copyWith(
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 12.0,
          //                   ),
          //                   textAlign: TextAlign.right,
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Expanded(
          //             child: ListView.builder(
          //               scrollDirection: Axis.horizontal,
          //               shrinkWrap: true,
          //               itemCount: 10,
          //               padding: const EdgeInsets.symmetric(vertical: 8.0),
          //               itemBuilder: (ctx, index) {
          //                 if (index == 0) {
          //                   return Card(
          //                     margin: const EdgeInsets.only(right: 16.0, left: 16.0),
          //                     child: InkWell(
          //                       onTap: () {},
          //                       child: const Padding(
          //                         padding: EdgeInsets.all(16.0),
          //                         child: Center(
          //                           child: Icon(Icons.add),
          //                         ),
          //                       ),
          //                     ),
          //                   );
          //                 }

          //                 return SizedBox(
          //                   width: width / 3.5,
          //                   child: Card(
          //                     margin: const EdgeInsets.only(right: 16.0),
          //                     child: InkWell(
          //                       onTap: () {
          //                         context.pushNamed(
          //                           userTransactionRouteNamed,
          //                           params: {
          //                             "userId": index.toString(),
          //                           },
          //                         );
          //                       },
          //                       child: Padding(
          //                         padding: const EdgeInsets.all(16.0),
          //                         child: Column(
          //                           children: [
          //                             Expanded(
          //                               child: Hero(
          //                                 tag: index.toString(),
          //                                 child: const CircleAvatar(),
          //                               ),
          //                             ),
          //                             Expanded(
          //                               child: Align(
          //                                 child: Text(
          //                                   index.isEven
          //                                       ? "zeffry reynando sad ada dsadasd"
          //                                       : "nakia",
          //                                   textAlign: TextAlign.center,
          //                                   maxLines: 2,
          //                                   overflow: TextOverflow.ellipsis,
          //                                   style: bodyFont.copyWith(
          //                                     fontSize: 10.0,
          //                                     color: grey,
          //                                   ),
          //                                 ),
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 );
          //               },
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        );
      },
    );
  }
}
