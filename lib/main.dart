import 'package:crowdfunding_flutter/common/theme/typography.dart';
import 'package:crowdfunding_flutter/di/init_dependencies.dart';
import 'package:crowdfunding_flutter/presentation/navigation/navigation_screen.dart';
import 'package:crowdfunding_flutter/state_management/app_user_cubit.dart';
import 'package:crowdfunding_flutter/state_management/explore/explore_campaigns_bloc.dart';
import 'package:crowdfunding_flutter/state_management/home/home_bloc.dart';
import 'package:crowdfunding_flutter/state_management/navigation/navigation_cubit.dart';
import 'package:crowdfunding_flutter/state_management/sign_up/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crowdfunding_flutter/common/theme/color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<SignUpBloc>()),
        BlocProvider(create: (_) => serviceLocator<NavigationCubit>()),
        BlocProvider(create: (_) => serviceLocator<ExploreCampaignsBloc>()),
        BlocProvider(create: (_) => serviceLocator<HomeBloc>()),
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
        menuButtonTheme: MenuButtonThemeData(
          style: MenuItemButton.styleFrom(
            textStyle: CustomFonts.bodyMedium,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
        ),
      ),
      home: const NavigationScreen(),
    );
  }
}
