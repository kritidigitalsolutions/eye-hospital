class PolicyResModel {
  PolicyResModel({required this.success, required this.page});

  final bool? success;
  final Page? page;

  factory PolicyResModel.fromJson(Map<String, dynamic> json) {
    return PolicyResModel(
      success: json["success"],
      page: json["page"] == null ? null : Page.fromJson(json["page"]),
    );
  }
}

class Page {
  Page({
    required this.id,
    required this.type,

    required this.content,

    required this.title,
  });

  final String? id;
  final String? type;

  final String? content;

  final String? title;

  factory Page.fromJson(Map<String, dynamic> json) {
    return Page(
      id: json["_id"],
      type: json["type"],

      content: json["content"],

      title: json["title"],
    );
  }
}
