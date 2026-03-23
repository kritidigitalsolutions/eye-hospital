import 'package:eye_hospital/data/api_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import '../../../view_model/after_login_controller/policy_controller/policy_controllers.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  final PolicyControllers ctr = Get.put(PolicyControllers());

  @override
  void initState() {
    super.initState();
    ctr.fetchPolicy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      appBar: AppBar(
        title: Text("About Us", style: text16(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 1,
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        shadowColor: AppColors.grey.shade100,
      ),

      body: Obx(() {
        switch (ctr.aboutUs.value.status) {
          /// ---------------- LOADING ----------------
          case Status.loading:
            return const Center(child: CircularProgressIndicator());

          /// ---------------- ERROR ----------------
          case Status.error:
            return Center(
              child: Text(
                ctr.aboutUs.value.message ?? "Something went wrong",
                style: text12(color: Colors.red),
              ),
            );

          /// ---------------- COMPLETED ----------------
          case Status.completed:
            final data = ctr.aboutUs.value.data?.aboutUs;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Hero Title
                  Text(
                    data?.heroTitle ?? "",
                    style: text18(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// Description
                  Text(
                    data?.description ?? "",
                    style: text12(color: AppColors.textSecondary),
                  ),

                  const SizedBox(height: 20),

                  /// Hero Subtitle Card
                  if ((data?.heroSubtitle ?? "").isNotEmpty)
                    _infoCard("Hero Subtitle", data!.heroSubtitle!),

                  /// Mission
                  if ((data?.mission ?? "").isNotEmpty)
                    _infoCard("Our Mission", data!.mission!),

                  /// Vision
                  if ((data?.vision ?? "").isNotEmpty)
                    _infoCard("Our Vision", data!.vision!),

                  /// Established
                  if ((data?.established ?? "").isNotEmpty)
                    _infoCard("Established", data!.established!),

                  const SizedBox(height: 10),

                  /// Contact Info
                  Text(
                    "Contact Information",
                    style: text16(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  _contactRow(Icons.phone, data?.phone),
                  _contactRow(Icons.email, data?.email),
                  _contactRow(Icons.location_on, data?.address),

                  const SizedBox(height: 25),

                  /// Team
                  if ((data?.teamMembers ?? []).isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Our Team",
                          style: text18(fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 15),

                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data!.teamMembers.length,
                          itemBuilder: (context, index) {
                            final member = data.teamMembers[index];

                            return Container(
                              margin: const EdgeInsets.only(bottom: 14),
                              padding: const EdgeInsets.all(12),

                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.05),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),

                              child: Row(
                                children: [
                                  /// Image
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      member.image ?? "",
                                      height: 70,
                                      width: 70,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(
                                        height: 70,
                                        width: 70,
                                        color: Colors.grey.shade200,
                                        child: const Icon(Icons.person),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  /// Info
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          member.name ?? "",
                                          style: text15(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(height: 3),

                                        Text(
                                          member.role ?? "",
                                          style: text12(
                                            color: AppColors.textPrimary,
                                          ),
                                        ),

                                        const SizedBox(height: 6),

                                        Text(
                                          member.bio ?? "",
                                          style: text12(
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                ],
              ),
            );
        }
      }),
    );
  }

  /// Info Card Widget
  Widget _infoCard(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: text15(fontWeight: FontWeight.bold)),

          const SizedBox(height: 5),

          Text(value, style: text12(color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  /// Contact Row Widget
  Widget _contactRow(IconData icon, String? text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(text ?? "Not Available")),
        ],
      ),
    );
  }
}
