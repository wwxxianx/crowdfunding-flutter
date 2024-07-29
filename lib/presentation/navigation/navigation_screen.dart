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
    final AppUserCubit appUserCubit = BlocProvider.of<AppUserCubit>(context);
    appUserCubit.listenToRealtimeNotification();
    BlocProvider.of<FavouriteCampaignBloc>(context)
      .add(OnFetchFavouriteCampaigns());
  }

  @override
  void didChangeDependencies() {
    // final AppUserCubit appUserCubit = BlocProvider.of<AppUserCubit>(context);
    // appUserCubit.listenToRealtimeNotification();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppUserCubit, AppUserState>(
      listenWhen: (previous, current) {
        return ((previous.unreadCommunityChallengeRewardNotification !=
                    current.unreadCommunityChallengeRewardNotification) &&
                current.unreadCommunityChallengeRewardNotification != null) ||
            (previous.unreadCampaignStatusChangedNotification !=
                    current.unreadCampaignStatusChangedNotification &&
                current.unreadCampaignStatusChangedNotification != null);
      },
      listener: (context, state) {
        final realtimeNotification =
            state.unreadCommunityChallengeRewardNotification;
        final unreadCampaignStatusChangedNotification =
            state.unreadCampaignStatusChangedNotification;
        if (realtimeNotification != null) {
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
            autoCloseDuration: const Duration(seconds: 7),
            showProgressBar: true,
          );
        }
        if (unreadCampaignStatusChangedNotification != null) {
          toastification.show(
            title: Text(unreadCampaignStatusChangedNotification.title),
            description: Text(
                unreadCampaignStatusChangedNotification.description ??
                    'Check out your notification inbox'),
            applyBlurEffect: true,
            boxShadow: lowModeShadow,
            icon: const HeroIcon(
              HeroIcons.bellAlert,
              color: CustomColors.accentGreen,
            ),
            autoCloseDuration: const Duration(seconds: 7),
            showProgressBar: true,
          );
        }
      },
      child: Scaffold(
        bottomNavigationBar: const HomeBottomNavigationBar(),
        body: SafeArea(child: widget.child),
      ),
    );
  }
}
