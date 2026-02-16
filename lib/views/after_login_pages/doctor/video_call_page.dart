import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_dimensions.dart';
import 'package:eye_hospital/res/app_images.dart';
import 'package:flutter/material.dart';

class VideoCallPage extends StatelessWidget {
  const VideoCallPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(AppDimensions.marginMedium),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(
                  AppDimensions.radiusExtraLarge,
                ),
              ),
              child: doctorCard(
                image: AppImages.doctor,
                name: "Dr. Pankaj Tripathi",
                size: mediaQuery.height * 0.4,
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppDimensions.marginMedium,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(
                  AppDimensions.radiusExtraLarge,
                ),
              ),
              child: doctorCard(
                image: AppImages.femaleDoctor,
                name: "Mr. Ranjan Sharma",
                size: mediaQuery.height * 0.4,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                actionButton(Icons.chat_bubble_outline),
                actionButton(Icons.volume_up_outlined),
                actionButton(Icons.videocam_outlined),
                actionButton(Icons.close),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget doctorCard({
    required String image,
    required String name,
    required double size,
  }) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            image,
            height: size,

            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 180,
                color: AppColors.grey,
                child: Center(child: Icon(Icons.image, size: 40)),
              );
            },
          ),
        ),

        /// Name badge
        Positioned(
          bottom: 8,
          left: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.yellow.shade400,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              name,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  Widget actionButton(IconData icon) {
    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        color: Colors.yellow.shade400,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black),
        onPressed: () {},
      ),
    );
  }
}
