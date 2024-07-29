import 'package:crowdfunding_flutter/data/local/shared_preference.dart';
import 'package:crowdfunding_flutter/data/network/dio.dart';
import 'package:crowdfunding_flutter/data/network/retrofit_api.dart';
import 'package:crowdfunding_flutter/data/repository/auth_repository_impl.dart';
import 'package:crowdfunding_flutter/data/repository/campaign/campaign_repository_impl.dart';
import 'package:crowdfunding_flutter/data/repository/collaboration/collaboration_repository_impl.dart';
import 'package:crowdfunding_flutter/data/repository/community_challenge/community_challenge_repository_impl.dart';
import 'package:crowdfunding_flutter/data/repository/constant_repository_impl.dart';
import 'package:crowdfunding_flutter/data/repository/notification/notification_repository_impl.dart';
import 'package:crowdfunding_flutter/data/repository/organization/organization_repository_impl.dart';
import 'package:crowdfunding_flutter/data/repository/scam_report/scam_report_repository_impl.dart';
import 'package:crowdfunding_flutter/data/repository/user/user_repository_impl.dart';
import 'package:crowdfunding_flutter/data/service/auth_service_impl.dart';
import 'package:crowdfunding_flutter/data/service/payment/payment_service.dart';
import 'package:crowdfunding_flutter/domain/repository/auth_repository.dart';
import 'package:crowdfunding_flutter/domain/repository/campaign/campaign_repository.dart';
import 'package:crowdfunding_flutter/domain/repository/collaboration/collaboration_repository.dart';
import 'package:crowdfunding_flutter/domain/repository/community_challenge/community_challenge_repository.dart';
import 'package:crowdfunding_flutter/domain/repository/constant_repository.dart';
import 'package:crowdfunding_flutter/domain/repository/notification/notification_repository.dart';
import 'package:crowdfunding_flutter/domain/repository/organization/organization_repository.dart';
import 'package:crowdfunding_flutter/domain/repository/scam_report/scam_report_repository.dart';
import 'package:crowdfunding_flutter/domain/repository/user/user_repository.dart';
import 'package:crowdfunding_flutter/domain/service/auth_service.dart';
import 'package:crowdfunding_flutter/domain/usecases/auth/get_current_user.dart';
import 'package:crowdfunding_flutter/domain/usecases/auth/login.dart';
import 'package:crowdfunding_flutter/domain/usecases/auth/sign_out.dart';
import 'package:crowdfunding_flutter/domain/usecases/auth/sign_up.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/campaign_comment/create_campaign_comment.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/campaign_comment/create_campaign_reply.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/campaign_update/create_campaign_update.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/campaign_update/create_campaign_update_recommendation.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/create_campaign.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/donation/create_giftcard_donation.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/fetch_campaign.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/fetch_campaign_categories.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/fetch_campaign_fundraiser.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/fetch_campaigns.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/fetch_close_to_target_campaigns.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/fetch_user_interested_campaigns.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/update_campaign.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/update_campaign_fundraiser.dart';
import 'package:crowdfunding_flutter/domain/usecases/collaboration/accept_collaboration.dart';
import 'package:crowdfunding_flutter/domain/usecases/collaboration/create_campaign_collaboration.dart';
import 'package:crowdfunding_flutter/domain/usecases/collaboration/fetch_campaign_collaboration.dart';
import 'package:crowdfunding_flutter/domain/usecases/collaboration/fetch_collaborations.dart';
import 'package:crowdfunding_flutter/domain/usecases/collaboration/update_campaign_collaboration.dart';
import 'package:crowdfunding_flutter/domain/usecases/community_challenge/create_challenge_participant.dart';
import 'package:crowdfunding_flutter/domain/usecases/community_challenge/fetch_challenge_progress.dart';
import 'package:crowdfunding_flutter/domain/usecases/community_challenge/fetch_community_challenge.dart';
import 'package:crowdfunding_flutter/domain/usecases/community_challenge/fetch_community_challenges.dart';
import 'package:crowdfunding_flutter/domain/usecases/community_challenge/update_challenge_participant.dart';
import 'package:crowdfunding_flutter/domain/usecases/fetch_state_and_regions.dart';
import 'package:crowdfunding_flutter/domain/usecases/notification/fetch_notifications.dart';
import 'package:crowdfunding_flutter/domain/usecases/notification/read_notification.dart';
import 'package:crowdfunding_flutter/domain/usecases/organization/create_organization.dart';
import 'package:crowdfunding_flutter/domain/usecases/organization/fetch_organization.dart';
import 'package:crowdfunding_flutter/domain/usecases/organization/fetch_organization_members.dart';
import 'package:crowdfunding_flutter/domain/usecases/organization/fetch_organizations.dart';
import 'package:crowdfunding_flutter/domain/usecases/organization/fetch_organization_with_code.dart';
import 'package:crowdfunding_flutter/domain/usecases/organization/join_organization.dart';
import 'package:crowdfunding_flutter/domain/usecases/organization/update_organization.dart';
import 'package:crowdfunding_flutter/domain/usecases/scam_report/create_scam_report.dart';
import 'package:crowdfunding_flutter/domain/usecases/stripe/connect_account.dart';
import 'package:crowdfunding_flutter/domain/usecases/stripe/connect_organization_bank_account.dart';
import 'package:crowdfunding_flutter/domain/usecases/stripe/fetch_connected_account.dart';
import 'package:crowdfunding_flutter/domain/usecases/stripe/update_connect_account.dart';
import 'package:crowdfunding_flutter/domain/usecases/user/community_challenge/fetch_participated_challenges.dart';
import 'package:crowdfunding_flutter/domain/usecases/user/donation/fetch_user_donations.dart';
import 'package:crowdfunding_flutter/domain/usecases/user/favourite_campaign/create_favourite_campaign.dart';
import 'package:crowdfunding_flutter/domain/usecases/user/favourite_campaign/delete_favourite_campaign.dart';
import 'package:crowdfunding_flutter/domain/usecases/user/favourite_campaign/fetch_favourite_campaigns.dart';
import 'package:crowdfunding_flutter/domain/usecases/user/fetch_user_profile.dart';
import 'package:crowdfunding_flutter/domain/usecases/user/fetch_users.dart';
import 'package:crowdfunding_flutter/domain/usecases/user/gift_card/fetch_all_gift_cards.dart';
import 'package:crowdfunding_flutter/domain/usecases/user/gift_card/fetch_num_received_unused_gift_card.dart';
import 'package:crowdfunding_flutter/domain/usecases/user/scam_report/fetch_user_submitted_scam_reports.dart';
import 'package:crowdfunding_flutter/domain/usecases/user/tax_receipt/fetch_tax_receipt.dart';
import 'package:crowdfunding_flutter/domain/usecases/user/update_user_profile.dart';
import 'package:crowdfunding_flutter/state_management/app_user_cubit.dart';
import 'package:crowdfunding_flutter/state_management/explore/explore_campaigns_bloc.dart';
import 'package:crowdfunding_flutter/state_management/gift_card/gift_card_bloc.dart';
import 'package:crowdfunding_flutter/state_management/home/home_bloc.dart';
import 'package:crowdfunding_flutter/state_management/navigation/navigation_cubit.dart';
import 'package:crowdfunding_flutter/state_management/sign_up/sign_up_bloc.dart';
import 'package:crowdfunding_flutter/state_management/user/favourite_campaign/favourite_campaign_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
      url: "https://dopwacnojucwkhhdoiqd.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRvcHdhY25vanVjd2toaGRvaXFkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTc4MjU2MzcsImV4cCI6MjAzMzQwMTYzN30.vqTc8vyjpg6x5dZftpgYbmASLf42W3-K2BPAJ1mRh34");

  serviceLocator.registerLazySingleton<SupabaseClient>(() => supabase.client);

  // core
  serviceLocator
    ..registerLazySingleton(() => AppUserCubit(
          getCurrentUser: serviceLocator(),
          signOut: serviceLocator(),
          fetchNotifications: serviceLocator(),
          connectAccount: serviceLocator(),
          toggleReadNotification: serviceLocator(),
          supabase: serviceLocator(),
          fetchUserProfile: serviceLocator(),
          updateUserProfile: serviceLocator(),
        ))
    ..registerLazySingleton(() => NavigationCubit())
    ..registerLazySingleton(() => DioNetwork.provideDio())
    ..registerLazySingleton(() => MySharedPreference())
    ..registerLazySingleton(() => RestClient(serviceLocator()));

  _initAuth();
  _initExploreCampaigns();
  _initCampaign();
  _initConstant();
  _initUser();
  _initPayment();
  _initGiftCard();
  _initOrganization();
  _initNotification();
  _initCollaboration();
  _initCommunityChallenge();
  _initScamReport();
}

