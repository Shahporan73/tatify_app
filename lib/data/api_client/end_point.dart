
class EndPoint {
  static const String BASE_URL = 'http://192.168.10.180:5200/api/v1';

  // auth endpoint
  static const String createUserURL = '$BASE_URL/user/create-customer';
  static const String loginURL = '$BASE_URL/auth/login';
  static const String verifyEmailByOtpURL = '$BASE_URL/user/email-verify';

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
  static String nearbyRestaurantsURL({double? lat, double? long, String? distance, int? limit}) {
    final queryParams = <String, String>{};
    if (lat != null) queryParams['lat'] = lat.toString();
    if (long != null) queryParams['long'] = long.toString();
    if (distance != null) queryParams['distance'] = distance.toString();
    if (limit != null) queryParams['limit'] = limit.toString();

    final queryString = queryParams.entries.map((e) => '${e.key}=${e.value}').join('&');
    return '$BASE_URL/restaurant/near-by-restaurant${queryString.isNotEmpty ? '?$queryString' : ''}';
  }

//   favorites
  static const String addFavoriteURL = '$BASE_URL/favorite/create';
  static String removeFavoriteURL({required String restaurantId}) => '$BASE_URL/favorite/$restaurantId';
  static const String getFavoriteURL = '$BASE_URL/favorite/';




//   create vendor
  static const String createVendorURL = '$BASE_URL/user/create-vendor';
  static const String createRestaurantURL = '$BASE_URL/restaurant/create-restaurant';

}