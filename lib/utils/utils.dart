import 'package:flutter/material.dart';

class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static snackBar(String message, Color color, BuildContext context) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(backgroundColor: color, content: Text(message)));
  }

  String durationToString(int value) {
    Duration minDuration = Duration(minutes: value);
    final hh = (minDuration.inHours).toString().padLeft(2, '0');
    final mm = (minDuration.inMinutes % 60).toString().padLeft(2, '0');
    if (hh == "00") {
      return '$mm min';
    }
    return '$hh h $mm';
  }
}
