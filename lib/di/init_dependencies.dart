import 'package:crowdfunding_flutter/state_management/navigation/navigation_cubit.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // core
  serviceLocator.registerLazySingleton(() => NavigationCubit());
}
