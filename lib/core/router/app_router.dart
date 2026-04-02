import 'package:go_router/go_router.dart';
import 'package:texi_passenger/core/router/transitions_helper.dart';
import 'package:texi_passenger/core/widgets/offline_page.dart';
import 'package:texi_passenger/features/auth/presentation/pages/auth_page.dart';
import 'package:texi_passenger/features/auth/presentation/pages/passenger_profile_page.dart';
import 'package:texi_passenger/features/auth/presentation/pages/splash_page.dart';
import 'package:texi_passenger/features/auth/presentation/pages/verify_code_page.dart';
import 'package:texi_passenger/features/home/presentation/pages/home_page.dart';
import 'package:texi_passenger/features/travel/data/models/travel_info_model.dart';
import 'package:texi_passenger/features/travel/presentation/pages/travel_info_page.dart';
import 'package:texi_passenger/features/travel/presentation/widgets/waiting_driver_widget.dart';
import 'package:texi_passenger/core/widgets/offline_position_page.dart';

class AppRouter {
  static final AppRouter _instance = AppRouter._internal();

  factory AppRouter() {
    return _instance;
  }

  AppRouter._internal();

  static const String splashPage = '/';
  static const String authPage = '/auth';
  static const String homePage = '/home';
  static const String verifyCodePage = 'verify-code';
  static const String passengerProfilePage = 'passenger-profile';
  static const String offlinePage = '/offline';
  static const String travelInfoPage = '/travel-info';
  static const String waitingDriverPage = '/waiting-driver';
  static const String offlinePositionPage = '/offline-position';

  late final GoRouter router = GoRouter(
    initialLocation: splashPage,
    routes: [
      GoRoute(
        path: splashPage,
        pageBuilder: (context, state) =>
            TransitionsHelper.fadeTransition(state, const SplashPage()),
      ),
      GoRoute(
        path: authPage,
        pageBuilder: (context, state) =>
            TransitionsHelper.fadeTransition(state, const AuthPage()),
        routes: [
          GoRoute(
            path: verifyCodePage,
            pageBuilder: (context, state) => TransitionsHelper.slideTransition(
              state,
              const VerifyCodePage(),
            ),
          ),
          GoRoute(
            path: passengerProfilePage,
            pageBuilder: (context, state) =>
                TransitionsHelper.slideUpTransition(
                  state,
                  const PassengerProfilePage(),
                ),
          ),
        ],
      ),
      GoRoute(
        path: homePage,
        pageBuilder: (context, state) =>
            TransitionsHelper.fadeTransition(state, const HomePage()),
      ),
      GoRoute(
        path: travelInfoPage,
        pageBuilder: (context, state) {
          final data = state.extra as TravelInfoModel?;
          return TransitionsHelper.fadeTransition(
            state,
            TravelInfoPage(data: data),
          );
        },
      ),
      GoRoute(
        path: offlinePage,
        pageBuilder: (context, state) =>
            TransitionsHelper.fadeTransition(state, const OfflinePage()),
      ),
      GoRoute(
        path: waitingDriverPage,
        pageBuilder: (context, state) => TransitionsHelper.fadeTransition(
          state,
          const WaitingDriverWidget(),
        ),
      ),
      GoRoute(
        path: offlinePositionPage,
        pageBuilder: (context, state) => TransitionsHelper.fadeTransition(
          state,
          const OfflinePositionPage(),
        ),
      ),
    ],
  );
}
