import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_dimensions.dart';
import 'package:eye_hospital/res/app_images.dart';
import 'package:eye_hospital/utils/buttons.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import 'package:flutter/material.dart';

import '../../view_model/after_login_controller/support_controller/support_controller.dart';

class SupportHelpPage extends StatefulWidget {
  const SupportHelpPage({super.key});

  @override
  State<SupportHelpPage> createState() => _SupportHelpPageState();
}

class _SupportHelpPageState extends State<SupportHelpPage> {

  final TextEditingController queryController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();

  final SupportController controller = SupportController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              const SizedBox(height: 10),

              /// Title
              Text(
                "Support & Help",
                style: text18(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "We’re here to help you with appointments,\norders, and technical support",
                textAlign: TextAlign.center,
                style: text12(color: AppColors.textSecondary),
              ),

              const SizedBox(height: 16),

              /// Write Query
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Write your query",
                  style: text15(fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: queryController,
                maxLines: 4,
                maxLength: 1500,
                buildCounter: (
                    context, {
                      required int currentLength,
                      required bool isFocused,
                      required int? maxLength,
                    }) {
                  return Text(
                    "$currentLength / $maxLength",
                    style: text12(color: AppColors.textSecondary),
                  );
                },
                decoration: InputDecoration(
                  hintText: "Type your query...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radius15),
                    borderSide: BorderSide(color: AppColors.grey),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// Feedback
              feedbackCard(),

              const SizedBox(height: 16),

              /// Contact Support
              contactSupportCard(),

              const SizedBox(height: 30),

              /// Submit Button
              CustomButton(
                title: "Submit",
                onPressed: () {
                  controller.submitQuery(
                    context: context,
                    query: queryController.text.trim(),
                  );
                },
              ),

              const SizedBox(height: 16),

              /// Bottom Note
              Column(
                children: [
                  Image.asset(AppImages.medicalV, width: 60, height: 60),
                  const SizedBox(height: 6),
                  const Text(
                    "For medical emergencies, please visit the hospital\n"
                        "directly or call emergency services",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11, color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Contact Support
  static Widget contactSupportCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [

        Text(
          "Contact Support",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 8),

        Row(
          children: [
            Icon(Icons.call, size: 14),
            SizedBox(width: 6),
            Text("Call us: 5264265626"),
          ],
        ),

        SizedBox(height: 4),

        Row(
          children: [
            Icon(Icons.email, size: 14),
            SizedBox(width: 6),
            Text("Email us on: Neyera@gmail.com"),
          ],
        ),
      ],
    );
  }

  /// Feedback
  Widget feedbackCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Feedback & Suggestions",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 4),

        const Text(
          "Share your experience or suggestions\nto help us improve",
          style: TextStyle(fontSize: 11, color: Colors.black54),
        ),

        const SizedBox(height: 8),

        TextField(
          controller: feedbackController,
          maxLines: 4,
          maxLength: 1500,
          buildCounter: (
              context, {
                required int currentLength,
                required bool isFocused,
                required int? maxLength,
              }) {
            return Text(
              "$currentLength / $maxLength",
              style: text12(color: AppColors.textSecondary),
            );
          },
          decoration: InputDecoration(
            hintText: "Type your suggestions...",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radius15),
              borderSide: BorderSide(color: AppColors.grey),
            ),
          ),
        ),
      ],
    );
  }
}
