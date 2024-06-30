import 'dart:convert';

import 'package:crowdfunding_flutter/common/constants/constants.dart';
import 'package:crowdfunding_flutter/common/error/exceptions.dart';
import 'package:crowdfunding_flutter/data/local/shared_preference.dart';
import 'package:crowdfunding_flutter/data/network/payload/auth/login_be_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/auth/sign_up_payload.dart';
import 'package:crowdfunding_flutter/data/network/retrofit_api.dart';
import 'package:crowdfunding_flutter/domain/model/tokens_response.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/domain/service/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServiceImpl implements AuthService {
  final SupabaseClient supabaseClient;
  final RestClient api;
  final MySharedPreference sp;
  AuthServiceImpl({
    required this.supabaseClient,
    required this.api,
    required this.sp,
  });

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final cachedUser = await sp.getData(Constants.sharedPreferencesKey.user);
      if (cachedUser != null) {
        final user = UserModel.fromJson(jsonDecode(cachedUser));
        return user;
      }
      return null;
    } on Exception catch (_) {
      return null;
    }
  }

  @override
  Future<UserModel> createUserWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final res = await supabaseClient.auth.signUp(
        password: password,
        email: email,
      );
      final user = res.user;
      if (user == null) {
        throw const ServerException("Failed to create account.");
      }
      final fullName = user.email?.split("@").first ?? "";
      // Create user record in db
      final signUpPayload = SignUpPayload(
          id: user.id, email: user.email ?? "", fullName: fullName);
      final tokens = await api.signUp(signUpPayload);
      await _saveTokens(tokens);

      // cache user
      final userModel = UserModel(
        id: user.id,
        fullName: fullName,
        email: email,
        isOnboardingCompleted: false,
      );
      _cacheUser(userModel);
      return userModel;
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      final user = response.user;
      if (user == null) {
        throw const ServerException('Failed to sign you in!');
      }
      final UserModelWithAccessToken userRes =
          await api.signIn(LoginBEPayload(userId: user.id));
      _cacheUser(userRes.toUserModel());
      final tokens = TokensResponse(
          accessToken: userRes.accessToken, refreshToken: userRes.refreshToken);
      await _saveTokens(tokens);

      return userRes.toUserModel();
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    await supabaseClient.auth.signOut();
    sp.clearData(Constants.sharedPreferencesKey.user);
    sp.clearData(Constants.sharedPreferencesKey.accessToken);
    sp.clearData(Constants.sharedPreferencesKey.refreshToken);
  }

  @override
  Future<void> updateCacheUser({required UserModel user}) async {
    await _cacheUser(user);
  }

  _cacheUser(UserModel user) async {
    await sp.saveData(
        key: Constants.sharedPreferencesKey.user, data: jsonEncode(user));
  }

  _saveTokens(TokensResponse tokens) async {
    sp.saveData(
      key: Constants.sharedPreferencesKey.accessToken,
      data: tokens.accessToken,
    );
    sp.saveData(
      key: Constants.sharedPreferencesKey.refreshToken,
      data: tokens.refreshToken,
    );
  }
}
