import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class FormatNumberTextField extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    try {
      /// When textfield is empty , set default text [0] and [cursor position] index to [1]
      if (newValue.text.isEmpty) {
        return newValue.copyWith(
          text: "0",
          selection: const TextSelection.collapsed(offset: 1),
        );
      }

      /// Initialize [numberFormat]
      final format = NumberFormat();
      final separator = format.symbols.GROUP_SEP;

      int selectedPositionIndex = newValue.selection.end;

      final oldValueText = oldValue.text.replaceAll(separator, "");
      String newValueText = newValue.text.replaceAll(separator, "");

      if (oldValueText == newValueText) {
        /// Check if character in textfield is reduced or not
        /// If [true] subtract selected position index -1
        final isCharacterReduced = oldValue.text.length > newValue.text.length;
        if (isCharacterReduced) {
          selectedPositionIndex -= 1;
        }

        /// Example : [22,300]
        /// Our cursor active is after character [,]
        /// Went we delete it should be [2,300]
        /// Then we should get character before deleted character [2]
        /// After that, we concate it character after deleted character [300]
        /// Result is ["2" + "300"] = [2300]
        final valueBeforeDeletedCharacter = newValue.text.substring(0, selectedPositionIndex);
        final valueAfterDeletedCharacter = newValue.text.substring(
          newValue.selection.end,
          newValue.text.length,
        );

        newValueText = valueBeforeDeletedCharacter + valueAfterDeletedCharacter;
      } else {
        newValueText = newValue.text;
      }

      /// We should  get current index position from right on [original value]
      final currentSelectionPositionFromRight = newValueText.length - selectedPositionIndex;

      /// Remove separator from [original value]
      final val = int.parse(newValueText.replaceAll(separator, ''));
      final formattedValue = format.format(val);
      return TextEditingValue(
        text: formattedValue,
        selection: TextSelection.collapsed(
          offset: formattedValue.length - currentSelectionPositionFromRight,
        ),
      );
    } catch (e) {
      log("error FormatNumberTextField $e");
      return oldValue;
    }
  }
}
