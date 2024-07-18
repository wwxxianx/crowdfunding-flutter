import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:equatable/equatable.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();
}

final class SignUpInitial extends SignUpState {
  @override
  List<Object?> get props => [];
}

final class SignUpLoading extends SignUpState {
  @override
  List<Object?> get props => [];
}

final class SignUpSuccess extends SignUpState {
  // Get back from API
  // Save into SP for later use
  final UserModel? user;
  const SignUpSuccess(this.user);

  @override
  List<Object?> get props => [
        user,
      ];
}

final class SignUpFailure extends SignUpState {
  final String message;
  const SignUpFailure(this.message);

  @override
  List<Object?> get props => [message];
}
