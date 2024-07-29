import 'package:crowdfunding_flutter/data/network/api_result.dart';
import 'package:crowdfunding_flutter/domain/model/notification/notification.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:equatable/equatable.dart';

// @immutable
// sealed class AppUserState {}

// final class AppUserInitial extends AppUserState {}

// final class AppUserLoggedIn extends AppUserState {
//   final UserModel user;
//   final int numOfReceivedUnusedGiftCards;
//   AppUserLoggedIn({
//     required this.user,
//     this.numOfReceivedUnusedGiftCards = 0,
//   });
// }

final class AppUserState extends Equatable {
  final UserModel? currentUser;
  final ApiResult<UserModel> userProfileResult;
  final bool isConnectingStripeAccount;
  final List<NotificationModel> notifications;
  final NotificationModel? unreadCommunityChallengeRewardNotification;
  final NotificationModel? unreadCampaignStatusChangedNotification;

  const AppUserState._({
    this.currentUser,
    this.isConnectingStripeAccount = false,
    this.notifications = const [],
    this.unreadCommunityChallengeRewardNotification,
    this.userProfileResult = const ApiResultInitial(),
    this.unreadCampaignStatusChangedNotification,
  });

  const AppUserState.initial() : this._();

  AppUserState copyWith({
    UserModel? currentUser,
    bool? isConnectingStripeAccount,
    List<NotificationModel>? notifications,
    NotificationModel? unreadCommunityChallengeRewardNotification,
    ApiResult<UserModel>? userProfileResult,
    NotificationModel? unreadCampaignStatusChangedNotification,
  }) {
    return AppUserState._(
      currentUser: currentUser ?? this.currentUser,
      isConnectingStripeAccount:
          isConnectingStripeAccount ?? this.isConnectingStripeAccount,
      notifications: notifications ?? this.notifications,
      unreadCommunityChallengeRewardNotification:
          unreadCommunityChallengeRewardNotification ??
              this.unreadCommunityChallengeRewardNotification,
      userProfileResult: userProfileResult ?? this.userProfileResult,
      unreadCampaignStatusChangedNotification:
          unreadCampaignStatusChangedNotification ??
              this.unreadCampaignStatusChangedNotification,
    );
  }

  @override
  List<Object?> get props => [
        currentUser,
        isConnectingStripeAccount,
        notifications,
        unreadCommunityChallengeRewardNotification,
        userProfileResult,
        unreadCampaignStatusChangedNotification,
      ];
}
