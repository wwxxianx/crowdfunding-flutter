class Constants {
  Constants._();
  static const sharedPreferencesKey = SharedPreferencesKey();
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
