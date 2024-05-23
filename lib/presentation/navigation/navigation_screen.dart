import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/presentation/account/account_screen.dart';
import 'package:crowdfunding_flutter/presentation/explore/explore_screen.dart';
import 'package:crowdfunding_flutter/presentation/home/home_screen.dart';
import 'package:crowdfunding_flutter/presentation/navigation/bottom_nav_bar.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign/manage_campaign_screen.dart';
import 'package:crowdfunding_flutter/presentation/notification/notification_screen.dart';
import 'package:crowdfunding_flutter/state_management/home/home_bloc.dart';
import 'package:crowdfunding_flutter/state_management/home/home_event.dart';
import 'package:crowdfunding_flutter/state_management/navigation/navigation_cubit.dart';
import 'package:crowdfunding_flutter/state_management/navigation/navigation_state.dart';
import 'package:crowdfunding_flutter/state_management/user/favourite_campaign/favourite_campaign_bloc.dart';
import 'package:crowdfunding_flutter/state_management/user/favourite_campaign/favourite_campaign_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const NavigationScreen(),
      );
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FetchRecommendedCampaigns());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouriteCampaignBloc(
        createFavouriteCampaign: serviceLocator(),
        getFavouriteCampaigns: serviceLocator(),
        deleteFavouriteCampaign: serviceLocator(),
      )..add(OnFetchFavouriteCampaigns()),
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: HomeBottomNavigationBar(),
          body: BlocBuilder<NavigationCubit, NavigationState>(
            builder: (context, navigationState) {
              switch (navigationState) {
                case NavigationState.home:
                  return HomePage();
                case NavigationState.explore:
                  return ExploreScreen();
                case NavigationState.notification:
                  return NotificationScreen();
                case NavigationState.manage:
                  return ManageCampaignScreen();
                case NavigationState.account:
                  return AccountScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
