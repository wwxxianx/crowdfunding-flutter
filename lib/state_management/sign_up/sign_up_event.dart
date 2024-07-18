import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class SignUpEvent {
  const SignUpEvent();
}

final class OnSignUp extends SignUpEvent {
  final String email;
  final String password;
  final void Function(UserModel user) onSuccess;
  const OnSignUp({
    required this.email,
    required this.password,
    required this.onSuccess,
  });
}