class AboutResModel {
  bool? success;
  AboutUs? aboutUs;

  AboutResModel({this.success, this.aboutUs});

  AboutResModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    aboutUs =
    json['aboutUs'] != null ? AboutUs.fromJson(json['aboutUs']) : null;
  }
}

class AboutUs {
  String? id;
  String? heroTitle;
  String? heroSubtitle;
  String? mission;
  String? vision;
  String? description;
  String? established;
  String? email;
  String? phone;
  String? address;

  AboutUs({
    this.id,
    this.heroTitle,
    this.heroSubtitle,
    this.mission,
    this.vision,
    this.description,
    this.established,
    this.email,
    this.phone,
    this.address,
  });

  AboutUs.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    heroTitle = json['heroTitle'];
    heroSubtitle = json['heroSubtitle'];
    mission = json['mission'];
    vision = json['vision'];
    description = json['description'];
    established = json['established'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
  }
}
