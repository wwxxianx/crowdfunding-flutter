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
  final bool isConnectingStripeAccount;
  final List<NotificationModel> notifications;

  const AppUserState._({
    this.currentUser,
    this.isConnectingStripeAccount = false,
    this.notifications = const [],
  });

  const AppUserState.initial() : this._();

  AppUserState copyWith({
    UserModel? currentUser,
    bool? isConnectingStripeAccount,
    List<NotificationModel>? notifications,
  }) {
    return AppUserState._(
      currentUser: currentUser ?? this.currentUser,
      isConnectingStripeAccount:
          isConnectingStripeAccount ?? this.isConnectingStripeAccount,
      notifications: notifications ?? this.notifications,
    );
  }

  @override
  List<Object?> get props => [
        currentUser,
        isConnectingStripeAccount,
        notifications,
      ];
}
