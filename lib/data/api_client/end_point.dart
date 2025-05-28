
class EndPoint {
  static const String MAP_KEY = 'AIzaSyAYU95zhhNeRjmDdr2AckdfQxz2zm9HHNQ';

  // local baseURl
  // static const String BASE_URL = 'http://192.168.10.180:5200/api/v1';

  // live baseURl
  static const String BASE_URL = 'https://taste-point.com/api/v1';

  // auth endpoint
  static const String createUserURL = '$BASE_URL/user/create-customer';
  static const String loginURL = '$BASE_URL/auth/login';
  static const String verifyEmailByOtpURL = '$BASE_URL/user/email-verify';

  // social auth endpoint
  static const String socialAuthURL = '$BASE_URL/auth/social-auth';

  static String resendOtpUrl({required dynamic email}) => '$BASE_URL/user/send-verify-otp/$email';

  // forgot password
  static const String forgotPasswordURL = '$BASE_URL/auth/forgot-password';
  static const String otpVerifyURL = '$BASE_URL/auth/verify-otp';
  static const String resetPasswordURL = '$BASE_URL/auth/reset-password';

  //   profile
  static const String profileURL = '$BASE_URL/user/get-me';
  static const String changePasswordURL = '$BASE_URL/auth/change-password';
  static const String deleteAccountURL = '$BASE_URL/user/delete-me';
  static String editProfileURL({required dynamic id}) => '$BASE_URL/user/update-user-info/$id';

// rules
  static const String privacyPolicyURL = '$BASE_URL/pat/privacy';
  static const String termsAndConditionURL = '$BASE_URL/pat/terms';
  static const String aboutUsURL = '$BASE_URL/pat/about';

//   nearby restaurants
  static String nearbyRestaurantsURL({String? searchTerm, double? lat, double? long, String? distance, int? limit}) {
    final queryParams = <String, String>{};
    if (searchTerm != null) queryParams['searchTerm'] = searchTerm.toString();
    if (lat != null) queryParams['lat'] = lat.toString();
    if (long != null) queryParams['long'] = long.toString();
    if (distance != null) queryParams['distance'] = distance.toString();
    if (limit != null) queryParams['limit'] = limit.toString();

    final queryString = queryParams.entries.map((e) => '${e.key}=${e.value}').join('&');
    return '$BASE_URL/restaurant/near-by-restaurant${queryString.isNotEmpty ? '?$queryString' : ''}';
  }

  static String singleRestaurantURL({required String id}) => '$BASE_URL/restaurant/single-restaurant/$id';

//   favorites
  static const String addFavoriteURL = '$BASE_URL/favorite/create';
  static String removeFavoriteURL({required String restaurantId}) => '$BASE_URL/favorite/$restaurantId';
  static const String getFavoriteURL = '$BASE_URL/favorite/';
  static String isFavoriteURL({required String restaurantId}) => '$BASE_URL/favorite/is-my-fav-restaurant/$restaurantId';


  /// review
  static const String createReviewURL = '$BASE_URL/ratings/create';
  static String getReviewURL({required String restaurantId}) => '$BASE_URL/ratings/$restaurantId';

  /// redeem
  static const String createRedeemURL = '$BASE_URL/redeem/create';
  static const String userRedeemURL = '$BASE_URL/redeem/user-redeem';
  static const String vendorRedeemURL = '$BASE_URL/redeem/vendor-redeem';
  static String getRedeemURL({String? userId, String? vendorId, int? limit, int? page}) {
    final queryParams = <String, String>{};
    if (userId != null) queryParams['user'] = userId.toString();
    if (vendorId != null) queryParams['vendor'] = vendorId.toString();
    if (limit != null) queryParams['limit'] = limit.toString();
    if (page != null) queryParams['page'] = page.toString();

    final queryString = queryParams.entries.map((e) => '${e.key}=${e.value}').join('&');
    return '$BASE_URL/redeem/my-bookings${queryString.isNotEmpty ? '?$queryString' : ''}';
  }

///   create vendor
  static const String createVendorURL = '$BASE_URL/user/create-vendor';
  static const String createRestaurantURL = '$BASE_URL/restaurant/create-restaurant';
  static const String updateRestaurantURL = '$BASE_URL/restaurant/update-my-restaurant';
  static const String getMyRestaurantsURL = '$BASE_URL/restaurant/my-restaurant';

//   food
  static const String createFoodURL = '$BASE_URL/foods/create';
  static String getFoodsURL({String? restaurantId, String? searchTerm, int? limit, int? page}) {
    final queryParams = <String, String>{};
    if (restaurantId != null) queryParams['restaurant'] = restaurantId.toString();
    if (searchTerm != null) queryParams['searchTerm'] = searchTerm.toString();
    if (limit != null) queryParams['limit'] = limit.toString();
    if (page != null) queryParams['page'] = page.toString();

    final queryString = queryParams.entries.map((e) => '${e.key}=${e.value}').join('&');
    return '$BASE_URL/foods${queryString.isNotEmpty ? '?$queryString' : ''}';
  }

  static String updateFoodURL({required String foodId}) => '$BASE_URL/foods/update/$foodId';


//   notification
  static const String notificationURL = '$BASE_URL/notification';
  static const String readAllNotificationURL = '$BASE_URL/notification/read-all-notification';

//   overview
  static String netIncomeURL({required String month}) => '$BASE_URL/overview/vendor-net-income?month=$month&limit=6';
  static String getTotalCommissionURL({required String year}) => '$BASE_URL/overview/vendor-commission?year=$year';

//   payment
  static const String getSubscriptionURL = '$BASE_URL/subscription';
  static String paymentURL({required String subscriptionId}) => '$BASE_URL/subscription/pay/$subscriptionId';

}
