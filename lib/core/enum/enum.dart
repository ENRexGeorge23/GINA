enum DoctorRating {
  newDoctor, // 0
  activeDoctor, // 1
  contributingDoctor, // 2
  topDoctor, // 3
}

enum ModeOfAppointmentId {
  onlineConsultation, // 0
  faceToFaceConsultation, // 1
}

enum AppointmentStatus {
  pending, // 0
  confirmed, // 1
  completed, // 2
  cancelled, // 3
  declined, // 4
}

enum DoctorVerificationStatus {
  pending,
  approved,
  declined,
}
