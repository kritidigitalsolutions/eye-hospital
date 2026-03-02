import 'package:eye_hospital/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildShimmerList() {
  return Expanded(
    child: ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) {
        return _shimmerDoctorCard();
      },
    ),
  );
}

Widget _shimmerDoctorCard() {
  return Shimmer.fromColors(
    baseColor: AppColors.grey.shade300,
    highlightColor: AppColors.grey.shade100,
    child: Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white,
      ),
      child: Row(
        children: [
          /// Left side text shimmer
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 16, width: 120, color: AppColors.white),
                const SizedBox(height: 8),
                Container(height: 12, width: 80, color: AppColors.white),
                const SizedBox(height: 12),
                Container(height: 20, width: 90, color: AppColors.white),
              ],
            ),
          ),

          /// Right image shimmer
          const CircleAvatar(radius: 35, backgroundColor: AppColors.white),
        ],
      ),
    ),
  );
}

Widget shimmerProductCard() {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Image shimmer
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: AspectRatio(
                  aspectRatio: 1.5,
                  child: Container(color: Colors.white),
                ),
              ),

              /// Icons shimmer
              Positioned(
                top: 12,
                left: 12,
                right: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(height: 18, width: 18, color: Colors.white),
                    Container(height: 22, width: 22, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// Product name shimmer
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Container(height: 14, width: 120, color: Colors.white),
          ),

          const SizedBox(height: 6),

          /// Price shimmer
          Container(
            margin: const EdgeInsets.only(left: 12),
            height: 24,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    ),
  );
}
