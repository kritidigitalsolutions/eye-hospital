class AboutUsResModel {
  AboutUsResModel({required this.success, required this.aboutUs});

  final bool? success;
  final AboutUs? aboutUs;

  factory AboutUsResModel.fromJson(Map<String, dynamic> json) {
    return AboutUsResModel(
      success: json["success"],
      aboutUs: json["aboutUs"] == null
          ? null
          : AboutUs.fromJson(json["aboutUs"]),
    );
  }
}

class AboutUs {
  AboutUs({
    required this.id,
    required this.heroTitle,
    required this.heroSubtitle,
    required this.mission,
    required this.vision,
    required this.description,
    required this.established,
    required this.email,
    required this.phone,
    required this.address,
    required this.isPublished,
    required this.teamMembers,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? heroTitle;
  final String? heroSubtitle;
  final String? mission;
  final String? vision;
  final String? description;
  final String? established;
  final String? email;
  final String? phone;
  final String? address;
  final bool? isPublished;
  final List<TeamMember> teamMembers;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory AboutUs.fromJson(Map<String, dynamic> json) {
    return AboutUs(
      id: json["_id"],
      heroTitle: json["heroTitle"],
      heroSubtitle: json["heroSubtitle"],
      mission: json["mission"],
      vision: json["vision"],
      description: json["description"],
      established: json["established"],
      email: json["email"],
      phone: json["phone"],
      address: json["address"],
      isPublished: json["isPublished"],
      teamMembers: json["teamMembers"] == null
          ? []
          : List<TeamMember>.from(
              json["teamMembers"]!.map((x) => TeamMember.fromJson(x)),
            ),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }
}

class TeamMember {
  TeamMember({
    required this.name,
    required this.role,
    required this.bio,
    required this.image,
    required this.id,
  });

  final String? name;
  final String? role;
  final String? bio;
  final String? image;
  final String? id;

  factory TeamMember.fromJson(Map<String, dynamic> json) {
    return TeamMember(
      name: json["name"],
      role: json["role"],
      bio: json["bio"],
      image: json["image"],
      id: json["_id"],
    );
  }
}
