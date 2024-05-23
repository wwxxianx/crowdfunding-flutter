import 'package:crowdfunding_flutter/presentation/campaign_details/campaign_details_screen.dart';
import 'package:crowdfunding_flutter/presentation/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:crowdfunding_flutter/presentation/login/login_screen.dart';
import 'package:crowdfunding_flutter/presentation/navigation/navigation_screen.dart';
import 'package:crowdfunding_flutter/state_management/app_user_cubit.dart';

class AppRouter {
  final AppUserCubit appUserCubit;

  AppRouter(this.appUserCubit);

  GoRouter get router => GoRouter(
        initialLocation: '/loading',
        routes: [
          GoRoute(
            path: '/loading',
            builder: (context, state) => const SplashScreen(), //
          ),
          GoRoute(
            path: '/login',
            builder: (context, state) => const LoginScreen(),
          ),
          GoRoute(
            path: '/main',
            builder: (context, state) => const NavigationScreen(),
          ),
          GoRoute(
            path: '/campaign-details/:campaignId',
            builder: (context, state) => CampaignDetailsScreen(
              campaignId: state.pathParameters['campaignId'] ?? '',
            ),
          ),
        ],
      );
}
