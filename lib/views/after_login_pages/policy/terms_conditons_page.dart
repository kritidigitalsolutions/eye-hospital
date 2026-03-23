import 'package:eye_hospital/data/api_response.dart';
import 'package:eye_hospital/view_model/after_login_controller/policy_controller/policy_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../res/app_colors.dart';
import '../../../utils/textstyle.dart';

class TermsConditonsPage extends StatefulWidget {
  const TermsConditonsPage({super.key});

  @override
  State<TermsConditonsPage> createState() => _TermsConditonsPageState();
}

class _TermsConditonsPageState extends State<TermsConditonsPage> {
  final PolicyControllers ctr = Get.put(PolicyControllers());

  @override
  void initState() {
    super.initState();
    ctr.fetchTermPolicy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        title: Text(
          "Term & Conditions",
          style: text16(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 1,
        surfaceTintColor: AppColors.white,
        shadowColor: AppColors.grey.shade100,
      ),

      body: Obx(() {
        switch (ctr.policy.value.status) {
          case Status.loading:
            return const Center(child: CircularProgressIndicator());

          case Status.error:
            return Center(
              child: Text(
                ctr.policy.value.message ?? "Something went wrong",
                style: text16(),
              ),
            );

          case Status.completed:
            final data = ctr.policy.value.data?.page;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  /// Content
                  Text(data?.content ?? "", style: text16()),
                ],
              ),
            );
        }
      }),
    );
  }
}
