class DoctorListResModel {
  DoctorListResModel({
    required this.success,
    required this.total,
    required this.page,
    required this.totalPages,
    required this.doctors,
  });

  final bool? success;
  final int? total;
  final int? page;
  final int? totalPages;
  final List<Doctor> doctors;

  factory DoctorListResModel.fromJson(Map<String, dynamic> json) {
    return DoctorListResModel(
      success: json["success"],
      total: json["total"],
      page: json["page"],
      totalPages: json["totalPages"],
      doctors: json["doctors"] == null
          ? []
          : List<Doctor>.from(json["doctors"]!.map((x) => Doctor.fromJson(x))),
    );
  }
}

class Doctor {
  Doctor({
    required this.id,
    required this.name,
    required this.specialization,
    required this.profileImage,
    required this.rating,
    required this.totalReviews,
    required this.about,
    required this.qualifications,
    required this.experienceYears,
    required this.consultationFees,
    required this.availableDays,
    required this.availableTimeSlots,
    required this.isAvailable,
  });

  final String? id;
  final String? name;
  final String? specialization;
  final dynamic profileImage;
  final int? rating;
  final int? totalReviews;
  final String? about;
  final List<String> qualifications;
  final int? experienceYears;
  final ConsultationFees? consultationFees;
  final List<String> availableDays;
  final List<String> availableTimeSlots;
  final bool? isAvailable;

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json["_id"],
      name: json["name"],
      specialization: json["specialization"],
      profileImage: json["profileImage"],
      rating: json["rating"],
      totalReviews: json["totalReviews"],
      about: json["about"],
      qualifications: json["qualifications"] == null
          ? []
          : List<String>.from(json["qualifications"]!.map((x) => x)),
      experienceYears: json["experienceYears"],
      consultationFees: json["consultationFees"] == null
          ? null
          : ConsultationFees.fromJson(json["consultationFees"]),
      availableDays: json["availableDays"] == null
          ? []
          : List<String>.from(json["availableDays"]!.map((x) => x)),
      availableTimeSlots: json["availableTimeSlots"] == null
          ? []
          : List<String>.from(json["availableTimeSlots"]!.map((x) => x)),
      isAvailable: json["isAvailable"],
    );
  }
}

class ConsultationFees {
  ConsultationFees({
    required this.firstConsultation,
    required this.followUpConsultation,
    required this.fastTrackConsultation,
  });

  final Consultation? firstConsultation;
  final Consultation? followUpConsultation;
  final FastTrackConsultation? fastTrackConsultation;

  factory ConsultationFees.fromJson(Map<String, dynamic> json) {
    return ConsultationFees(
      firstConsultation: json["firstConsultation"] == null
          ? null
          : Consultation.fromJson(json["firstConsultation"]),
      followUpConsultation: json["followUpConsultation"] == null
          ? null
          : Consultation.fromJson(json["followUpConsultation"]),
      fastTrackConsultation: json["fastTrackConsultation"] == null
          ? null
          : FastTrackConsultation.fromJson(json["fastTrackConsultation"]),
    );
  }
}

class FastTrackConsultation {
  FastTrackConsultation({required this.standard, required this.followUp});

  final int? standard;
  final int? followUp;

  factory FastTrackConsultation.fromJson(Map<String, dynamic> json) {
    return FastTrackConsultation(
      standard: json["standard"],
      followUp: json["followUp"],
    );
  }
}

class Consultation {
  Consultation({required this.private, required this.general});

  final int? private;
  final int? general;

  factory Consultation.fromJson(Map<String, dynamic> json) {
    return Consultation(private: json["private"], general: json["general"]);
  }
}
