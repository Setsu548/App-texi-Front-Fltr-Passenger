import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class StylesForTexts {
  final BuildContext context;

  StylesForTexts({required this.context});

  TextStyle headerStyle() {
    return TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 22.sp,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle headerStyleSmall() {
    return TextStyle(
      color: Theme.of(context).colorScheme.onSurface,
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle bodyStyle() {
    return TextStyle(
      color: Theme.of(context).colorScheme.onSurface,
      fontSize: 15.15.sp,
      fontWeight: FontWeight.w500,
    );
  }
}
