import 'package:crowdfunding_flutter/data/local/shared_preference.dart';
import 'package:crowdfunding_flutter/data/network/dio.dart';
import 'package:crowdfunding_flutter/data/network/retrofit_api.dart';
import 'package:crowdfunding_flutter/data/repository/auth_repository_impl.dart';
import 'package:crowdfunding_flutter/data/repository/campaign/campaign_repository_impl.dart';
import 'package:crowdfunding_flutter/data/repository/constant_repository_impl.dart';
import 'package:crowdfunding_flutter/data/service/auth_service_impl.dart';
import 'package:crowdfunding_flutter/domain/repository/auth_repository.dart';
import 'package:crowdfunding_flutter/domain/repository/campaign/campaign_repository.dart';
import 'package:crowdfunding_flutter/domain/repository/constant_repository.dart';
import 'package:crowdfunding_flutter/domain/service/auth_service.dart';
import 'package:crowdfunding_flutter/domain/usecases/auth/sign_out.dart';
import 'package:crowdfunding_flutter/domain/usecases/auth/sign_up.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/fetch_campaign.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/fetch_campaign_categories.dart';
import 'package:crowdfunding_flutter/domain/usecases/fetch_state_and_regions.dart';
import 'package:crowdfunding_flutter/state_management/app_user_cubit.dart';
import 'package:crowdfunding_flutter/state_management/explore/explore_campaigns_bloc.dart';
import 'package:crowdfunding_flutter/state_management/home/home_bloc.dart';
import 'package:crowdfunding_flutter/state_management/navigation/navigation_cubit.dart';
import 'package:crowdfunding_flutter/state_management/sign_up/sign_up_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
      url: "https://yyavkrjmlxoqxeeybxuc.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl5YXZrcmptbHhvcXhlZXlieHVjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTU0OTcyNjMsImV4cCI6MjAzMTA3MzI2M30.M9Fr10hV4nydDqUaJHzmve91jDYrO_POprT4txlqK9o");

  serviceLocator.registerLazySingleton(() => supabase.client);

  // core
  serviceLocator
    ..registerLazySingleton(() => AppUserCubit())
    ..registerLazySingleton(() => NavigationCubit())
    ..registerLazySingleton(() => DioNetwork.provideDio())
    ..registerLazySingleton(() => MySharedPreference())
    ..registerLazySingleton(() => RestClient(serviceLocator()));

  _initAuth();
  _initExploreCampaigns();
  _initCampaign();
  _initConstant();
}

void _initExploreCampaigns() {
  serviceLocator.registerLazySingleton(() => ExploreCampaignsBloc());
}

void _initAuth() {
  serviceLocator
    //Service
    ..registerFactory<AuthService>(
      () => AuthServiceImpl(
        restClient: serviceLocator(),
        supabaseClient: serviceLocator(),
      ),
    )
    //Repo
    ..registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(serviceLocator()))
    //Usecases
    // ..registerFactory(() => Login(serviceLocator()))
    // ..registerFactory(() => GetCurrentUser(serviceLocator()))
    ..registerFactory(() => SignOut(serviceLocator()))
    ..registerFactory(() => SignUp(serviceLocator()))
    //Bloc
    ..registerLazySingleton(() => SignUpBloc(
          // login: serviceLocator(),
          // getCurrentUser: serviceLocator(),
          appUserCubit: serviceLocator(),
          signOut: serviceLocator(),
          signUp: serviceLocator(),
        ));
}

void _initCampaign() {
  serviceLocator
    // Repo
    ..registerFactory<CampaignRepository>(() =>
        CampaignRepositoryImpl(api: serviceLocator(), sp: serviceLocator()))
    // Usecase
    ..registerFactory(() => FetchCampaign(campaignRepository: serviceLocator()))
    // Bloc
    ..registerLazySingleton(() => HomeBloc(fetchCampaign: serviceLocator()));
}

void _initConstant() {
  serviceLocator
    ..registerFactory<ConstantRepository>(() =>
        ConstantRepositoryImpl(api: serviceLocator(), sp: serviceLocator()))
    ..registerFactory(
        () => FetchStateAndRegions(constantRepository: serviceLocator()))
    ..registerFactory(
        () => FetchCampaignCategories(campaignRepository: serviceLocator()));
}
