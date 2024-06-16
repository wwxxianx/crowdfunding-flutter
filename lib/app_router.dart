import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/common/widgets/button/custom_button.dart';
import 'package:crowdfunding_flutter/domain/model/gift_card/gift_card.dart';
import 'package:crowdfunding_flutter/domain/model/organization/organization.dart';
import 'package:crowdfunding_flutter/presentation/account/account_screen.dart';
import 'package:crowdfunding_flutter/presentation/account_gift_card/charity_gift_card_screen.dart';
import 'package:crowdfunding_flutter/presentation/account_gift_card/screens/open_gift_card_screen.dart';
import 'package:crowdfunding_flutter/presentation/account_join_team/account_join_team_screen.dart';
import 'package:crowdfunding_flutter/presentation/account_preferences/account_preferences_screen.dart';
import 'package:crowdfunding_flutter/presentation/account_saved_campaigns/saved_campaigns_screen.dart';
import 'package:crowdfunding_flutter/presentation/campaign_details/campaign_details_screen.dart';
import 'package:crowdfunding_flutter/presentation/create_campaign/create_campaign_screen.dart';
import 'package:crowdfunding_flutter/presentation/create_campaign/screens/create_campaign_success_screen.dart';
import 'package:crowdfunding_flutter/presentation/donate/donate_screen.dart';
import 'package:crowdfunding_flutter/presentation/edit_organization/edit_organization_screen.dart';
import 'package:crowdfunding_flutter/presentation/explore/explore_screen.dart';
import 'package:crowdfunding_flutter/presentation/home/home_screen.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign/manage_campaign_screen.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign_details/manage_campaign_details_screen.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign_details/screens/collaborate_with_npo_screen.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign_details/screens/connected_bank_account_screen.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign_details/screens/create_campaign_update_screen.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign_details/screens/edit_campaign_screen.dart';
import 'package:crowdfunding_flutter/presentation/notification/notification_screen.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/pages/npo_onboarding/join_npo_success_page.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/widgets/create_organization_page_view.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/widgets/join_with_code_page_view.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/widgets/onboarding_select_account_type_screen.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/widgets/onboarding_select_npo_join_method_screen.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/widgets/personal_account_page_view.dart';
import 'package:crowdfunding_flutter/presentation/organization_profile/organization_profile_screen.dart';
import 'package:crowdfunding_flutter/presentation/sign_up/sign_up_screen.dart';
import 'package:crowdfunding_flutter/presentation/splash/splash_screen.dart';
import 'package:crowdfunding_flutter/presentation/testing/test_screen.dart';
import 'package:crowdfunding_flutter/state_management/app_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:crowdfunding_flutter/presentation/login/login_screen.dart';
import 'package:crowdfunding_flutter/presentation/navigation/navigation_screen.dart';
import 'package:logger/logger.dart';
import 'package:toastification/toastification.dart';

class AppRouter {
  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');
  final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shell');

