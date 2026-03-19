import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_extension.dart';
import 'package:sizer/sizer.dart';
import 'package:texi_passenger/core/router/app_router.dart';
import 'package:texi_passenger/core/theme/app_theme.dart';
import 'package:texi_passenger/core/widgets/app_connection_listener.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return MaterialApp.router(
          title: 'Texi Passenger',
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter().router,
          builder: (context, child) {
            return AppConnectionListener(child: child!);
          },
          theme: AppTheme.lightTheme,
          locale: I18n.locale,
          localizationsDelegates: I18n.localizationsDelegates,
          supportedLocales: I18n.supportedLocales,
        );
      },
    );
  }
}
