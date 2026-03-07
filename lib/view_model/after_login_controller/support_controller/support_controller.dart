import 'package:flutter/material.dart';
import '../../../repo/support_repo.dart';

class SupportController {

  final SupportRepo _repo = SupportRepo();

  Future<bool> submitQuery({
    required BuildContext context,
    required String query,
    required String feedback,
  }) async {

    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your query")),
      );
      return false;
    }
    if (feedback.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your feedback")),
      );
      return false;
    }

    try {

      final res = await _repo.sendSupportQuery(query,feedback);

      if (res['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res['message'] ?? "Support ticket submitted")),
        );
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res['message'] ?? "Failed to submit ticket")),
        );
        return false;
      }

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Something went wrong")),
      );
      return false;
    }
  }
}
