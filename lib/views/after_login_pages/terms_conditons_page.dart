import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/network/network_api_service.dart';
import '../../res/app_urls.dart';
import '../../utils/hive_service/hive_service.dart';
import '../../res/app_colors.dart';
import '../../utils/textstyle.dart';

class TermsConditionsPage extends StatefulWidget {
  const TermsConditionsPage({super.key});

  @override
  State<TermsConditionsPage> createState() => _TermsConditionsPageState();
}

class _TermsConditionsPageState extends State<TermsConditionsPage> {
  bool isLoading = true;
  String content = '';
  String errorMessage = '';
  String title = 'Terms & Conditions';

  final NetworkApiService _api = NetworkApiService();

  @override
  void initState() {
    super.initState();
    fetchTermsConditions();
  }

  Future<void> fetchTermsConditions() async {
    try {
      final token = HiveService.getToken();
      print("Token: $token");
      _api.setToken(token ?? '');

      final res = await _api.getApi(AppUrls.termsandcondition);
      print("API Response Terms & Conditions: $res");

      if (res != null && res['success'] == true && res['page'] != null) {
        setState(() {
          title = res['page']['title'] ?? 'Terms & Conditions';
          content = res['page']['content'] ?? '';
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = res['message'] ?? 'No data found';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Something went wrong: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("terms And Conditions", style: text16(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
            ? Center(child: Text(errorMessage))
            : SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Text(
            content,
            style: text12(color: AppColors.textSecondary),
          ),
        ),
      ),
    );
  }
}
