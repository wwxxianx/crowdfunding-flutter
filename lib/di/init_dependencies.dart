import 'package:crowdfunding_flutter/state_management/explore/explore_campaigns_bloc.dart';
import 'package:crowdfunding_flutter/state_management/navigation/navigation_cubit.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // core
  serviceLocator.registerLazySingleton(() => NavigationCubit());

  _initExploreCampaigns();
}

void _initExploreCampaigns() {
  serviceLocator.registerLazySingleton(() => ExploreCampaignsBloc());
}
