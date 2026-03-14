import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AnotherElevatedButtonWidget extends StatelessWidget {
  final double width;
  final double height;
  final String label;
  final void Function()? onPressed;
  final Widget? iconImageBefore;
  final Widget? iconImageAfter;

  AnotherElevatedButtonWidget({
    super.key,
    required this.label,
    this.onPressed,
    this.iconImageBefore,
    this.iconImageAfter,
    double? width,
    double? height,
  }) : width = width ?? 80.w,
       height = height ?? 5.h;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF1f2937),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        onPressed: onPressed,
        child: iconImageBefore != null || iconImageAfter != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconImageBefore != null ? iconImageBefore! : SizedBox(),
                  if (iconImageBefore != null) SizedBox(width: 1.25.w),
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.75.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (iconImageAfter != null) SizedBox(width: 1.25.w),
                  iconImageAfter != null ? iconImageAfter! : SizedBox(),
                ],
              )
            : Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.75.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
