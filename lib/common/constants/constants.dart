class Constants {
  Constants._();
  static const sharedPreferencesKey = SharedPreferencesKey();
  static const apiUrl =
      "https://cb59-2405-3800-88d-ab9d-8d4c-3ccb-457a-6b68.ngrok-free.app/";

  static const stripePublishableKey =
      "pk_test_51OmSFdIGtvkAiXyxrpvC4ohbIbN4COdgvxZlihCNKSE0j0AR8gg4hXvYcj9MQKUxSS4J7LjMGHUDTA5fG2ynSFQs00EODoklrH";
  static const appLinkDomain = 'http://wwxxianx.github.io';
  static const onesignalID = '55e1a80f-4f70-4819-8da3-431949cc2c1d';
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
