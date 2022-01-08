import 'package:flutter/material.dart';
import 'package:jseen/constants.dart';

class JSeenTheme {
  const JSeenTheme({
    this.keyStyle = const TextStyle(color: Colors.orange),
    this.doubleStyle = const TextStyle(color: Colors.blue),
    this.intStyle = const TextStyle(color: Colors.blue),
    this.boolStyle = const TextStyle(color: Colors.green),
    this.stringStyle = const TextStyle(color: Colors.amber),
    this.nullStyle = const TextStyle(color: Colors.redAccent),
    this.closeIcon = const Icon(Icons.chevron_right, size: kIconSize),
    this.openIcon = const RotatedBox(
      quarterTurns: 1,
      child: Icon(Icons.chevron_right, size: kIconSize),
    ),
  });

  /// Style of json Object keys name displaying
  final TextStyle keyStyle;

  /// Style of json Object [double] values displaying
  final TextStyle doubleStyle;

  /// Style of json Object [int] values displaying
  final TextStyle intStyle;

  /// Style of json Object [bool] values displaying
  final TextStyle boolStyle;

  /// Style of json Object [String] values displaying
  final TextStyle stringStyle;

  /// Style of json Object [Null] values displaying
  final TextStyle nullStyle;

  /// This icon is shown when the object's fields are hidden
  final Widget closeIcon;

  /// This icon is shown when the object's fields are shown
  final Widget openIcon;
}
