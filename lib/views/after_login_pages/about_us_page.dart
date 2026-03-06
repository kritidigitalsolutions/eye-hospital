import 'package:flutter/material.dart';
import 'package:eye_hospital/res/app_colors.dart';
import 'package:eye_hospital/res/app_dimensions.dart';
import 'package:eye_hospital/utils/textstyle.dart';
import '../../data/network/network_api_service.dart';
import '../../res/app_urls.dart';
import '../../utils/hive_service/hive_service.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  bool isLoading = true;
  Map<String, dynamic>? aboutData;
  String errorMessage = '';

  final NetworkApiService _api = NetworkApiService();

  @override
  void initState() {
    super.initState();
    fetchAboutUs();
  }

  Future<void> fetchAboutUs() async {
    try {
      final token = HiveService.getToken();
      _api.setToken(token ?? '');

      final res = await _api.getApi(AppUrls.aboutUs);

      if (res != null && res['success'] == true && res['aboutUs'] != null) {
        setState(() {
          aboutData = res['aboutUs'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = res['message'] ?? 'No data found';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Something went wrong: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("About Us", style: text16(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
            ? Center(
          child: Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: text12(color: Colors.red),
          ),
        )
            : SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Hero Title
              Text(
                aboutData?['heroTitle'] ?? "About Us",
                style: text18(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              /// Description
              if ((aboutData?['description'] ?? "").isNotEmpty)
                Text(
                  aboutData!['description'],
                  style:
                  text12(color: AppColors.textSecondary),
                ),

              const SizedBox(height: 20),

              /// Mission
              if ((aboutData?['mission'] ?? "").isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Our Mission",
                      style: text15(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      aboutData!['mission'],
                      style:
                      text12(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),

              /// Vision
              if ((aboutData?['vision'] ?? "").isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Our Vision",
                      style: text15(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      aboutData!['vision'],
                      style:
                      text12(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),

              /// Contact Info
              Text(
                "Contact Information",
                style: text15(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  const Icon(Icons.phone, size: 16),
                  const SizedBox(width: 8),
                  Text(aboutData?['phone'] ?? "Not Available"),
                ],
              ),

              const SizedBox(height: 6),

              Row(
                children: [
                  const Icon(Icons.email, size: 16),
                  const SizedBox(width: 8),
                  Text(aboutData?['email'] ?? "Not Available"),
                ],
              ),

              const SizedBox(height: 6),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                        aboutData?['address'] ??
                            "Address not available"),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// Established
              if ((aboutData?['established'] ?? "").isNotEmpty)
                Text(
                  "Established: ${aboutData!['established']}",
                  style:
                  text12(color: AppColors.textSecondary),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
