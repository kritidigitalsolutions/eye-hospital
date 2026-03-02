import 'package:eye_hospital/utils/textstyle.dart';
import 'package:flutter/material.dart';

class PolicyPage extends StatelessWidget {
  const PolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("About Us", style: text16(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          policyList(
            title: "About Us",
            onTap: () {
              // navigate to about page
            },
          ),
          const Divider(height: 1),

          policyList(
            title: "Privacy Policy",
            onTap: () {
              // navigate to privacy policy page
            },
          ),
          const Divider(height: 1),

          policyList(
            title: "Terms & Conditions",
            onTap: () {
              // navigate to terms page
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
