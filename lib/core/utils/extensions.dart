import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get screenHeight => MediaQuery.of(this).size.height;

  double get screenWidth => MediaQuery.of(this).size.width;
}

extension StringExt on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension DateTimeExtension on DateTime {
  String get formattedDate {
    return DateFormat.yMMMMEEEEd().format(this);
  }
}
