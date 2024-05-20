import 'dart:convert';

import 'package:crowdfunding_flutter/common/error/exceptions.dart';
import 'package:crowdfunding_flutter/data/local/shared_preference.dart';
import 'package:crowdfunding_flutter/data/network/payload/sign_up_payload.dart';
import 'package:crowdfunding_flutter/data/network/retrofit_api.dart';
import 'package:crowdfunding_flutter/domain/model/tokens_response.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/domain/service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:crowdfunding_flutter/common/constants/constants.dart';

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

      final user = await api.getUserProfile();
      return user;
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
      final userRes = await api.signIn(user.id);
      final tokens = TokensResponse(
          accessToken: userRes.accessToken, refreshToken: userRes.refreshToken);
      await _saveTokens(tokens);
      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  _cacheUser(UserModel user) async {
    await sp.saveData(
        key: Constants.sharedPreferencesKey.user, data: jsonEncode(user));
  }

  _saveTokens(TokensResponse tokens) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(
        Constants.sharedPreferencesKey.accessToken, tokens.accessToken);
    sp.setString(
        Constants.sharedPreferencesKey.refreshToken, tokens.refreshToken);
  }

  @override
  Future<void> signOut() async {
    return await supabaseClient.auth.signOut();
  }
}
