class Constants {
  Constants._();
  static const sharedPreferencesKey = SharedPreferencesKey();
}

class SharedPreferencesKey {
  const SharedPreferencesKey();
  final String accessToken = "accessToken";
  final String refreshToken = "refreshToken";
}
