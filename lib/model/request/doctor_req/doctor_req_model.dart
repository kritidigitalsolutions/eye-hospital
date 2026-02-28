class AppointmentRequestModel {
  final String doctorId;
  final String appointmentType; // physical / online
  final String consultationType; // first_consultation / follow_up
  final String patientType; // general / private
  final String appointmentDate; // yyyy-MM-dd
  final String timeSlot; // 08:30 PM
  final String patientNotes;

  AppointmentRequestModel({
    required this.doctorId,
    required this.appointmentType,
    required this.consultationType,
    required this.patientType,
    required this.appointmentDate,
    required this.timeSlot,
    required this.patientNotes,
  });

  /// Convert model to JSON for API
  Map<String, dynamic> toJson() {
    return {
      "doctorId": doctorId,
      "appointmentType": appointmentType,
      "consultationType": consultationType,
      "patientType": patientType,
      "appointmentDate": appointmentDate,
      "timeSlot": timeSlot,
      "patientNotes": patientNotes,
    };
  }
}
