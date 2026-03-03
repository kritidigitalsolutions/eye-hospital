class AppUrls {
  static const String baseUrl = "http://192.168.29.185:7000/api";

  //--------------------------------------------------
  //auth
  //----------------------------------------------------

  static const String onBoarding = "$baseUrl/wallpapers";
  static const String sentOtp = "$baseUrl/auth/send-otp";
  static const String otpVerify = "$baseUrl/auth/verify-otp";
  static const String register = "$baseUrl/user/profile-info";

  //-----------------------------------------------------------
  // profile edit
  //-----------------------------------------------

  static const String editProfile = '$baseUrl/user/profile-update';

  //-----------------------------------------------------------
  // Doctor
  //-----------------------------------------------

  static const String searchDoctor = "$baseUrl/doctors";
  static const String appointmentBooked = "$baseUrl/appointments/book";
  static const String myAppointment = "$baseUrl/appointments/my";
  static const String appointments = "$baseUrl/appointments";

  //-----------------------------------------------------------
  // product
  //-----------------------------------------------

  static const String product = "$baseUrl/products";
  static const String addCart = "$baseUrl/cart/add";
  static const String updateCart = "$baseUrl/cart/update";
  static const String getCart = "$baseUrl/cart/";

  //-----------------------------------------------------------
  // checkout
  //-----------------------------------------------
  static const String checkout = "$baseUrl/orders/place";

  //-----------------------------------------------------------
  // policy
  //-----------------------------------------------

  static const String policy = "$baseUrl/";
}
