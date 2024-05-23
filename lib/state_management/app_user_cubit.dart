import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/domain/usecases/auth/get_current_user.dart';
import 'package:crowdfunding_flutter/domain/usecases/auth/sign_out.dart';
import 'package:crowdfunding_flutter/state_management/app_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppUserCubit extends Cubit<AppUserState> {
  final GetCurrentUser _getCurrentUser;
  final SignOut _signOut;
  AppUserCubit({
    required GetCurrentUser getCurrentUser,
    required SignOut signOut,
  })  : _getCurrentUser = getCurrentUser,
        _signOut = signOut,
        super(AppUserInitial());

  void updateUser(UserModel? user) {
    if (user == null) {
      emit(AppUserInitial());
    } else {
      emit(AppUserLoggedIn(user));
    }
  }

  Future<void> checkUserLoggedIn() async {
    final res = await _getCurrentUser(NoPayload());

    res.fold(
      (l) => emit(AppUserInitial()),
      (r) => emit(AppUserLoggedIn(r)),
    );
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
