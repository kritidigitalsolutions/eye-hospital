class AppUrls {
  // static const String baseUrl = "http://192.168.29.185:7000/api";
  static const String baseUrl = "http://192.168.1.14:7000/api";

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
  static const String review = "$baseUrl/products/{productId}/review";
  static String trackOrder(String orderId) => "$baseUrl/orders/$orderId/track";

  //-----------------------------------------------------------
  // checkout
  //-----------------------------------------------
  static const String checkout = "$baseUrl/orders/place";
  static const String getcheckout = "$baseUrl/orders/my";

  //-----------------------------------------------------------
  // policy
  //-----------------------------------------------

  static const String policy = "$baseUrl/";

//-----------------------------------------------------------
// bookmark
//-----------------------------------------------

  static const String addbookmark = "$baseUrl/bookmarks/add";
  static const String getBookmark = "$baseUrl/bookmarks/";
  static const String removeBookmark = "$baseUrl/bookmarks";

  //-----------------------------------------------------------
  // bookmark
  //-----------------------------------------------

  static const String support = "$baseUrl/support";

//-----------------------------------------------------------
// about us
//-----------------------------------------------

  static const String aboutUs = "$baseUrl/aboutus";
  static const String privacypolicy = "$baseUrl/legal/privacy-policy";
  static const String termsandcondition = "$baseUrl/legal/terms-conditions";

}