void _initScamReport() {
  serviceLocator
    // Repo
    ..registerFactory<ScamReportRepository>(
        () => ScamReportRepositoryImpl(api: serviceLocator()))
    // Usecase
    ..registerFactory(
        () => CreateScamReport(scamReportRepository: serviceLocator()));
}

void _initCommunityChallenge() {
  serviceLocator
    // Repo
    ..registerFactory<CommunityChallengeRepository>(
        () => CommunityChallengeRepositoryImpl(api: serviceLocator()))
    // Usecase
    ..registerFactory(() => FetchCommunityChallenges(
        communityChallengeRepository: serviceLocator()))
    ..registerFactory(() =>
        FetchCommunityChallenge(communityChallengeRepository: serviceLocator()))
    ..registerFactory(() =>
        FetchChallengeProgress(communityChallengeRepository: serviceLocator()))
    ..registerFactory(() => CreateChallengeParticipant(
        communityChallengeRepository: serviceLocator()))
    ..registerFactory(() => UpdateChallengeParticipant(
        communityChallengeRepository: serviceLocator()));
}

void _initCollaboration() {
  serviceLocator
    // Repo
    ..registerFactory<CollaborationRepository>(
        () => CollaborationRepositoryImpl(api: serviceLocator()))
    // Usecase
    ..registerFactory(
        () => FetchCollaboration(collaborationRepository: serviceLocator()))
    ..registerFactory(() =>
        CreateCampaignCollaboration(collaborationRepository: serviceLocator()))
    ..registerFactory(() =>
        UpdateCampaignCollaboration(collaborationRepository: serviceLocator()))
    ..registerFactory(
        () => FetchCollaborations(collaborationRepository: serviceLocator()))
    ..registerFactory(
        () => AcceptCollaboration(collaborationRepository: serviceLocator()));
}

