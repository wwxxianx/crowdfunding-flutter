import 'package:crowdfunding_flutter/presentation/account/account_screen.dart';
import 'package:crowdfunding_flutter/presentation/explore/explore_screen.dart';
import 'package:crowdfunding_flutter/presentation/home/home_screen.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign/manage_campaign_screen.dart';
import 'package:crowdfunding_flutter/presentation/navigation/widgets/badge_icon.dart';
import 'package:crowdfunding_flutter/presentation/notification/notification_screen.dart';
import 'package:crowdfunding_flutter/state_management/app_user_cubit.dart';
import 'package:crowdfunding_flutter/state_management/gift_card/gift_card_bloc.dart';
import 'package:crowdfunding_flutter/state_management/navigation/navigation_cubit.dart';
import 'package:crowdfunding_flutter/state_management/navigation/navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

class HomeBottomNavigationBar extends StatefulWidget {
  const HomeBottomNavigationBar({super.key});

  @override
  State<HomeBottomNavigationBar> createState() =>
      _HomeBottomNavigationBarState();
}

class _HomeBottomNavigationBarState extends State<HomeBottomNavigationBar> {
  var logger = Logger();

  @override
  void initState() {
    super.initState();
  }

  static int _getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith(HomeScreen.route)) {
      return 0;
    }
    if (location.startsWith(ExploreScreen.route)) {
      return 1;
    }
    if (location.startsWith(NotificationScreen.route)) {
      return 2;
    }
    if (location.startsWith(ManageCampaignScreen.route)) {
      return 3;
    }
    if (location.startsWith(AccountScreen.route)) {
      return 4;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go(HomeScreen.route);
      case 1:
        GoRouter.of(context).go(ExploreScreen.route);
      case 2:
        GoRouter.of(context).go(NotificationScreen.route);
      case 3:
        GoRouter.of(context).go(ManageCampaignScreen.route);
      case 4:
        GoRouter.of(context).go(AccountScreen.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final giftCardState = context.watch<GiftCardBloc>().state;
    final hasUnusedGiftCard = giftCardState.receivedGiftCards.isNotEmpty &&
        giftCardState.receivedGiftCards
            .any((giftCard) => giftCard.campaignDonation == null);
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      selectedFontSize: 12.0,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/icons/home.svg"),
          activeIcon: SvgPicture.asset("assets/icons/home-active.svg"),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/icons/globe.svg"),
          activeIcon: SvgPicture.asset("assets/icons/globe-active.svg"),
          label: "Explore",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/icons/bell.svg"),
          activeIcon: SvgPicture.asset("assets/icons/bell-active.svg"),
          label: "Notification",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/icons/document-chart-bar.svg"),
          activeIcon:
              SvgPicture.asset("assets/icons/document-chart-bar-active.svg"),
          label: "Manage",
        ),
        BottomNavigationBarItem(
          icon: IconWithBadge(
            showBadge: hasUnusedGiftCard,
            icon: SvgPicture.asset("assets/icons/user-circle.svg"),
          ),
          activeIcon: IconWithBadge(
            showBadge: hasUnusedGiftCard,
            icon: SvgPicture.asset("assets/icons/user-circle-active.svg"),
          ),
          label: "Account",
        ),
      ],
      currentIndex: _getCurrentIndex(context),
      onTap: (value) {
        _onItemTapped(value, context);
      },
    );
  }
}
