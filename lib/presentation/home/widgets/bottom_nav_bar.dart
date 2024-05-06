import 'package:crowdfunding_flutter/state_management/navigation/navigation_cubit.dart';
import 'package:crowdfunding_flutter/state_management/navigation/navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({super.key});

  int _getCurrentIndex(NavigationState state) {
    switch (state) {
      case NavigationState.home:
        return 0;
      case NavigationState.explore:
        return 1;
      case NavigationState.notification:
        return 2;
      case NavigationState.manage:
        return 3;
      case NavigationState.account:
        return 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
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
          currentIndex: _getCurrentIndex(state),
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
                    .onNavigateTo(NavigationState.explore);
                break;
              case 2:
                context
                    .read<NavigationCubit>()
                    .onNavigateTo(NavigationState.notification);
                break;
              case 3:
                context
                    .read<NavigationCubit>()
                    .onNavigateTo(NavigationState.manage);
                break;
              case 4:
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