void _initNotification() {
  serviceLocator
    // Repo
    ..registerFactory<NotificationRepository>(
        () => NotificationRepositoryImpl(api: serviceLocator()))
    // Usecase
    ..registerFactory(
        () => FetchNotifications(notificationRepository: serviceLocator()))
    ..registerFactory(
        () => ToggleReadNotification(notificationRepository: serviceLocator()));
}

void _initExploreCampaigns() {
  serviceLocator.registerLazySingleton(() => ExploreCampaignsBloc(
        fetchCampaigns: serviceLocator(),
      ));
}

void _initAuth() {
  serviceLocator
    //Service
    ..registerFactory<AuthService>(
      () => AuthServiceImpl(
        api: serviceLocator(),
        supabaseClient: serviceLocator(),
        sp: serviceLocator(),
      ),
    )
    //Repo
    ..registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(authService: serviceLocator()))
    //Usecases
    // ..registerFactory(() => Login(serviceLocator()))
    ..registerFactory(() => GetCurrentUser(serviceLocator()))
    ..registerFactory(() => SignOut(serviceLocator()))
    ..registerFactory(() => SignUp(serviceLocator()))
    ..registerFactory(() => Login(authRepository: serviceLocator()))
    //Bloc
    ..registerLazySingleton(() => SignUpBloc(
          signUp: serviceLocator(),
        ));
}

