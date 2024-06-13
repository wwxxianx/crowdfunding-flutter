import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/domain/usecases/auth/get_current_user.dart';
import 'package:crowdfunding_flutter/domain/usecases/auth/sign_out.dart';
import 'package:crowdfunding_flutter/domain/usecases/notification/fetch_notifications.dart';
import 'package:crowdfunding_flutter/domain/usecases/notification/read_notification.dart';
import 'package:crowdfunding_flutter/domain/usecases/stripe/connect_account.dart';
import 'package:crowdfunding_flutter/state_management/app_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class AppUserCubit extends Cubit<AppUserState> {
  final logger = Logger();
  final ConnectAccount _connectAccount;
  final GetCurrentUser _getCurrentUser;
  final SignOut _signOut;
  final FetchNotifications _fetchNotifications;
  final ToggleReadNotification _toggleReadNotification;

  AppUserCubit({
    required GetCurrentUser getCurrentUser,
    required SignOut signOut,
    required ConnectAccount connectAccount,
    required FetchNotifications fetchNotifications,
    required ToggleReadNotification toggleReadNotification,
  })  : _getCurrentUser = getCurrentUser,
        _signOut = signOut,
        _connectAccount = connectAccount,
        _fetchNotifications = fetchNotifications,
        _toggleReadNotification = toggleReadNotification,
        super(const AppUserState.initial());

  Future<void> toggleReadNotification({required String notificationId}) async {
    final res = await _toggleReadNotification.call(notificationId);
    res.fold(
      (l) => null,
      (newNotification) {
        final updatedNotifications = state.notifications.map((notification) {
          if (notification.id == newNotification.id) {
            return newNotification;
          }
          return notification;
        }).toList();
        emit(state.copyWith(notifications: updatedNotifications));
      },
    );
  }

  Future<void> fetchNotifications() async {
    final currentUser = state.currentUser;
    if (currentUser == null) {
      return;
    }

    final res = await _fetchNotifications.call(NoPayload());
    res.fold(
      (l) {},
      (notifications) => emit(state.copyWith(notifications: notifications)),
    );
  }

  Future<void> connectStripeAccount(
    void Function(String onboardLink) onSuccess,
  ) async {
    emit(state.copyWith(isConnectingStripeAccount: true));
    final res = await _connectAccount.call(NoPayload());
    res.fold(
      (l) {
        state.copyWith(isConnectingStripeAccount: false);
      },
      (res) {
        emit(state.copyWith(isConnectingStripeAccount: false));
        onSuccess(res.onboardLink);
      },
    );
  }

  void updateUser(UserModel? user) {
    if (user == null) {
      emit(const AppUserState.initial());
    } else {
      emit(state.copyWith(currentUser: user));
    }
  }

  Future<bool> checkUserLoggedIn() async {
    bool userIsLoggedIn = false;
    final res = await _getCurrentUser(NoPayload());
    res.fold(
      (failure) => emit(const AppUserState.initial()),
      (user) {
        emit(state.copyWith(currentUser: user));
        userIsLoggedIn = true;
      },
    );
    return userIsLoggedIn;
  }

  Future<void> signOut({
    VoidCallback? onSuccess,
  }) async {
    await _signOut.call(NoPayload());
    updateUser(null);
    if (onSuccess != null) {
      onSuccess();
    }
  }
}
