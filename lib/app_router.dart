import 'package:crowdfunding_flutter/domain/model/gift_card/gift_card.dart';
import 'package:crowdfunding_flutter/presentation/account/account_screen.dart';
import 'package:crowdfunding_flutter/presentation/account_gift_card/charity_gift_card_screen.dart';
import 'package:crowdfunding_flutter/presentation/account_gift_card/screens/open_gift_card_screen.dart';
import 'package:crowdfunding_flutter/presentation/account_saved_campaigns/saved_campaigns_screen.dart';
import 'package:crowdfunding_flutter/presentation/campaign_details/campaign_details_screen.dart';
import 'package:crowdfunding_flutter/presentation/donate/donate_screen.dart';
import 'package:crowdfunding_flutter/presentation/explore/explore_screen.dart';
import 'package:crowdfunding_flutter/presentation/home/home_screen.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign/manage_campaign_screen.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign_details/manage_campaign_details_screen.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign_details/screens/create_campaign_update_screen.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign_details/screens/edit_campaign_screen.dart';
import 'package:crowdfunding_flutter/presentation/notification/notification_screen.dart';
import 'package:crowdfunding_flutter/presentation/splash/splash_screen.dart';
import 'package:crowdfunding_flutter/presentation/testing/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:crowdfunding_flutter/presentation/login/login_screen.dart';
import 'package:crowdfunding_flutter/presentation/navigation/navigation_screen.dart';

class AppRouter {
  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');
  final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shell');

  GoRouter get router => GoRouter(
        navigatorKey: _rootNavigatorKey,
        // initialLocation: EditCampaignScreen.generateRoute(campaignId: '123'),
        initialLocation: '/loading',
        routes: [
          ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (BuildContext context, GoRouterState state, Widget child) {
              return NavigationScreen(
                child: child,
              );
            },
            routes: [
              GoRoute(
                path: HomeScreen.route,
                builder: (context, state) => const HomeScreen(),
              ),
              GoRoute(
                path: ExploreScreen.route,
                builder: (context, state) => const ExploreScreen(),
              ),
              GoRoute(
                path: NotificationScreen.route,
                builder: (context, state) => const NotificationScreen(),
              ),
              GoRoute(
                path: ManageCampaignScreen.route,
                builder: (context, state) => const ManageCampaignScreen(),
              ),
              GoRoute(
                path: AccountScreen.route,
                builder: (context, state) => const AccountScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/testing',
            builder: (context, state) => const TestScreen(),
          ),
          GoRoute(
            path: '/loading',
            builder: (context, state) => const SplashScreen(), //
          ),
          GoRoute(
            path: '/login',
            builder: (context, state) => const LoginScreen(),
          ),
          GoRoute(
            path: CampaignDetailsScreen.route,
            builder: (context, state) => CampaignDetailsScreen(
              campaignId: state.pathParameters['campaignId'] ?? '',
            ),
          ),
          GoRoute(
              path: DonateScreen.route,
              builder: (context, state) {
                final campaignId = state.pathParameters['campaignId'] ?? '';
                final campaignTitle = state.extra as String?;
                return DonateScreen(
                  campaignId: campaignId,
                  campaignTitle: campaignTitle,
                );
              }),
          GoRoute(
            path: ManageCampaignDetailsScreen.route,
            builder: (context, state) => ManageCampaignDetailsScreen(
              campaignId: state.pathParameters['campaignId'] ?? '',
            ),
          ),
          GoRoute(
            path: EditCampaignScreen.route,
            builder: (context, state) => EditCampaignScreen(
                campaignId: state.pathParameters['campaignId'] ?? ''),
          ),
          GoRoute(
            path: CreateCampaignUpdateScreen.route,
            builder: (context, state) => CreateCampaignUpdateScreen(
                campaignId: state.pathParameters['campaignId'] ?? ''),
          ),
          GoRoute(
            path: SavedCampaignsScreen.route,
            builder: (context, state) => SavedCampaignsScreen(),
          ),
          GoRoute(
            path: GiftCardScreen.route,
            builder: (context, state) => GiftCardScreen(),
          ),
          GoRoute(
            path: OpenGiftCardScreen.route,
            builder: (context, state) {
              final giftCard = state.extra as GiftCard?;
              final giftCardId = state.pathParameters['id'] ?? '';
              return OpenGiftCardScreen(
                giftCardId: giftCardId,
                giftCard: giftCard,
              );
            },
          ),
        ],
      );
}
