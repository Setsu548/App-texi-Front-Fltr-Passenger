import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WaitingDriverWidget extends StatelessWidget {
  const WaitingDriverWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.5),
        ),
        child: Center(
          child: Image.asset(
            'assets/images/loader_image.gif',
            height: 45.h,
            width: 45.w,
          ),
        ),
      ),
    );
  }
}
