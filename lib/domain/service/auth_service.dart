import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthService {
  Session? get currentUserSession;

  Future<UserModel?> getCurrentUser();

  Future<UserModel> createUserWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();
}
