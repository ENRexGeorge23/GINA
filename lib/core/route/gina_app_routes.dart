import 'package:first_app/features/admin_features/adminDashboard/2_views/screens/admin_dashboard_screen.dart';
import 'package:first_app/features/admin_features/adminDoctorList/2_views/screens/admin_doctor_list.screen.dart';
import 'package:first_app/features/admin_features/adminDoctorVerification/2_views/screens/admin_doctor_verification_screen.dart';
import 'package:first_app/features/admin_features/adminNavigationDrawer/2_views/screens/admin_navigation_drawer_screen.dart';
import 'package:first_app/features/admin_features/adminPatientList/2_views/screens/admin_patient_list_screen.dart';
import 'package:first_app/features/admin_features/login/2_views/screens/admin_login_screen.dart';
import 'package:first_app/features/auth/2_views/screens/forgot_password/2_views/forgot_password_screen.dart';
import 'package:first_app/features/auth/2_views/screens/login/login_screen.dart';
import 'package:first_app/features/auth/2_views/widgets/signup_widgets/doctor/doctor_office_address/doctor_add_office_address.dart';
import 'package:first_app/features/doctor_features/createDoctorSchedule/2_views/screens/doctor_create_schedule_screen.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/screens/doctor_appointment_request_screen.dart';
import 'package:first_app/features/doctor_features/doctorBottomNavigation/screens/doctor_bottom_navigation_screen.dart';
import 'package:first_app/features/doctor_features/doctorCalendarPage/screens/doctor_calendar_screen.dart';
import 'package:first_app/features/doctor_features/doctorConsultation/2_views/screens/doctor_consultation_screen.dart';
import 'package:first_app/features/doctor_features/doctorConsultationFee/2_views/doctor_consultation_fee_screen.dart';
import 'package:first_app/features/doctor_features/doctorEConsult/2_views/screens/doctor_e_consult_screen.dart';
import 'package:first_app/features/doctor_features/doctorEmergencyAnnouncements/2_views/screens/doctor_emergency_announcements_screen.dart';
import 'package:first_app/features/doctor_features/doctorForumBadge/2_views/doctor_forum_badge_screen.dart';
import 'package:first_app/features/doctor_features/doctorForums/2_views/screens/doctor_forums_screen.dart';
import 'package:first_app/features/doctor_features/doctorForums/2_views/screens/view_states/create_post_screen_state.dart';
import 'package:first_app/features/doctor_features/doctorMyForums/2_views/screens/doctor_my_forums_screen.dart';
import 'package:first_app/features/doctor_features/doctorProfile/2_views/screens/doctor_profile_screen.dart';
import 'package:first_app/features/doctor_features/doctorScheduleManagement/2_views/screens/doctor_schedule_screen.dart';
import 'package:first_app/features/doctor_features/doctorUpcomingAppointments/2_views/screens/doctor_upcoming_appointments_screen.dart';
import 'package:first_app/features/doctor_features/doctorViewPatientDetails/2_views/screens/doctor_view_patient_details_screen.dart';
import 'package:first_app/features/doctor_features/doctorViewPatients/2_views/screens/doctor_view_patients_screen.dart';
import 'package:first_app/features/patient_features/appointment/2_views/screens/appointment_screen.dart';
import 'package:first_app/features/patient_features/appointment/2_views/screens/view_states/upload_prescription_state.dart';
import 'package:first_app/features/patient_features/appointmentDetails/2_views/screens/appointment_details_screen.dart';
import 'package:first_app/features/patient_features/bookAppointment/2_views/pages/book_appointment_screen.dart';
import 'package:first_app/features/patient_features/bottomNavigation/screen/bottom_navigation_screen.dart';
import 'package:first_app/features/patient_features/consultation/2_views/screens/consultation_screen.dart';
import 'package:first_app/features/patient_features/consultationFeeDetails/2_views/screens/consultation_fee_details_screen.dart';
import 'package:first_app/features/patient_features/cycleHistory/2_views/screens/cycle_history_screen.dart';
import 'package:first_app/features/patient_features/doctorAvailability/2_views/screens/doctor_availability_screen.dart';
import 'package:first_app/features/patient_features/doctorDetails/2_views/screens/doctor_details_screen.dart';
import 'package:first_app/features/patient_features/doctorOfficeAddress/2_views/screens/doctor_office_address_screen.dart';
import 'package:first_app/features/patient_features/emergencyAnnouncements/2_views/screens/emergency_announcements_screen.dart';
import 'package:first_app/features/patient_features/find/2_views/screens/find_screen.dart';
import 'package:first_app/features/patient_features/forums/2_views/screens/forum_screen.dart';
import 'package:first_app/features/patient_features/forums/2_views/screens/view_states/create_post_screen_state.dart';
import 'package:first_app/features/patient_features/myForums/2_views/screens/my_forums_screen.dart';
import 'package:first_app/features/patient_features/periodTracker/2_views/screens/period_tracker_screen.dart';
import 'package:first_app/features/patient_features/profile/2_views/screens/profile_screen.dart';
import 'package:first_app/features/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> ginaAppRoutes() {
  return {
    // Auth Routes
    '/splash': (context) => const SplashScreen(),
    '/login': (context) => const LoginScreenProvider(),
    '/forgotPassword': (context) => ForgotPasswordScreen(),

    // Admin Routes

    '/adminLogin': (context) => const AdminLoginScreenProvider(),
    '/adminNavigationDrawer': (context) =>
        const AdminNavigationDrawerProvider(),
    '/adminDashboard': (context) => const AdminDashboardScreenProvider(),
    '/adminDoctorVerification': (context) =>
        const AdminVerifyDoctorScreenProvider(),
    '/adminDoctorList': (context) => const AdminDoctorListScreenProvider(),
    '/adminPatientList': (context) => const AdminPatientListScreenProvider(),

    // Patient Routes
    '/doctorAddressMap': (context) => const DoctorAddOfficeAddressProvider(),
    '/profile': (context) => const ProfileScreenProvider(),
    '/bottomNavigation': (context) => const BottomNavigationProvider(),
    '/find': (context) => const FindScreenProvider(),
    '/doctorDetails': (context) => const DoctorDetailsScreenProvider(),
    '/appointmentDetails': (context) =>
        const AppointmentDetailsScreenProvider(),
    '/consultation': (context) => const ConsultationScreenProvider(),
    '/consultationFeeDetails': (context) =>
        const ConsultationFeeDetailsScreenProvider(),
    '/doctorAvailability': (context) =>
        const DoctorAvailabilityScreenProvider(),
    '/doctorOfficeAddress': (context) =>
        const DoctorOfficeAddressScreenProvider(),
    '/bookAppointment': (context) => const BookAppointmentScreenProvider(),
    '/cycleHistory': (context) => const CycleHistoryProvider(),
    '/appointment': (context) => const AppointmentScreenProvider(),
    '/periodTracker': (context) => const PeriodTrackerScreenProvider(),
    '/forums': (context) => const ForumScreenProvider(),
    '/forumsCreatePost': (context) => CreatePostScreenState(),
    '/myForumsPost': (context) => const MyForumsScreenProvider(),
    '/uploadPrescription': (context) => const UploadPrescripionStateScreen(),
    '/emergencyAnnouncements': (context) =>
        const EmergencyAnnouncementScreenProvider(),

    // Doctor Routes
    '/doctorBottomNavigation': (context) =>
        const DoctorBottomNavigationProvider(),
    '/doctorCalendar': (context) => const DoctorCalendarScreenProvider(),
    '/doctorForumsCreatePost': (context) => CreateDoctorPostScreenState(),
    '/doctorMyForumPosts': (context) => const DoctorMyForumsScreenProvider(),
    '/doctorSchedule': (context) => const DoctorScheduleScreenProvider(),
    '/doctorRequest': (context) => const DoctorAppointmentRequestProvider(),
    '/createDoctorSchedule': (context) =>
        const DoctorCreateScheduleScreenProvider(),
    '/doctorsPatientsList': (context) =>
        const DoctorViewPatientsScreenProvider(),
    '/doctorPatientDetails': (context) =>
        const DoctorViewPatientDetailsScreenProvider(),
    '/doctorEConsultList': (context) => const DoctorEConsultScreenProvider(),
    '/doctorOnlineConsultChat': (context) =>
        const DoctorConsultationScreenProvider(),

    '/doctorProfileDetails': (context) => const DoctorProfileScreenProvider(),
    '/doctorConsultationFee': (context) =>
        const DoctorConsultationFeeScreenProvider(),
    '/doctorUpcomingAppointments': (context) =>
        const DoctorUpcomingAppointmentScreenProvider(),
    '/doctorForumBadge': (context) => const DoctorForumBadgeScreenProvider(),
    '/doctorForumsPost': (context) => const DoctorForumsScreenProvider(),
    '/doctorEmergencyAnnouncements': (context) =>
        const DoctorEmergencyAnnouncementsScreenProvider(),
  };
}
