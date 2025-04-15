// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String format(String pattern) {
    return DateFormat(pattern).format(this);
  }
}

extension ColorExtension on Color {
  String toHex() {
    return '#${value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }
}

extension StringExtension on String {
  String truncate(int maxLength, {String ellipsis = '...'}) {
    return length <= maxLength ? this : '${substring(0, maxLength)}$ellipsis';
  }
}