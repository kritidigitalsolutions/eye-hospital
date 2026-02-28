class MyAppointmentResModelDart {
  MyAppointmentResModelDart({
    required this.success,
    required this.total,
    required this.page,
    required this.totalPages,
    required this.appointments,
  });

  final bool? success;
  final int? total;
  final int? page;
  final int? totalPages;
  final List<Appointment> appointments;

  factory MyAppointmentResModelDart.fromJson(Map<String, dynamic> json) {
    return MyAppointmentResModelDart(
      success: json["success"],
      total: json["total"],
      page: json["page"],
      totalPages: json["totalPages"],
      appointments: json["appointments"] == null
          ? []
          : List<Appointment>.from(
              json["appointments"]!.map((x) => Appointment.fromJson(x)),
            ),
    );
  }
}

class Appointment {
  Appointment({
    required this.id,
    required this.user,
    required this.doctor,
    required this.appointmentType,
    required this.consultationType,
    required this.patientType,
    required this.appointmentDate,
    required this.timeSlot,
    required this.fee,
    required this.status,
    required this.reviewedBy,
    required this.reviewedAt,
    required this.adminNote,
    required this.cancelledBy,
    required this.cancelReason,
    required this.cancelledAt,
    required this.rescheduledTo,
    required this.rescheduledFrom,
    required this.videoCallLink,
    required this.prescription,
    required this.patientNotes,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? user;
  final AppointmentDoctor? doctor;
  final String? appointmentType;
  final String? consultationType;
  final String? patientType;
  final DateTime? appointmentDate;
  final String? timeSlot;
  final int? fee;
  final String? status;
  final String? reviewedBy;
  final DateTime? reviewedAt;
  final dynamic adminNote;
  final dynamic cancelledBy;
  final dynamic cancelReason;
  final dynamic cancelledAt;
  final dynamic rescheduledTo;
  final dynamic rescheduledFrom;
  final dynamic videoCallLink;
  final dynamic prescription;
  final String? patientNotes;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json["_id"],
      user: json["user"],
      doctor: json["doctor"] == null
          ? null
          : AppointmentDoctor.fromJson(json["doctor"]),
      appointmentType: json["appointmentType"],
      consultationType: json["consultationType"],
      patientType: json["patientType"],
      appointmentDate: DateTime.tryParse(json["appointmentDate"] ?? ""),
      timeSlot: json["timeSlot"],
      fee: json["fee"],
      status: json["status"],
      reviewedBy: json["reviewedBy"],
      reviewedAt: DateTime.tryParse(json["reviewedAt"] ?? ""),
      adminNote: json["adminNote"],
      cancelledBy: json["cancelledBy"],
      cancelReason: json["cancelReason"],
      cancelledAt: json["cancelledAt"],
      rescheduledTo: json["rescheduledTo"],
      rescheduledFrom: json["rescheduledFrom"],
      videoCallLink: json["videoCallLink"],
      prescription: json["prescription"],
      patientNotes: json["patientNotes"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }
}

class AppointmentDoctor {
  AppointmentDoctor({
    required this.id,
    required this.name,
    required this.specialization,
    required this.profileImage,
    required this.rating,
  });

  final String? id;
  final String? name;
  final String? specialization;
  final dynamic profileImage;
  final int? rating;

  factory AppointmentDoctor.fromJson(Map<String, dynamic> json) {
    return AppointmentDoctor(
      id: json["_id"],
      name: json["name"],
      specialization: json["specialization"],
      profileImage: json["profileImage"],
      rating: json["rating"],
    );
  }
}
