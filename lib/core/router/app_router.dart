import 'package:go_router/go_router.dart';
import 'package:texi_passenger/core/widgets/offline_page.dart';
import 'package:texi_passenger/features/auth/presentation/pages/auth_page.dart';
import 'package:texi_passenger/features/auth/presentation/pages/passenger_profile_page.dart';
import 'package:texi_passenger/features/auth/presentation/pages/verify_code_page.dart';
import 'package:texi_passenger/features/home/presentation/pages/home_page.dart';

class AppRouter {
  static final AppRouter _instance = AppRouter._internal();

  factory AppRouter() {
    return _instance;
  }

  AppRouter._internal();

  static const String authPage = '/auth';
  static const String homePage = '/home';
  static const String verifyCodePage = 'verify-code';
  static const String passengerProfilePage = 'passenger-profile';
  static const String offlinePage = 'offline';

  late final GoRouter router = GoRouter(
    initialLocation: authPage,
    routes: [
      GoRoute(
        path: authPage,
        builder: (context, state) => const AuthPage(),
        routes: [
          GoRoute(
            path: verifyCodePage,
            builder: (context, state) => const VerifyCodePage(),
          ),
          GoRoute(
            path: passengerProfilePage,
            builder: (context, state) => const PassengerProfilePage(),
          ),
        ],
      ),
      GoRoute(path: homePage, builder: (context, state) => const HomePage()),
      GoRoute(
        path: offlinePage,
        builder: (context, state) => const OfflinePage(),
      ),
    ],
  );
}
