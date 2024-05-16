import 'package:crowdfunding_flutter/common/error/exceptions.dart';
import 'package:crowdfunding_flutter/data/network/dto/sign_up_payload.dart';
import 'package:crowdfunding_flutter/data/network/retrofit_api.dart';
import 'package:crowdfunding_flutter/domain/model/tokens_response.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/domain/service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:crowdfunding_flutter/common/constants/constants.dart';

class AuthServiceImpl implements AuthService {
  final SupabaseClient supabaseClient;
  final RestClient restClient;
  AuthServiceImpl({
    required this.supabaseClient,
    required this.restClient,
  });

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

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
      final signUpDto =
          SignUpPayload(id: user.id, email: user.email ?? "", fullName: fullName);
      final tokens = await restClient.signUp(signUpDto);
      await _saveTokens(tokens);
      return UserModel.fromJson(res.user!.toJson());
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
      if (response.user == null) {
        throw const ServerException('Failed to sign you in!');
      }
      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
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