void _initCampaign() {
  serviceLocator
    // Repo
    ..registerFactory<CampaignRepository>(() =>
        CampaignRepositoryImpl(api: serviceLocator(), sp: serviceLocator()))
    // Usecase
    ..registerFactory(
        () => FetchCampaigns(campaignRepository: serviceLocator()))
    ..registerFactory(() => FetchCampaign(campaignRepository: serviceLocator()))
    ..registerFactory(
        () => CreateCampaign(campaignRepository: serviceLocator()))
    ..registerFactory(
        () => UpdateCampaign(campaignRepository: serviceLocator()))
    ..registerFactory(
        () => CreateCampaignComment(campaignRepository: serviceLocator()))
    ..registerFactory(
        () => CreateCampaignReply(campaignRepository: serviceLocator()))
    ..registerFactory(
        () => CreateCampaignUpdate(campaignRepository: serviceLocator()))
    ..registerFactory(
        () => CreateGiftCardDonation(campaignRepository: serviceLocator()))
    ..registerFactory(
        () => FetchCampaignFundraiser(campaignRepository: serviceLocator()))
    ..registerFactory(
        () => UpdateCampaignFundraiser(campaignRepository: serviceLocator()))
    ..registerFactory(
        () => FetchCloseToTargetCampaigns(campaignRepository: serviceLocator()))
    ..registerFactory(() =>
        FetchUserInterestedCampaigns(campaignRepository: serviceLocator()))
    ..registerFactory(() =>
        CreateCampaignUpdateRecommendation(campaignRepository: serviceLocator()))
    // Bloc
    ..registerLazySingleton(() => HomeBloc(
          fetchCampaign: serviceLocator(),
          paymentService: serviceLocator(),
          fetchOrganizations: serviceLocator(),
          fetchCloseToTargetCampaigns: serviceLocator(),
          fetchUserInterestedCampaigns: serviceLocator(),
        ));
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

void _initUser() {
  serviceLocator
    // Repo
    ..registerFactory<UserRepository>(() => UserRepositoryImpl(
        api: serviceLocator(),
        sp: serviceLocator(),
        authService: serviceLocator()))
    // Bloc
    ..registerLazySingleton(() => FavouriteCampaignBloc(
          createFavouriteCampaign: serviceLocator(),
          getFavouriteCampaigns: serviceLocator(),
          deleteFavouriteCampaign: serviceLocator(),
        ))
    // Usecases
    ..registerFactory(() => UpdateUserProfile(userRepository: serviceLocator()))
    ..registerFactory(
        () => FetchFavouriteCampaigns(userRepository: serviceLocator()))
    ..registerFactory(
        () => CreateFavouriteCampaign(userRepository: serviceLocator()))
    ..registerFactory(
        () => DeleteFavouriteCampaign(userRepository: serviceLocator()))
    ..registerFactory(() => FetchUsers(userRepository: serviceLocator()))
    ..registerFactory(() =>
        FetchNumOfReceivedUnusedGiftCards(userRepository: serviceLocator()))
    ..registerFactory(() => FetchUserProfile(userRepository: serviceLocator()))
    ..registerFactory(
        () => FetchParticipatedChallenges(userRepository: serviceLocator()))
    ..registerFactory(
        () => FetchUserDonations(userRepository: serviceLocator()))
    ..registerFactory(() => FetchTaxReceipt(userRepository: serviceLocator()))
    ..registerFactory(
        () => FetchUserSubmittedScamReports(userRepository: serviceLocator()));
}

void _initOrganization() {
  serviceLocator
    // Repo
    ..registerFactory<OrganizationRepository>(() => OrganizationRepositoryImpl(
        api: serviceLocator(), authService: serviceLocator()))
    // Usecase
    ..registerFactory(
        () => CreateOrganization(organizationRepository: serviceLocator()))
    ..registerFactory(() =>
        FetchOrganizationWithCode(organizationRepository: serviceLocator()))
    ..registerFactory(
        () => JoinOrganization(organizationRepository: serviceLocator()))
    ..registerFactory(
        () => FetchOrganization(organizationRepository: serviceLocator()))
    ..registerFactory(
        () => FetchOrganizations(organizationRepository: serviceLocator()))
    ..registerFactory(() =>
        FetchOrganizationMembers(organizationRepository: serviceLocator()))
    ..registerFactory(
        () => UpdateOrganization(organizationRepository: serviceLocator()));
}

void _initPayment() {
  serviceLocator
    ..registerFactory<PaymentService>(
        () => PaymentService(api: serviceLocator()))
    ..registerFactory(() => ConnectAccount(paymentService: serviceLocator()))
    ..registerFactory(
        () => FetchConnectedAccount(paymentService: serviceLocator()))
    ..registerFactory(
        () => UpdateConnectAccount(paymentService: serviceLocator()))
    ..registerFactory(
        () => ConnectOrganizationBankAccount(paymentService: serviceLocator()));
}

void _initGiftCard() {
  serviceLocator
    // Bloc
    ..registerLazySingleton(
        () => GiftCardBloc(fetchAllGiftCards: serviceLocator()))
    // Usecase
    ..registerFactory(
        () => FetchAllGiftCards(userRepository: serviceLocator()));
}
