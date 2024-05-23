class Constants {
  Constants._();
  static const sharedPreferencesKey = SharedPreferencesKey();
  static const apiUrl =
      "https://2f35-2001-f40-987-516-e8bb-4157-bc82-df6b.ngrok-free.app/";
}

class SharedPreferencesKey {
  const SharedPreferencesKey();

  // User
  final String user = "user";

  // Auth
  final String accessToken = "accessToken";
  final String refreshToken = "refreshToken";

  // App data constants
  final String stateAndRegion = "stateAndRegion";
  final String stateAndRegionExpiration = "stateAndRegionExpiration";
  final String campaignCategories = "campaignCategories";
  final String campaignCategoriesExpiration = "campaignCategoriesExpiration";
}
