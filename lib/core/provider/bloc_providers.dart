import 'package:first_app/core/reusable_widgets/doctor_reusable_widgets/floating_doctor_menu_bar/bloc/floating_doctor_menu_bar_bloc.dart';
import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/floating_menu_bar/2_views/bloc/floating_menu_bloc.dart';
import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/admin_features/adminDashboard/2_views/bloc/admin_dashboard_bloc.dart';
import 'package:first_app/features/admin_features/adminDoctorList/2_views/bloc/admin_doctor_list_bloc.dart';
import 'package:first_app/features/admin_features/adminDoctorVerification/2_views/bloc/admin_doctor_verification_bloc.dart';
import 'package:first_app/features/admin_features/adminNavigationDrawer/2_views/bloc/admin_navigation_drawer_bloc.dart';
import 'package:first_app/features/admin_features/adminPatientList/2_views/bloc/admin_patient_list_bloc.dart';
import 'package:first_app/features/admin_features/login/2_views/bloc/admin_login_bloc.dart';
import 'package:first_app/features/auth/2_views/bloc/auth_bloc.dart';
import 'package:first_app/features/auth/2_views/screens/forgot_password/2_views/bloc/forgot_password_bloc.dart';
import 'package:first_app/features/doctor_features/createDoctorSchedule/2_views/bloc/create_doctor_schedule_bloc.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/screens/bloc/doctor_appointment_request_screen_loaded_bloc.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/view_states/approvedState/bloc/approved_request_state_bloc.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/view_states/cancelledState/bloc/cancelled_request_state_bloc.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/view_states/declinedState/bloc/declined_request_state_bloc.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/view_states/pendingState/bloc/pending_request_state_bloc.dart';
import 'package:first_app/features/doctor_features/doctorBottomNavigation/bloc/doctor_bottom_navigation_bloc.dart';
import 'package:first_app/features/doctor_features/doctorCalendarPage/bloc/doctor_calendar_bloc.dart';
import 'package:first_app/features/doctor_features/doctorConsultation/2_views/bloc/doctor_consultation_bloc.dart';
import 'package:first_app/features/doctor_features/doctorEConsult/2_views/bloc/doctor_e_consult_bloc.dart';
import 'package:first_app/features/doctor_features/doctorEmergencyAnnouncements/2_views/bloc/doctor_emergency_announcements_bloc.dart';
import 'package:first_app/features/doctor_features/doctorForumBadge/2_views/bloc/doctor_forum_badge_bloc.dart';
import 'package:first_app/features/doctor_features/doctorForums/2_views/bloc/doctor_forums_bloc.dart';
import 'package:first_app/features/doctor_features/doctorMyForums/2_views/bloc/doctor_my_forums_bloc.dart';
import 'package:first_app/features/doctor_features/doctorProfile/2_views/bloc/doctor_profile_bloc.dart';
import 'package:first_app/features/doctor_features/doctorProfile/2_views/widgets/doctor_profile_update_dialog/bloc/doctor_profile_update_bloc.dart';
import 'package:first_app/features/doctor_features/doctorScheduleManagement/2_views/bloc/doctor_schedule_bloc.dart';
import 'package:first_app/features/doctor_features/doctorUpcomingAppointments/2_views/bloc/doctor_upcoming_appointments_bloc.dart';
import 'package:first_app/features/doctor_features/doctorViewPatientDetails/2_views/bloc/doctor_view_patient_details_bloc.dart';
import 'package:first_app/features/doctor_features/doctorViewPatients/2_views/bloc/doctor_view_patients_bloc.dart';
import 'package:first_app/features/doctor_features/homeDashboard/2_views/bloc/home_dashboard_bloc.dart';
import 'package:first_app/features/patient_features/appointment/2_views/bloc/appointment_bloc.dart';
import 'package:first_app/features/patient_features/appointmentDetails/2_views/bloc/appointment_details_bloc.dart';
import 'package:first_app/features/patient_features/bookAppointment/2_views/bloc/book_appointment_bloc.dart';
import 'package:first_app/features/patient_features/bottomNavigation/bloc/bottom_navigation_bloc.dart';
import 'package:first_app/features/patient_features/consultation/2_views/bloc/consultation_bloc.dart';
import 'package:first_app/features/patient_features/doctorAvailability/2_views/bloc/doctor_availability_bloc.dart';
import 'package:first_app/features/patient_features/doctorDetails/2_views/bloc/doctor_details_bloc.dart';
import 'package:first_app/features/patient_features/doctorOfficeAddress/2_views/bloc/doctor_office_address_bloc.dart';
import 'package:first_app/features/patient_features/emergencyAnnouncements/2_views/bloc/emergency_announcements_bloc.dart';
import 'package:first_app/features/patient_features/find/2_views/bloc/find_bloc.dart';
import 'package:first_app/features/patient_features/forums/2_views/bloc/forums_bloc.dart';
import 'package:first_app/features/patient_features/home/2_views/bloc/home_bloc.dart';
import 'package:first_app/features/patient_features/myForums/2_views/bloc/my_forums_bloc.dart';
import 'package:first_app/features/patient_features/periodTracker/2_views/bloc/period_tracker_bloc.dart';
import 'package:first_app/features/patient_features/profile/2_views/bloc/profile_bloc.dart';
import 'package:first_app/features/patient_features/profile/2_views/widgets/profile_update_dialog/bloc/profile_update_bloc.dart';
import 'package:first_app/features/splash/bloc/splash_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> getBlocProviders() {
  return [
    // Auth Blocs
    BlocProvider<SplashBloc>(
      create: (context) => sl<SplashBloc>(),
    ),
    BlocProvider<AuthBloc>(
      create: (context) => sl<AuthBloc>(),
    ),
    BlocProvider<ForgotPasswordBloc>(
      create: (context) => sl<ForgotPasswordBloc>(),
    ),
    //Admin Blocs

    BlocProvider<AdminLoginBloc>(
      create: (context) => sl<AdminLoginBloc>(),
    ),
    BlocProvider<AdminNavigationDrawerBloc>(
      create: (context) => AdminNavigationDrawerBloc(),
    ),
    BlocProvider<AdminDashboardBloc>(
      create: (context) => sl<AdminDashboardBloc>(),
    ),
    BlocProvider<AdminDoctorVerificationBloc>(
      create: (context) => sl<AdminDoctorVerificationBloc>(),
    ),
    BlocProvider<AdminDoctorListBloc>(
      create: (context) => sl<AdminDoctorListBloc>(),
    ),
    BlocProvider<AdminPatientListBloc>(
      create: (context) => sl<AdminPatientListBloc>(),
    ),

    //Patient Blocs
    BlocProvider<BottomNavigationBloc>(
      create: (context) => BottomNavigationBloc(),
    ),
    BlocProvider<HomeBloc>(
      create: (context) => sl<HomeBloc>(),
    ),
    BlocProvider<FloatingMenuBloc>(
      create: (context) => sl<FloatingMenuBloc>(),
    ),
    BlocProvider<FindBloc>(
      create: (context) => sl<FindBloc>(),
    ),
    BlocProvider<ConsultationBloc>(
      create: (context) => sl<ConsultationBloc>(),
    ),
    BlocProvider<ProfileBloc>(
      create: (context) => sl<ProfileBloc>(),
    ),
    BlocProvider<ProfileUpdateBloc>(
      create: (context) => sl<ProfileUpdateBloc>(),
    ),
    BlocProvider<DoctorDetailsBloc>(
      create: (context) => sl<DoctorDetailsBloc>(),
    ),
    BlocProvider<DoctorAvailabilityBloc>(
      create: (context) => sl<DoctorAvailabilityBloc>(),
    ),
    BlocProvider<DoctorOfficeAddressBloc>(
      create: (context) => sl<DoctorOfficeAddressBloc>(),
    ),
    BlocProvider<BookAppointmentBloc>(
      create: (context) => sl<BookAppointmentBloc>(),
    ),
    BlocProvider<AppointmentBloc>(
      create: (context) => sl<AppointmentBloc>(),
    ),
    BlocProvider<AppointmentDetailsBloc>(
      create: (context) => sl<AppointmentDetailsBloc>(),
    ),
    BlocProvider<PeriodTrackerBloc>(
      create: (context) => sl<PeriodTrackerBloc>(),
    ),
    BlocProvider<ForumsBloc>(
      create: (context) => sl<ForumsBloc>(),
    ),
    BlocProvider<MyForumsBloc>(
      create: (context) => sl<MyForumsBloc>(),
    ),
    BlocProvider<EmergencyAnnouncementsBloc>(
      create: (context) => sl<EmergencyAnnouncementsBloc>(),
    ),

    //Doctor Blocs
    BlocProvider<FloatingDoctorMenuBarBloc>(
      create: (context) => sl<FloatingDoctorMenuBarBloc>(),
    ),
    BlocProvider<DoctorCalendarBloc>(
      create: (context) => sl<DoctorCalendarBloc>(),
    ),
    BlocProvider<DoctorBottomNavigationBloc>(
      create: (context) => sl<DoctorBottomNavigationBloc>(),
    ),
    BlocProvider<HomeDashboardBloc>(
      create: (context) => sl<HomeDashboardBloc>(),
    ),
    BlocProvider<DoctorAppointmentRequestScreenLoadedBloc>(
      create: (context) => sl<DoctorAppointmentRequestScreenLoadedBloc>(),
    ),
    BlocProvider<ApprovedRequestStateBloc>(
      create: (context) => sl<ApprovedRequestStateBloc>(),
    ),
    BlocProvider<CancelledRequestStateBloc>(
      create: (context) => sl<CancelledRequestStateBloc>(),
    ),
    BlocProvider<DeclinedRequestStateBloc>(
      create: (context) => sl<DeclinedRequestStateBloc>(),
    ),
    BlocProvider<PendingRequestStateBloc>(
      create: (context) => sl<PendingRequestStateBloc>(),
    ),
    BlocProvider<DoctorEConsultBloc>(
      create: (context) => sl<DoctorEConsultBloc>(),
    ),
    BlocProvider<DoctorConsultationBloc>(
      create: (context) => sl<DoctorConsultationBloc>(),
    ),
    BlocProvider<DoctorForumsBloc>(
      create: (context) => sl<DoctorForumsBloc>(),
    ),
    BlocProvider<DoctorProfileUpdateBloc>(
      create: (context) => sl<DoctorProfileUpdateBloc>(),
    ),
    BlocProvider<DoctorProfileBloc>(
      create: (context) => sl<DoctorProfileBloc>(),
    ),
    BlocProvider<DoctorMyForumsBloc>(
      create: (context) => sl<DoctorMyForumsBloc>(),
    ),
    BlocProvider<DoctorScheduleBloc>(
      create: (context) => sl<DoctorScheduleBloc>(),
    ),
    BlocProvider<CreateDoctorScheduleBloc>(
      create: (context) => sl<CreateDoctorScheduleBloc>(),
    ),
    BlocProvider<DoctorViewPatientsBloc>(
      create: (context) => sl<DoctorViewPatientsBloc>(),
    ),
    BlocProvider<DoctorViewPatientDetailsBloc>(
      create: (context) => sl<DoctorViewPatientDetailsBloc>(),
    ),
    BlocProvider<DoctorUpcomingAppointmentsBloc>(
      create: (context) => sl<DoctorUpcomingAppointmentsBloc>(),
    ),
    BlocProvider<DoctorForumBadgeBloc>(
      create: (context) => sl<DoctorForumBadgeBloc>(),
    ),
    BlocProvider<DoctorEmergencyAnnouncementsBloc>(
      create: (context) => sl<DoctorEmergencyAnnouncementsBloc>(),
    ),
  ];
}
