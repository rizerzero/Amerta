import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SharedFunction {
  SharedFunction._();
  static final instance = SharedFunction._();

  double vw(BuildContext context) => MediaQuery.of(context).size.width;
  double vh(BuildContext context) => MediaQuery.of(context).size.height;
  double vhMinusNavigationBar(BuildContext context) =>
      vh(context) - (const NavigationBarThemeData().height ?? 80.0);
  double notchTop(BuildContext context) => MediaQuery.of(context).padding.top;

  final rupiahCurrency = NumberFormat.simpleCurrency(
    locale: "id_ID",
    decimalDigits: 0,
    name: "Rp. ",
  );

  /// currentValue   =  125000
  /// boundaryValue  =  250000
  /// result         =  (currentValue * 100) / boundaryValue
  ///                =  12500000 / 250000
  ///                =  50 %
  double formulaPercentage(double currentValue, double upperValue) =>
      (currentValue * 100) / upperValue;
}

final fn = SharedFunction.instance;
