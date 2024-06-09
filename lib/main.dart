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
  final AppRouter _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp.router(
        title: 'Crowdfunding App',
        theme: appTheme,
        // home: SplashScreen(),
        routerConfig: _appRouter.router,
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

// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// final GlobalKey<NavigatorState> _rootNavigatorKey =
//     GlobalKey<NavigatorState>(debugLabel: 'root');
// final GlobalKey<NavigatorState> _shellNavigatorKey =
//     GlobalKey<NavigatorState>(debugLabel: 'shell');

// // This scenario demonstrates how to set up nested navigation using ShellRoute,
// // which is a pattern where an additional Navigator is placed in the widget tree
// // to be used instead of the root navigator. This allows deep-links to display
// // pages along with other UI components such as a BottomNavigationBar.
// //
// // This example demonstrates how to display a route within a ShellRoute and also
// // push a screen using a different navigator (such as the root Navigator) by
// // providing a `parentNavigatorKey`.

// void main() {
//   runApp(ShellRouteExampleApp());
// }

// /// An example demonstrating how to use [ShellRoute]
// class ShellRouteExampleApp extends StatelessWidget {
//   /// Creates a [ShellRouteExampleApp]
//   ShellRouteExampleApp({super.key});

//   final GoRouter _router = GoRouter(
//     navigatorKey: _rootNavigatorKey,
//     initialLocation: '/b',
//     debugLogDiagnostics: true,
//     routes: <RouteBase>[
//       /// Application shell
//       ShellRoute(
//         navigatorKey: _shellNavigatorKey,
//         builder: (BuildContext context, GoRouterState state, Widget child) {
//           return ScaffoldWithNavBar(child: child);
//         },
//         routes: <RouteBase>[
//           /// The first screen to display in the bottom navigation bar.
//           GoRoute(
//             path: '/a',
//             builder: (BuildContext context, GoRouterState state) {
//               return const ScreenA();
//             },
//             routes: <RouteBase>[
//               // The details screen to display stacked on the inner Navigator.
//               // This will cover screen A but not the application shell.
//               GoRoute(
//                 path: 'details',
//                 builder: (BuildContext context, GoRouterState state) {
//                   return const DetailsScreen(label: 'A');
//                 },
//               ),
//             ],
//           ),

//           /// Displayed when the second item in the the bottom navigation bar is
//           /// selected.
//           GoRoute(
//             path: '/b',
//             builder: (BuildContext context, GoRouterState state) {
//               return const ScreenB();
//             },
//             routes: <RouteBase>[
//               /// Same as "/a/details", but displayed on the root Navigator by
//               /// specifying [parentNavigatorKey]. This will cover both screen B
//               /// and the application shell.
//               GoRoute(
//                 path: 'details',
//                 parentNavigatorKey: _rootNavigatorKey,
//                 builder: (BuildContext context, GoRouterState state) {
//                   return const DetailsScreen(label: 'B');
//                 },
//               ),
//             ],
//           ),

//           /// The third screen to display in the bottom navigation bar.
//           GoRoute(
//             path: '/c',
//             builder: (BuildContext context, GoRouterState state) {
//               return const ScreenC();
//             },
//             routes: <RouteBase>[
//               // The details screen to display stacked on the inner Navigator.
//               // This will cover screen A but not the application shell.
//               GoRoute(
//                 path: 'details',
//                 builder: (BuildContext context, GoRouterState state) {
//                   return const DetailsScreen(label: 'C');
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     ],
//   );

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       routerConfig: _router,
//     );
//   }
// }

// /// Builds the "shell" for the app by building a Scaffold with a
// /// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
// class ScaffoldWithNavBar extends StatelessWidget {
//   /// Constructs an [ScaffoldWithNavBar].
//   const ScaffoldWithNavBar({
//     required this.child,
//     super.key,
//   });

//   /// The widget to display in the body of the Scaffold.
//   /// In this sample, it is a Navigator.
//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: child,
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'A Screen',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.business),
//             label: 'B Screen',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notification_important_rounded),
//             label: 'C Screen',
//           ),
//         ],
//         currentIndex: _calculateSelectedIndex(context),
//         onTap: (int idx) => _onItemTapped(idx, context),
//       ),
//     );
//   }

//   static int _calculateSelectedIndex(BuildContext context) {
//     final String location = GoRouterState.of(context).uri.path;
//     if (location.startsWith('/a')) {
//       return 0;
//     }
//     if (location.startsWith('/b')) {
//       return 1;
//     }
//     if (location.startsWith('/c')) {
//       return 2;
//     }
//     return 0;
//   }

//   void _onItemTapped(int index, BuildContext context) {
//     switch (index) {
//       case 0:
//         GoRouter.of(context).go('/a');
//       case 1:
//         GoRouter.of(context).go('/b');
//       case 2:
//         GoRouter.of(context).go('/c');
//     }
//   }
// }

// /// The first screen in the bottom navigation bar.
// class ScreenA extends StatelessWidget {
//   /// Constructs a [ScreenA] widget.
//   const ScreenA({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             const Text('Screen A'),
//             TextButton(
//               onPressed: () {
//                 GoRouter.of(context).go('/a/details');
//               },
//               child: const Text('View A details'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// /// The second screen in the bottom navigation bar.
// class ScreenB extends StatelessWidget {
//   /// Constructs a [ScreenB] widget.
//   const ScreenB({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             const Text('Screen B'),
//             TextButton(
//               onPressed: () {
//                 GoRouter.of(context).go('/b/details');
//               },
//               child: const Text('View B details'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// /// The third screen in the bottom navigation bar.
// class ScreenC extends StatelessWidget {
//   /// Constructs a [ScreenC] widget.
//   const ScreenC({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             const Text('Screen C'),
//             TextButton(
//               onPressed: () {
//                 GoRouter.of(context).go('/c/details');
//               },
//               child: const Text('View C details'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// /// The details screen for either the A, B or C screen.
// class DetailsScreen extends StatelessWidget {
//   /// Constructs a [DetailsScreen].
//   const DetailsScreen({
//     required this.label,
//     super.key,
//   });

//   /// The label to display in the center of the screen.
//   final String label;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Details Screen'),
//       ),
//       body: Center(
//         child: Text(
//           'Details for $label',
//           style: Theme.of(context).textTheme.headlineMedium,
//         ),
//       ),
//     );
//   }
// }
