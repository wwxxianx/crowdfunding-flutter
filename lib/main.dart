import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/presentation/account/account_screen.dart';
import 'package:crowdfunding_flutter/presentation/explore/explore_screen.dart';
import 'package:crowdfunding_flutter/presentation/home/home_screen.dart';
import 'package:crowdfunding_flutter/presentation/home/widgets/bottom_nav_bar.dart';
import 'package:crowdfunding_flutter/presentation/manage_campaign/manage_campaign_screen.dart';
import 'package:crowdfunding_flutter/presentation/notification/notification_screen.dart';
import 'package:crowdfunding_flutter/presentation/onboarding/widgets/onboarding_select_account_type_screen.dart';
import 'package:crowdfunding_flutter/state_management/explore/explore_campaigns_bloc.dart';
import 'package:crowdfunding_flutter/state_management/navigation/navigation_cubit.dart';
import 'package:crowdfunding_flutter/state_management/navigation/navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crowdfunding_flutter/common/theme/color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<NavigationCubit>()),
        BlocProvider(create: (_) => serviceLocator<ExploreCampaignsBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crowdfunding App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: CustomColors.primaryGreen),
        useMaterial3: true,
        fontFamily: "Satoshi",
        scaffoldBackgroundColor: Colors.white,
        tabBarTheme: TabBarTheme.of(context).copyWith(
          indicatorColor: Colors.black,
          labelColor: Colors.black,
        ),
      ),
      home: const OnboardingSelectAccountScreen(),
    );
  }
}

class NavigationScreen extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const NavigationScreen(),
      );
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
    );
  }
}
