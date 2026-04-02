import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:texi_passenger/core/lang/extension_lang.dart';
import 'package:texi_passenger/core/utils/position_services.dart';
import 'package:texi_passenger/core/widgets/elevated_button_widget.dart';

class LocationPermissions extends ConsumerStatefulWidget {
  const LocationPermissions({super.key});

  @override
  ConsumerState<LocationPermissions> createState() => _LocationPermissionsState();
}

class _LocationPermissionsState extends ConsumerState<LocationPermissions> {
  late Timer _timer;
  late DateTime _endTime;
  int _secondsRemaining = 30;

  @override
  void initState() {
    super.initState();
    _endTime = DateTime.now().add(const Duration(seconds: 30));
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      final difference = _endTime.difference(now).inSeconds;

      if (difference <= 0) {
        timer.cancel();
        SystemNavigator.pop();
      } else {
        if (mounted) {
          setState(() {
            _secondsRemaining = difference;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_off_rounded,
                size: 30.w,
                color: Theme.of(context).colorScheme.error,
              ),
              SizedBox(height: 3.h),
              Text(
                locationPermissionTitle.i18n,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 2.h),
              Text(
                locationPermissionMessage.i18n,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4.h),
              ElevatedButtonWidget(
                label: openSettings.i18n,
                onPressed: () async {
                  await PositionServices().openAppSettings();
                },
              ),
              SizedBox(height: 4.h),
              Text(
                appWillCloseIn.i18n.replaceAll('%s', _secondsRemaining.toString()),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                      fontWeight: FontWeight.w600,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
