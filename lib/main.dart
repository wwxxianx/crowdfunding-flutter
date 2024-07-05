import 'package:crowdfunding_flutter/app_router.dart';
import 'package:crowdfunding_flutter/common/constants/constants.dart';
import 'package:crowdfunding_flutter/common/theme/app_theme.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/state_management/app_user_cubit.dart';
import 'package:crowdfunding_flutter/state_management/explore/explore_campaigns_bloc.dart';
import 'package:crowdfunding_flutter/state_management/explore/explore_campaigns_event.dart';
import 'package:crowdfunding_flutter/state_management/gift_card/gift_card_bloc.dart';
import 'package:crowdfunding_flutter/state_management/home/home_bloc.dart';
import 'package:crowdfunding_flutter/state_management/sign_up/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  Stripe.publishableKey = Constants.stripePublishableKey;

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<SignUpBloc>()),
        BlocProvider(
            create: (_) =>
                ExploreCampaignsBloc(fetchCampaigns: serviceLocator())),
        BlocProvider(create: (_) => serviceLocator<HomeBloc>()),
        BlocProvider(create: (_) => serviceLocator<GiftCardBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final AppRouter _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp.router(
        title: 'Crowdfunding App',
        theme: appTheme,
        // home: SplashScreen(),
        routerConfig: AppRouter.router,
        // home: BlocBuilder<AppUserCubit, AppUserState>(
        //   builder: (context, state) {
        //     if (state is AppUserInitial) {
        //       return const LoginScreen();
        //     }
        //     if (state is AppUserLoggedIn) {
        //       if (state.user.isOnboardingCompleted) {
        //         return const NavigationScreen();
        //       }
        //       return const LoginScreen();
        //     }
        //     return const SizedBox();
        //   },
        // ),
      ),
    );
  }
}