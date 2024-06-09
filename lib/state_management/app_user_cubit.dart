import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/domain/usecases/auth/get_current_user.dart';
import 'package:crowdfunding_flutter/domain/usecases/auth/sign_out.dart';
import 'package:crowdfunding_flutter/domain/usecases/user/gift_card/fetch_num_received_unused_gift_card.dart';
import 'package:crowdfunding_flutter/state_management/app_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class AppUserCubit extends Cubit<AppUserState> {
  final logger = Logger();
  final GetCurrentUser _getCurrentUser;
  final SignOut _signOut;
  final FetchNumOfReceivedUnusedGiftCards _fetchNumOfReceivedUnusedGiftCards;
  AppUserCubit({
    required GetCurrentUser getCurrentUser,
    required SignOut signOut,
    required FetchNumOfReceivedUnusedGiftCards
        fetchNumOfReceivedUnusedGiftCards,
  })  : _getCurrentUser = getCurrentUser,
        _signOut = signOut,
        _fetchNumOfReceivedUnusedGiftCards = fetchNumOfReceivedUnusedGiftCards,
        super(const AppUserState.initial());

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

  Future<void> initNumOfReceivedUnusedGiftCards() async {
    final res = await _fetchNumOfReceivedUnusedGiftCards.call(NoPayload());
    res.fold(
      (l) {
        logger.w("Error: ${l.errorMessage}");
      },
      (numRes) {
        logger.w("Received num: ${numRes.numOfGiftCards}");
        emit(state.copyWith(
            numOfReceivedUnusedGiftCards: numRes.numOfGiftCards));
      },
    );
  }
}
