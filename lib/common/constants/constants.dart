class Constants {
  Constants._();
  static const sharedPreferencesKey = SharedPreferencesKey();
  static const apiUrl = "https://b318-180-74-225-120.ngrok-free.app/";

  static const stripePublishableKey =
      "pk_test_51OmSFdIGtvkAiXyxrpvC4ohbIbN4COdgvxZlihCNKSE0j0AR8gg4hXvYcj9MQKUxSS4J7LjMGHUDTA5fG2ynSFQs00EODoklrH";
  static const appLinkDomain = 'http://wwxxianx.github.io';
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
