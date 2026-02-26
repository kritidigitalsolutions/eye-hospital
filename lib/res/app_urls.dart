class AppUrls {
  static const String baseUrl = "http://192.168.1.31:7000/api";

  //--------------------------------------------------
  //auth
  //----------------------------------------------------

  static const String onBoarding = baseUrl;
  static const String sentOtp = "$baseUrl/auth/send-otp";
  static const String otpVerify = "$baseUrl/auth/verify-otp";
  static const String register = "$baseUrl/user/profile-info";
}
