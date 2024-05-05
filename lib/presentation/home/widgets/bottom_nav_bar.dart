import 'package:crowdfunding_flutter/state_management/navigation/navigation_cubit.dart';
import 'package:crowdfunding_flutter/state_management/navigation/navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        final currentIndex = state == NavigationState.home
            ? 0
            : state == NavigationState.notification
                ? 1
                : state == NavigationState.manage
                    ? 2
                    : 3;
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
              icon: SvgPicture.asset("assets/icons/bell.svg"),
              activeIcon: SvgPicture.asset("assets/icons/bell-active.svg"),
              label: "Notification",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/document-chart-bar.svg"),
              activeIcon: SvgPicture.asset(
                  "assets/icons/document-chart-bar-active.svg"),
              label: "Manage",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/user-circle.svg"),
              activeIcon:
                  SvgPicture.asset("assets/icons/user-circle-active.svg"),
              label: "Account",
            ),
          ],
          currentIndex: currentIndex,
          onTap: (index) {
            switch (index) {
              case 0:
                context
                    .read<NavigationCubit>()
                    .onNavigateTo(NavigationState.home);
                break;
              case 1:
                context
                    .read<NavigationCubit>()
                    .onNavigateTo(NavigationState.notification);
                break;
              case 2:
                context
                    .read<NavigationCubit>()
                    .onNavigateTo(NavigationState.manage);
                break;
              case 3:
                context
                    .read<NavigationCubit>()
                    .onNavigateTo(NavigationState.account);
                break;
            }
          },
        );
      },
    );
  }
}
