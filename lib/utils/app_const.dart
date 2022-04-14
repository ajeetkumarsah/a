class AppConstants {
  static const String APP_NAME = 'WTF';
  static const int APP_VERSION = 1;

  static const String BASE_URL_PROD = 'https://api.wtfup.me';
  static const String BASE_URL_DEV = 'https://devapi.wtfup.me';
  static const String GYMS_URI =
      '/gym/nearestgym?lat=28.596810623106776&long=77.32860348160632&type=gym';
  static String GYM_DETAILS(String id) => '/gym/getbyid?uid=$id';
  static String MEMBERSHIP_PLANS(String id) => '/plan?gym_id=$id';
  static String OFFERS(String id) => '/offer/?page=1&limit=10&keyword=$id';
  static const String LOGIN_WITH_MAIL_URL = '/user/login';
  static const String LOGIN_WITH_OTP_URL = '/user/mobile/otp';
  static const String LOGIN_WITH_MOBILE_URL = '/user/mobile/login';
  static const String SIGNUP_URL = '/user/add';
  static const String ADD_MEMBERSHIP = '/member/add';
  static const String SEND_OTP_URL = '/user/mobile/otp';
  static const String GET_ORDER_ID = '/transaction/get_order_id';
  static const String VERIFY_PAYMENT_URL = '/subscription/verifyPayment';
  static String GET_MEMBER_INFO_URL(String id) => '/member/id/$id';
  static String GET_USER_PROFILE_URL(String id) => '/user/id/$id';
  static String GET_TYPE1_TYPE2(String type) =>
      '/diettype/getall?page=1&type=$type';

  static const String BANNER_URI = '';
}
