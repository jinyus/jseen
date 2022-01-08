import 'package:flutter/material.dart';
import 'package:jseen/theme.dart';

TextStyle mapValueToStyle(dynamic value, JSeenTheme theme) {
  if (value is String) {
    return theme.stringStyle;
  } else if (value is int) {
    return theme.intStyle;
  } else if (value is double) {
    return theme.doubleStyle;
  } else if (value is bool) {
    return theme.boolStyle;
  } else {
    return theme.nullStyle;
  }
}
