import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_dimensions.dart';
import 'package:eye_hospital/res/app_images.dart';
import 'package:eye_hospital/routes/app_routes.dart';
import 'package:eye_hospital/utils/buttons.dart';
import 'package:eye_hospital/utils/custom_dialogbox.dart';
import 'package:eye_hospital/utils/custom_textfields.dart';
import 'package:eye_hospital/utils/hive_service/hive_service.dart';
import 'package:eye_hospital/utils/home_components.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:eye_hospital/view_model/after_login_controller/bookmark_controller/bookmark_controller.dart';
import 'package:eye_hospital/view_model/after_login_controller/cart_controller/cart_controller.dart';
import 'package:eye_hospital/view_model/after_login_controller/home_controller.dart';
import 'package:eye_hospital/view_model/after_login_controller/profile_controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/response/product_res/product_res_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(HomeController());
  final profileCtr = Get.put(EditProfileController());
  final cartProduct = Get.put(CartController());
  final bookMarkCtr = Get.put(BookmarkController());

  @override
  Widget build(BuildContext context) {
    print(HiveService.getToken());
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.myProfile);
            },
            child: CircleAvatar(backgroundImage: AssetImage(AppImages.doctor)),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello", style: text16(fontWeight: FontWeight.w600)),
            Obx(
              () => Text(
                profileCtr.name.value,
                style: text16(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        actions: [
          customIconButton(icon: Icons.notifications_outlined),
          menuIconButton(context),
          SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Search Bar
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.findDoctorList);
              },
              child: AbsorbPointer(
                child: CustomTextFieldWithBorder(
                  controller: controller.searchDoctorCtr,
                  hintText: "Search Doctor",
                  borderRadius: AppDimensions.radiusExtraLarge,
                  prefixIcon: Icons.search,
                ),
              ),
            ),

            const SizedBox(height: 15),

            DoctorCard(),

            const SizedBox(height: 15),

            ShopCard(),
            const SizedBox(height: 15),

            /// Services
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: PhysicalAppointmentCard()),
                SizedBox(width: 25),
                Expanded(child: VideoConsultationCard()),
              ],
            ),

            const SizedBox(height: 24),

            /// Our Top Doctors
            sectionTitle("Our Top Doctors"),

            const SizedBox(height: 15),

            SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return doctorCard();
                },
              ),
            ),
            const SizedBox(height: 20),

            customOutlineButton(
              text: "Explore More",
              onPressed: () {
                Get.toNamed(AppRoutes.findDoctorList);
              },
            ),

            const SizedBox(height: 20),

            /// Most Used Spectacles
            sectionTitle("Most Used Spectacles"),

            const SizedBox(height: 15),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 12,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(6, (index) {
                  return spectaclesCard();
                }),
              ),
            ),

            const SizedBox(height: 20),

            customOutlineButton(
              text: "Explore More",
              onPressed: () {
                Get.toNamed(AppRoutes.productPage);
              },
            ),

            const SizedBox(height: 24),

            Image.asset(AppImages.logo),
            const SizedBox(height: 20),

            /// Our Vision
            Text("Our Vision", style: text18(color: AppColors.greenGr2)),

            const SizedBox(height: 15),

            Text(
              "is to simplify eye care through technology, connecting patients with trusted specialists and services anytime, anywhere",
              style: text14(),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  // Widget spectaclesCard() {
  //   return Column(
  //     children: [
  //       GestureDetector(
  //         onTap: () {
  //           Get.toNamed(
  //             AppRoutes.productDetails,
  //             arguments: {
  //               "title": "Classic Spectacles",
  //               "price": "Rs. 250",
  //               "image": AppImages.on3,
  //             },
  //           );
  //         },
  //         child: CircleAvatar(
  //           radius: 35,
  //           backgroundColor: AppColors.buttonText,
  //           child: CircleAvatar(
  //             backgroundColor: AppColors.white,
  //             radius: 34,
  //             child: Image.asset(AppImages.on3, fit: BoxFit.contain),
  //           ),
  //         ),
  //       ),
  //       SizedBox(height: 6),
  //       Text("Frame", style: text12(fontWeight: FontWeight.w600)),
  //     ],
  //   );
  // }
  Widget spectaclesCard() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            final dummyProduct = Product(
              id: "dummy_id",
              name: "Classic Spectacles",
              price: 250,
              discountedPrice: 250,
              images: [AppImages.on3],
              description: "Comfortable and stylish frames.",
              category: "Spectacles",
              availableColors: ["Black", "Blue"],
              highlights: ["Lightweight", "Durable"],
              careInstructions: ["Clean with microfiber cloth"],
              frameDetails: FrameDetails(
                frameType: "Full Rim",
                frameSize: "Medium",
                frameShape: "Rectangular",
                gender: "Unisex",
                frameMaterial: "Plastic",
              ),
              stock: 10,
              isActive: true,
              averageRating: 4,
              totalReviews: 5,
              tags: [],
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              v: 0,
            );

            Get.toNamed(
              AppRoutes.productDetails,
              arguments: dummyProduct, // Pass the Product object
            );
          },
          child: CircleAvatar(
            radius: 35,
            backgroundColor: AppColors.buttonText,
            child: CircleAvatar(
              backgroundColor: AppColors.white,
              radius: 34,
              child: Image.asset(AppImages.on3, fit: BoxFit.contain),
            ),
          ),
        ),
        SizedBox(height: 6),
        Text("Frame", style: text12(fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget sectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text(title, style: text18())],
    );
  }
}

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.findDoctorList);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [AppColors.greenGr1, AppColors.greenGr2],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Row(
          children: [
            // Left Content
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Find Eye",
                      style: text20(
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ).copyWith(height: 1.1),
                    ),
                    Text(
                      "Doctors",
                      style: text20(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ).copyWith(height: 1.1),
                    ),

                    Text(
                      "View specialists and check\nreal-time availability",
                      style: text11(
                        fontWeight: FontWeight.w500,
                        color: AppColors.white70,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomContainerButton(
                      width: 80,
                      backgroundColor: AppColors.white,
                      textColor: AppColors.textPrimary,
                      height: 25,
                      title: "Explore",
                      onPressed: () {
                        Get.toNamed(AppRoutes.findDoctorList);
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Right Image
            Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  AppImages.doctor, // your image path
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(child: Icon(Icons.image, size: 40));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShopCard extends StatelessWidget {
  const ShopCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.productPage);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [AppColors.yellowGr1, AppColors.yellowGr2],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Row(
          children: [
            // Left Content
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Shop",
                      style: text20(
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ).copyWith(height: 1.1),
                    ),
                    Text(
                      "Spectacles",
                      style: text20(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ).copyWith(height: 1.1),
                    ),
                    Text(
                      "and Lenses",
                      style: text20(
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ).copyWith(height: 1.1),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "Browse frames, lenses & \neyewear from trusted brands",
                      style: text11(
                        fontWeight: FontWeight.w500,
                        color: AppColors.white70,
                      ).copyWith(height: 1.2),
                    ),
                    const SizedBox(height: 8),

                    CustomContainerButton(
                      width: 80,
                      backgroundColor: AppColors.white,
                      textColor: AppColors.textPrimary,
                      height: 25,
                      title: "Explore",
                      onPressed: () {
                        Get.toNamed(AppRoutes.productPage);
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Right Image
            Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  AppImages.shop, // your image path
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(child: Icon(Icons.image, size: 40));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget menuIconButton(BuildContext context) {
  return PopupMenuButton<String>(
    onSelected: (value) {
      if (value == "appointment") {
        Get.toNamed(AppRoutes.myAppointment);
      } else if (value == "carts") {
        Get.toNamed(AppRoutes.myCart);
      } else if (value == "liked") {
        Get.toNamed(AppRoutes.likeProduct);
      } else if (value == "track") {
        Get.toNamed(AppRoutes.traceOrder);
      } else if (value == "profile") {
        Get.toNamed(AppRoutes.myProfile);
      } else if (value == "support") {
        Get.toNamed(AppRoutes.supportPage);
      } else if (value == "logout") {
        showConfirmDialog(context);
      } else if (value == "aboutUs") {
        Get.toNamed(AppRoutes.policyPage);
      }
    },
    color: AppColors.white,
    itemBuilder: (context) => [
      PopupMenuItem(
        value: "profile",
        child: Row(
          children: [
            const Icon(Icons.person_outline, size: 18),
            const SizedBox(width: 8),
            Text("My Profile", style: text14()),
          ],
        ),
      ),
      PopupMenuItem(
        value: "appointment",
        child: Row(
          children: [
            const Icon(Icons.calendar_today_outlined, size: 18),
            const SizedBox(width: 8),
            Text("My Appointment", style: text14()),
          ],
        ),
      ),
      PopupMenuItem(
        value: "carts",
        child: Row(
          children: [
            const Icon(Icons.shopping_cart_checkout_outlined, size: 18),
            const SizedBox(width: 8),
            Text("My Carts", style: text14()),
          ],
        ),
      ),
      PopupMenuItem(
        value: "liked",
        child: Row(
          children: [
            const Icon(Icons.favorite_outline, size: 18),
            const SizedBox(width: 8),
            Text("Liked Products", style: text14()),
          ],
        ),
      ),
      PopupMenuItem(
        value: "track",
        child: Row(
          children: [
            const Icon(Icons.local_shipping_outlined, size: 18),
            const SizedBox(width: 8),
            Text("Track my order", style: text14()),
          ],
        ),
      ),
      PopupMenuItem(
        value: "support",
        child: Row(
          children: [
            const Icon(Icons.support_agent, size: 18),
            const SizedBox(width: 8),
            Text("Support", style: text14()),
          ],
        ),
      ),
      PopupMenuItem(
        value: "aboutUs",
        child: Row(
          children: [
            const Icon(Icons.help_outline, size: 18),
            const SizedBox(width: 8),
            Text("About Us", style: text14()),
          ],
        ),
      ),
      PopupMenuItem(
        value: "logout",
        child: Row(
          children: [
            const Icon(Icons.logout, size: 18, color: Colors.red),
            const SizedBox(width: 8),
            Text("LogOut", style: text14(color: Colors.red)),
          ],
        ),
      ),
    ],
    child: const Icon(Icons.menu, size: 25),
  );
}

class PhysicalAppointmentCard extends StatelessWidget {
  const PhysicalAppointmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [AppColors.greenGr2, AppColors.greenGr1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          /// Circle Background
          Positioned(
            right: 0,
            bottom: -60,
            left: 0,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.greenGr1.withAlpha(150),
                    AppColors.greenGr1,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),

          /// Inner Circle
          Positioned(
            right: 0,
            bottom: -40,
            left: 0,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppColors.greenGr2, AppColors.greenGr1],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),

          /// Text
          Positioned(
            left: 15,
            top: 15,
            child: Text(
              "Physical\nAppointments",
              style: text18(
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
          ),

          /// Doctor Image
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Image.asset(
              AppImages.femaleDoctor, // replace with your image path
              height: 90,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}

class VideoConsultationCard extends StatelessWidget {
  const VideoConsultationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [AppColors.yellowGr2, AppColors.yellowGr1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          /// Circle Background
          Positioned(
            right: 0,
            bottom: -60,
            left: 0,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.yellowGr1.withAlpha(150),
                    AppColors.yellowGr1,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),

          /// Inner Circle
          Positioned(
            right: 0,
            bottom: -40,
            left: 0,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppColors.yellowGr2, AppColors.yellowGr1],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),

          /// Text
          Positioned(
            left: 15,
            top: 15,
            child: Text(
              "Video\nConsultation",
              style: text18(
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.black.withAlpha(150),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "Coming Soon",
                style: text10(
                  color: AppColors.white,

                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          /// Doctor Image
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Image.asset(
              AppImages.group, // replace with your image path
              height: 90,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
