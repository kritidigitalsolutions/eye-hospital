import 'package:flutter/material.dart';
import '../../../repo/support_repo.dart';

class SupportController {

  final SupportRepo _repo = SupportRepo();

  Future<void> submitQuery({
    required BuildContext context,
    required String query,
  }) async {

    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your query")),
      );
      return;
    }

    try {

      final res = await _repo.sendSupportQuery(query);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(res['message'])),
      );

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Something went wrong")),
      );

    }
  }
}
