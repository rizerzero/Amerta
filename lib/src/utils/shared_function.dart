import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'fonts.dart';

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
  double formulaPercentage(double currentValue, double upperValue) {
    return (currentValue * 100) / upperValue;
  }

  Future<DateTime?> showDateTimePicker(BuildContext context, {bool withTimePicker = true}) async {
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

  Future<File?> takeImage({ImageSource source = ImageSource.gallery}) async {
    final _imagePicker = ImagePicker();
    final _pickedFile = await _imagePicker.pickImage(
      source: source,
      maxHeight: 600,
      maxWidth: 600,
    );
    if (_pickedFile == null) return null;

    final file = File(_pickedFile.path);
    return file;
  }

  void showSnackbar(
    BuildContext context, {
    required String title,
    Color? color,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          title,
          style: bodyFontWhite.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: color,
      ),
    );
  }
}

final fn = SharedFunction.instance;