  GoRouter get router => GoRouter(
        navigatorKey: _rootNavigatorKey,
        // initialLocation: EditCampaignScreen.generateRoute(campaignId: '123'),
        // initialLocation:
        //     OrganizationProfileScreen.generateRoute(organizationId: 'asd'),
        initialLocation: '/organization-profile/123',
        routes: [
          GoRoute(
            path: '/',
            routes: [
              ShellRoute(
                navigatorKey: _shellNavigatorKey,
                builder:
                    (BuildContext context, GoRouterState state, Widget child) {
                  return NavigationScreen(
                    child: child,
                  );
                },
                routes: [
                  GoRoute(
                    path: 'home',
                    builder: (context, state) => const HomeScreen(),
                  ),
                  GoRoute(
                    path: 'explore',
                    builder: (context, state) => const ExploreScreen(),
                    routes: [
                      GoRoute(
                        parentNavigatorKey: _rootNavigatorKey,
                        path: CampaignDetailsScreen.route,
                        builder: (context, state) => CampaignDetailsScreen(
                          campaignId: state.pathParameters['campaignId'] ?? '',
                        ),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'notification',
                    builder: (context, state) => const NotificationScreen(),
                  ),
                  GoRoute(
                    path: 'manage-campaigns',
                    builder: (context, state) => const ManageCampaignScreen(),
                  ),
                  GoRoute(
                    path: 'account',
                    builder: (context, state) => const AccountScreen(),
                  ),
                ],
              ),
            ],
            redirect: (context, state) async {
              final currentUser =
                  context.read<AppUserCubit>().state.currentUser;
              if (currentUser == null) {
                final userIsLoggedIn =
                    await context.read<AppUserCubit>().checkUserLoggedIn();
                if (!userIsLoggedIn) {
                  return '/login?from=${state.uri}';
                }
              }
              return null;
            },
          ),
          GoRoute(
            path: '/create-campaign-success/:campaignId',
            builder: (context, state) {
              final campaignId = state.pathParameters['campaignId'] ?? '';
              return CreateCampaignSuccessScreen(campaignId: campaignId);
            },
          ),
          GoRoute(
            path: '/data',
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(title: Text('Data All')),
                body: CustomButton(
                  onPressed: () {
                    String? id;
                    context.push(
                      '/data/details/$id',
                    );
                  },
                  child: Text('Go details'),
                ),
              );
            },
            routes: [
              GoRoute(
                path: 'details/:id',
                builder: (context, state) {
                  final id = state.pathParameters['id'];
                  var logger = Logger();
                  return Scaffold(
                    appBar: AppBar(
                      title: Text('Details'),
                    ),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/testing',
            builder: (context, state) => TestScreen(),
          ),
          GoRoute(
            path: '/loading',
            builder: (context, state) => const SplashScreen(), //
          ),
          GoRoute(
            name: 'login',
            path: LoginScreen.route,
            builder: (context, state) {
              final fromPath = state.uri.queryParameters['from'];
              return LoginScreen(
                fromPath: fromPath,
              );
            },
          ),
          GoRoute(
            name: 'sign-up',
            path: SignUpScreen.route,
            builder: (context, state) {
              final fromPath = state.uri.queryParameters['from'];
              return SignUpScreen(
                fromPath: fromPath,
              );
            },
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
            },
          ),
          // Account
          GoRoute(
            path: AccountJoinTeamScreen.route,
            builder: (context, state) {
              return AccountJoinTeamScreen();
            },
          ),
          GoRoute(
            path: AccountPreferencesScreen.route,
            builder: (context, state) {
              return AccountPreferencesScreen();
            },
          ),
          GoRoute(
            path: ManageCampaignDetailsScreen.route,
            builder: (context, state) => ManageCampaignDetailsScreen(
              campaignId: state.pathParameters['campaignId'] ?? '',
            ),
          ),
          GoRoute(
            name: "connected-bank-account",
            path: '/connected-bank-account',
            builder: (context, state) {
              final connectedAccountId =
                  state.uri.queryParameters['connectedAccountId'];
              return ConnectedBankAccountScreen(
                connectedAccountId: connectedAccountId,
              );
            },
          ),
          GoRoute(
            path: CollaborateWithNPOScreen.route,
            builder: (context, state) {
              final campaignId = state.pathParameters['campaignId'] ?? '';
              return CollaborateWithNPOScreen(
                campaignId: campaignId,
              );
            },
          ),
          GoRoute(
            path: CreateCampaignScreen.route,
            builder: (context, state) => const CreateCampaignScreen(),
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
          // Onboarding
          GoRoute(
            path: OnboardingSelectAccountScreen.route,
            builder: (context, state) {
              return OnboardingSelectAccountScreen();
            },
          ),
          GoRoute(
            path: CreateOrganizationPageView.route,
            builder: (context, state) {
              return CreateOrganizationPageView();
            },
          ),
          GoRoute(
            path: JoinWithCodePageView.route,
            builder: (context, state) {
              return JoinWithCodePageView();
            },
          ),
          GoRoute(
            path: OnboardingSelectNPOJoinMethodScreen.route,
            builder: (context, state) {
              return OnboardingSelectNPOJoinMethodScreen();
            },
          ),
          GoRoute(
            path: OnboardingPersonalProfileScreen.route,
            builder: (context, state) {
              return OnboardingPersonalProfileScreen();
            },
          ),
          GoRoute(
            path: JoinNPOSuccessScreen.route,
            builder: (context, state) {
              final organization = state.extra as Organization?;
              final organizationId =
                  state.pathParameters['organizationId'] ?? "";
              return JoinNPOSuccessScreen(
                organizationId: organizationId,
                organizationInfo: organization,
              );
            },
          ),
          GoRoute(
              path: OrganizationProfileScreen.route,
              builder: (context, state) {
                final organizationId =
                    state.pathParameters['organizationId'] ?? "";
                return OrganizationProfileScreen(
                  organizationId: organizationId,
                );
              }),
          GoRoute(
              path: EditOrganizationScreen.route,
              builder: (context, state) {
                final organizationId =
                    state.pathParameters['organizationId'] ?? "";
                final organization = state.extra as Organization?;
                return EditOrganizationScreen(
                  organization: organization,
                  organizationId: organizationId,
                );
              }),
        ],
      );
}
