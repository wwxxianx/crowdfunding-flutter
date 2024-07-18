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
  final NotificationModel? realtimeNotification;

  const AppUserState._({
    this.currentUser,
    this.isConnectingStripeAccount = false,
    this.notifications = const [],
    this.realtimeNotification,
    this.userProfileResult = const ApiResultInitial(),
  });

  const AppUserState.initial() : this._();

  AppUserState copyWith({
    UserModel? currentUser,
    bool? isConnectingStripeAccount,
    List<NotificationModel>? notifications,
    NotificationModel? realtimeNotification,
    ApiResult<UserModel>? userProfileResult,
  }) {
    return AppUserState._(
      currentUser: currentUser ?? this.currentUser,
      isConnectingStripeAccount:
          isConnectingStripeAccount ?? this.isConnectingStripeAccount,
      notifications: notifications ?? this.notifications,
      realtimeNotification: realtimeNotification ?? this.realtimeNotification,
      userProfileResult: userProfileResult ?? this.userProfileResult,
    );
  }

  @override
  List<Object?> get props => [
        currentUser,
        isConnectingStripeAccount,
        notifications,
        realtimeNotification,
        userProfileResult,
      ];
}
