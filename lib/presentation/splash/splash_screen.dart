import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/data/network/payload/user/user_profile_payload.dart';
import 'package:crowdfunding_flutter/presentation/home/home_screen.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/widgets/onboarding_select_account_type_screen.dart';
import 'package:crowdfunding_flutter/presentation/splash/splash_bg_shape.dart';
import 'package:crowdfunding_flutter/state_management/app_user_cubit.dart';
import 'package:crowdfunding_flutter/state_management/gift_card/gift_card_bloc.dart';
import 'package:crowdfunding_flutter/state_management/gift_card/gift_card_event.dart';
import 'package:crowdfunding_flutter/state_management/home/home_bloc.dart';
import 'package:crowdfunding_flutter/state_management/home/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  late Animation<double> textPositionAnimation;
  late Animation<double> textOpacityAnimation;
  double scale = 1.0;

  final ValueNotifier<bool> isAnimationCompleted = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    scaleAnimation = Tween<double>(begin: 1.0, end: 9.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut));

    textPositionAnimation = Tween<double>(begin: -60, end: 0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut));

    textOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut));
    _navigateAfterDelay();
    animationController.forward().whenComplete(() {
      isAnimationCompleted.value = true;
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _navigateAfterDelay() async {
    String destination;
    final appUserCubit = context.read<AppUserCubit>();
    await appUserCubit.checkUserLoggedIn(
      onSuccess: (user) {
        OneSignal.login(user.id).whenComplete(() async {
          // Update user onesignal field
          if (user.onesignalId != null) {
            return;
          }
          final id = await OneSignal.User.getOnesignalId();
          appUserCubit.updateUserProfile(UserProfilePayload(onesignalId: id));
        });
        if (user.isOnboardingCompleted) {
          destination = '/home';
        } else {
          // destination = OnboardingSelectAccountScreen.route;
          destination = '/home';
        }

        context.read<GiftCardBloc>().add(OnFetchAllGiftCards());
        context.read<AppUserCubit>().fetchNotifications();
        context.read<HomeBloc>()
          ..add(OnFetchRecommendedCampaigns())
          ..add(OnFetchCloseToTargetCampaigns())
          ..add(OnFetchUserInterestedCampaigns());
        // Redirect user
        // Listen for animation completion
        isAnimationCompleted.addListener(() {
          if (isAnimationCompleted.value) {
            context.go(destination);
          }
        });
      },
      onFailure: () {
        // Redirect user
        isAnimationCompleted.addListener(() {
          if (isAnimationCompleted.value) {
            context.go('/login');
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: scaleAnimation.value,
                  child: Container(
                    child: CustomPaint(
                      size: Size(
                          229,
                          (229 * 0.9781659388646288)
                              .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                      painter: SplashBgShapePainter(),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              bottom: -100,
              right: -120,
              child: Transform.scale(
                scale: 1.05,
                child: Lottie.asset("assets/animations/splash-animation.json"),
              ),
            ),
            AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Positioned(
                  bottom: textPositionAnimation.value,
                  child: Opacity(
                    opacity: textOpacityAnimation.value,
                    child: Text(
                      "Welcome Back!",
                      style: CustomFonts.titleExtraLarge,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
