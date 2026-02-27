class UserDetailsReqModel {
  final String name;
  final String phone;
  final String dob;
  final String gender;
  final String? image;

  UserDetailsReqModel({
    required this.dob,
    required this.phone,
    required this.gender,
    required this.name,
    this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "phone": phone,
      "dob": dob,
      "gender": gender,
      "profileImage": image,
    };
  }
}
