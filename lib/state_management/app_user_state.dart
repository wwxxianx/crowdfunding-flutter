import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:flutter/material.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserLoggedIn extends AppUserState {
  final UserModel user;
  AppUserLoggedIn(this.user);
}
