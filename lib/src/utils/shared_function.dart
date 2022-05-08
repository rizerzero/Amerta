import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'utils.dart';

class SharedFunction {
  SharedFunction._();
  static final instance = SharedFunction._();

  bool isNullOrEmpty(dynamic val) => [null, ""].contains(val);

  DateTime? dateTimeFromUnix(int? unixtime) {
    if (unixtime == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(unixtime * 1000);
  }

  double vw(BuildContext context) => MediaQuery.of(context).size.width;
  double vh(BuildContext context) => MediaQuery.of(context).size.height;
  double vhMinusNavigationBar(BuildContext context) =>
      vh(context) - (const NavigationBarThemeData().height ?? 80.0);
  double notchTop(BuildContext context) => MediaQuery.of(context).padding.top;

  double getPercentage(int value, int from) {
    if (value <= 0) return 0;
    final result = (value * 100) / from;
    return result.roundToDouble();
  }

  InputDecoration defaultInputDecoration = InputDecoration(
    hintText: "Judul",
    hintStyle: bodyFont.copyWith(color: grey),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );

  int? unformatNumber(String number) {
    final format = NumberFormat();
    final separator = format.symbols.GROUP_SEP;

    final result = number.replaceAll(separator, "");
    return int.tryParse(result);
  }

  /// [path] this is sub folder
  /// [filename] this is filename with extension
  Future<String> generatePathFile(String path, String filename) async {
    if (path.isEmpty) {
      throw Exception("Path tidak boleh kosong");
    }

    final defaultPath = (await getApplicationDocumentsDirectory()).path;
    final fullPath = defaultPath + "/" + path;
    final dir = Directory(fullPath);

    /// Jika belum ada foldernya, buatin foldernya
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }

    return fullPath + "/" + filename;
  }

  String rupiahCurrency(
    int number, {
    String? prefix,
    String? locale,
  }) =>
      NumberFormat.simpleCurrency(
        locale: locale ?? "id_ID",
        decimalDigits: 0,
        name: prefix,
      ).format(number);

  Future<DateTime?> showDateTimePicker(BuildContext context, {bool withTimePicker = true}) async {
    final _datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (_datePicker == null) return null;

    if (withTimePicker) {
      final _timePicker = await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (_timePicker != null) {
        return _datePicker.add(Duration(hours: _timePicker.hour, minutes: _timePicker.minute));
      }
    }

    return _datePicker;
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
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
