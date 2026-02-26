// -------------------------------------------------
// user details
//------------------------------------------------------

class OnBoardingResponseModel {
  final bool? success;
  final List<OnBoardingData> data;

  OnBoardingResponseModel({required this.data, required this.success});

  factory OnBoardingResponseModel.fromJson(Map<String, dynamic> json) {
    return OnBoardingResponseModel(
      success: json["success"],
      data: (json["data"] as List)
          .map((item) => OnBoardingData.fromJson(item))
          .toList(),
    );
  }
}

class OnBoardingData {
  final String image;
  final String title;

  OnBoardingData({required this.image, required this.title});

  factory OnBoardingData.fromJson(Map<String, dynamic> json) {
    return OnBoardingData(
      image: json["image"] ?? "",
      title: json["title"] ?? "",
    );
  }
}

// -------------------------------------------------
// user details
//------------------------------------------------------

class UserDetailsResModel {
  UserDetailsResModel({
    required this.success,
    required this.message,
    required this.token,
    required this.user,
  });

  final bool? success;
  final String? message;
  final String? token;
  final User? user;

  factory UserDetailsResModel.fromJson(Map<String, dynamic> json) {
    return UserDetailsResModel(
      success: json["success"],
      message: json["message"],
      token: json["token"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "token": token,
    "user": user?.toJson(),
  };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.birth,
    required this.gender,
  });

  final String? id;
  final String? name;
  final String? phone;

  final String? birth;
  final String? gender;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["_id"],
      name: json["name"],
      phone: json["phone"],
      birth: json["birth"],
      gender: json["gender"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "phone": phone,
    "birth": birth,
    "gender": gender,
  };
}
