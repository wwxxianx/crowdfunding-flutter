import 'package:crowdfunding_flutter/presentation/navigation/widgets/badge_icon.dart';
import 'package:crowdfunding_flutter/state_management/app_user_cubit.dart';
import 'package:crowdfunding_flutter/state_management/gift_card/gift_card_bloc.dart';
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
    if (location.startsWith('/home')) {
      return 0;
    }
    if (location.startsWith('/explore')) {
      return 1;
    }
    if (location.startsWith('/notification')) {
      return 2;
    }
    if (location.startsWith('/manage-campaigns')) {
      return 3;
    }
    if (location.startsWith('/account')) {
      return 4;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/home');
      case 1:
        GoRouter.of(context).go('/explore');
      case 2:
        GoRouter.of(context).go('/notification');
      case 3:
        GoRouter.of(context).go('/manage-campaigns');
      case 4:
        GoRouter.of(context).go('/account');
    }
  }

  @override
  Widget build(BuildContext context) {
    final giftCardState = context.watch<GiftCardBloc>().state;
    final hasUnusedGiftCard = giftCardState.receivedGiftCards.isNotEmpty &&
        giftCardState.receivedGiftCards
            .any((giftCard) => giftCard.campaignDonation == null);
    final appUserState = context.watch<AppUserCubit>().state;
    final hasUnreadNotification =
        appUserState.notifications.any((notification) => !notification.isRead);
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
          icon: IconWithBadge(
            icon: SvgPicture.asset("assets/icons/bell.svg"),
            showBadge: hasUnreadNotification,
          ),
          activeIcon: IconWithBadge(
            icon: SvgPicture.asset("assets/icons/bell-active.svg"),
            showBadge: hasUnreadNotification,
          ),
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
