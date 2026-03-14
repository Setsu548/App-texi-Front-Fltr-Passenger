import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

SnackBar customSnackBar(String message, BuildContext context) {
  return SnackBar(
    content: Text(
      message,
      style: TextStyle(
        fontSize: 13.5.sp,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    ),
    backgroundColor: Theme.of(context).colorScheme.primary,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    duration: const Duration(seconds: 4),
  );
}
