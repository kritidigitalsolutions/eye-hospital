import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/views/after_login_pages/liked_product_page.dart';
import 'package:eye_hospital/views/after_login_pages/doctor/appointment_details.dart';
import 'package:eye_hospital/views/after_login_pages/doctor/appointment_page.dart';
import 'package:eye_hospital/views/after_login_pages/doctor/doctor_details_page.dart';
import 'package:eye_hospital/views/after_login_pages/doctor/find_doctor_page.dart';
import 'package:eye_hospital/views/after_login_pages/doctor/my_appointment_page.dart';
import 'package:eye_hospital/views/after_login_pages/home_screen.dart';
import 'package:eye_hospital/views/after_login_pages/my_cart_page.dart';
import 'package:eye_hospital/views/after_login_pages/profile/edit_profile_Page.dart';
import 'package:eye_hospital/views/after_login_pages/profile/my_profile_page.dart';
import 'package:eye_hospital/views/after_login_pages/shop/checkout_page.dart';
import 'package:eye_hospital/views/after_login_pages/shop/order_details.dart';
import 'package:eye_hospital/views/after_login_pages/shop/product_details_page.dart';
import 'package:eye_hospital/views/after_login_pages/shop/product_page.dart';
import 'package:eye_hospital/views/after_login_pages/shop/tracke_order_page.dart';
import 'package:eye_hospital/views/after_login_pages/support_help_page.dart';
import 'package:eye_hospital/views/before_login_pages/login_screen.dart';
import 'package:eye_hospital/views/before_login_pages/onboarding_screen.dart';
import 'package:eye_hospital/views/before_login_pages/otp_screen.dart';
import 'package:eye_hospital/views/before_login_pages/register_screen.dart';
import 'package:eye_hospital/views/before_login_pages/splash_screen.dart';
import 'package:eye_hospital/views/before_login_pages/user_image_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages {
  static final pages = [
    // auth
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.onBoarding, page: () => OnboardingScreen()),
    GetPage(name: AppRoutes.loginPage, page: () => LoginScreen()),
    GetPage(name: AppRoutes.otpPage, page: () => OtpScreen()),
    GetPage(name: AppRoutes.registerPage, page: () => RegisterScreen()),
    GetPage(name: AppRoutes.userImage, page: () => PickProfileImagePage()),

    // home
    GetPage(name: AppRoutes.homeScreen, page: () => HomeScreen()),

    // doctor
    GetPage(name: AppRoutes.findDoctorList, page: () => FindDoctorsPage()),
    GetPage(name: AppRoutes.doctorDetails, page: () => DoctorProfilePage()),
    GetPage(name: AppRoutes.appointmentPage, page: () => AppointmentPage()),
    GetPage(name: AppRoutes.myAppointment, page: () => MyAppointmentsPage()),
    GetPage(
      name: AppRoutes.appointmentDetails,
      page: () => AppointmentDetailPage(),
    ),
    // GetPage(name: AppRoutes.videoCall, page: () => VideoCallPage()),

    // shop
    GetPage(name: AppRoutes.productPage, page: () => ProductPage()),
    GetPage(name: AppRoutes.productDetails, page: () => ProductDetailsPage()),
    GetPage(name: AppRoutes.checkoutPage, page: () => CheckoutPage()),
    GetPage(name: AppRoutes.traceOrder, page: () => TrackingDetailsPage()),
    GetPage(name: AppRoutes.orderDetails, page: () => OrderDetailsPage()),
    GetPage(name: AppRoutes.supportPage, page: () => SupportHelpPage()),
    GetPage(name: AppRoutes.likeProduct, page: () => LikedProductPage()),
    GetPage(name: AppRoutes.myCart, page: () => MyCartPage()),
    GetPage(name: AppRoutes.myProfile, page: () => MyProfilePage()),
    GetPage(name: AppRoutes.editProfile, page: () => EditProfilePage()),
  ];
}
