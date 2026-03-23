import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../routes/app_routes.dart';

class PolicyPage extends StatelessWidget {
  const PolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        title: Text("About Us", style: text16(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 1,
        surfaceTintColor: AppColors.white,
        shadowColor: AppColors.grey.shade100,
      ),
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          policyList(
            title: "About Us",
            onTap: () {
              Get.toNamed(AppRoutes.aboutUsPage);
            },
          ),
          const Divider(height: 1),

          policyList(
            title: "Privacy Policy",
            onTap: () {
              Get.toNamed(AppRoutes.privacyPolicy);
            },
          ),
          const Divider(height: 1),

          policyList(
            title: "Terms & Conditions",
            onTap: () {
              Get.toNamed(AppRoutes.termsAndCondition);
            },
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }

  Widget policyList({required VoidCallback onTap, required String title}) {
    return ListTile(
      onTap: onTap,
      title: Text(title, style: text15(fontWeight: FontWeight.w600)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 15),
    );
  }
}
