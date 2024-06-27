import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/presentation/navigation/bottom_nav_bar.dart';
import 'package:crowdfunding_flutter/state_management/app_user_cubit.dart';
import 'package:crowdfunding_flutter/state_management/app_user_state.dart';
import 'package:crowdfunding_flutter/state_management/user/favourite_campaign/favourite_campaign_bloc.dart';
import 'package:crowdfunding_flutter/state_management/user/favourite_campaign/favourite_campaign_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:toastification/toastification.dart';

class NavigationScreen extends StatefulWidget {
  final Widget child;
  // static route() => MaterialPageRoute(
  //       builder: (context) => const NavigationScreen(),
  //     );
  const NavigationScreen({
    super.key,
    required this.child,
  });

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final AppUserCubit appUserCubit = BlocProvider.of<AppUserCubit>(context);
    appUserCubit.listenToRealtimeNotification();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FavouriteCampaignBloc(
            createFavouriteCampaign: serviceLocator(),
            getFavouriteCampaigns: serviceLocator(),
            deleteFavouriteCampaign: serviceLocator(),
          )..add(OnFetchFavouriteCampaigns()),
        ),
        // BlocProvider(create: (_) => NavigationCubit()),
      ],
      child: BlocListener<AppUserCubit, AppUserState>(
        listenWhen: (previous, current) {
          return (previous.realtimeNotification !=
                  current.realtimeNotification) &&
              current.realtimeNotification != null;
        },
        listener: (context, state) {
          final realtimeNotification = state.realtimeNotification;
          if (realtimeNotification == null) {
            return;
          }
          toastification.show(
            title: Text(realtimeNotification.title),
            description: Text(realtimeNotification.description ??
                'Check out your notification inbox'),
            applyBlurEffect: true,
            boxShadow: lowModeShadow,
            icon: const HeroIcon(
              HeroIcons.bellAlert,
              color: CustomColors.accentGreen,
            ),
            
          );
        },
        child: Scaffold(
          bottomNavigationBar: const HomeBottomNavigationBar(),
          body: SafeArea(child: widget.child),
          // body: BlocBuilder<NavigationCubit, NavigationState>(
          //   builder: (context, navigationState) {
          //     switch (navigationState) {
          //       case NavigationState.home:
          //         return HomeScreen();
          //       case NavigationState.explore:
          //         return ExploreScreen();
          //       case NavigationState.notification:
          //         return NotificationScreen();
          //       case NavigationState.manage:
          //         return ManageCampaignScreen();
          //       case NavigationState.account:
          //         return AccountScreen();
          //     }
          //   },
          // ),
        ),
      ),
    );
  }
}
