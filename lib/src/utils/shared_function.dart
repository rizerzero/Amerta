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

  Future<DateTime?> showDateTimePicker(
    BuildContext context, {
    bool withTimePicker = true,
  }) async {
    DateTime? _date;
    TimeOfDay? _time;

    final _datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (_datePicker != null) {
      _date = _datePicker;

      if (withTimePicker) {
        final _timePicker = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (_timePicker != null) {
          _time = _timePicker;
        }
      }
    }

    if (withTimePicker) {
      if (_date != null && _time != null) {
        return _date.add(Duration(hours: _time.hour, minutes: _time.minute));
      }
    } else {
      if (_date != null) {
        return _date;
      }
    }

    return null;
  }
}

final fn = SharedFunction.instance;
