import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/domain/usecases/auth/get_current_user.dart';
import 'package:crowdfunding_flutter/state_management/app_user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppUserCubit extends Cubit<AppUserState> {
  final GetCurrentUser _getCurrentUser;
  AppUserCubit({
    required GetCurrentUser getCurrentUser,
  })  : _getCurrentUser = getCurrentUser,
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

  
}
