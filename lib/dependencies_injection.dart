import 'package:first_app/core/reusable_widgets/doctor_reusable_widgets/floating_doctor_menu_bar/bloc/floating_doctor_menu_bar_bloc.dart';
import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/floating_menu_bar/2_views/bloc/floating_menu_bloc.dart';
import 'package:first_app/core/storage/sharedPreferences/shared_preferences_manager.dart';
import 'package:first_app/features/admin_features/adminDashboard/1_controllers/admin_dashboard_controller.dart';
import 'package:first_app/features/admin_features/adminDashboard/2_views/bloc/admin_dashboard_bloc.dart';
import 'package:first_app/features/admin_features/adminDoctorList/2_views/bloc/admin_doctor_list_bloc.dart';
import 'package:first_app/features/admin_features/adminDoctorVerification/1_controllers/admin_doctor_verification_controller.dart';
import 'package:first_app/features/admin_features/adminDoctorVerification/2_views/bloc/admin_doctor_verification_bloc.dart';
import 'package:first_app/features/admin_features/adminNavigationDrawer/2_views/bloc/admin_navigation_drawer_bloc.dart';
import 'package:first_app/features/admin_features/adminPatientList/1_controllers/admin_patient_list_controller.dart';
import 'package:first_app/features/admin_features/adminPatientList/2_views/bloc/admin_patient_list_bloc.dart';
import 'package:first_app/features/admin_features/login/1_controllers/admin_login_controllers.dart';
import 'package:first_app/features/admin_features/login/2_views/bloc/admin_login_bloc.dart';
import 'package:first_app/features/auth/1_controllers/doctor_auth_controller.dart';
import 'package:first_app/features/auth/1_controllers/patient_auth_controller.dart';
import 'package:first_app/features/auth/2_views/bloc/auth_bloc.dart';
import 'package:first_app/features/auth/2_views/screens/forgot_password/2_views/bloc/forgot_password_bloc.dart';
import 'package:first_app/features/auth/2_views/widgets/signup_widgets/doctor/doctor_office_address/bloc/doctor_address_bloc.dart';
import 'package:first_app/features/doctor_features/createDoctorSchedule/1_controllers/create_doctor_schedule_controller.dart';
import 'package:first_app/features/doctor_features/createDoctorSchedule/2_views/bloc/create_doctor_schedule_bloc.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/0_controllers/doctor_appointment_request_controller.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/screens/bloc/doctor_appointment_request_screen_loaded_bloc.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/view_states/approvedState/bloc/approved_request_state_bloc.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/view_states/cancelledState/bloc/cancelled_request_state_bloc.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/view_states/declinedState/bloc/declined_request_state_bloc.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/view_states/pendingState/bloc/pending_request_state_bloc.dart';
import 'package:first_app/features/doctor_features/doctorBottomNavigation/bloc/doctor_bottom_navigation_bloc.dart';
import 'package:first_app/features/doctor_features/doctorCalendarPage/bloc/doctor_calendar_bloc.dart';
import 'package:first_app/features/doctor_features/doctorConsultation/1_controllers/doctor_chat_message_controller.dart';
import 'package:first_app/features/doctor_features/doctorConsultation/2_views/bloc/doctor_consultation_bloc.dart';
import 'package:first_app/features/doctor_features/doctorConsultationFee/1_controllers/doctor_consultation_fee_controller.dart';
import 'package:first_app/features/doctor_features/doctorConsultationFee/2_views/bloc/doctor_consultation_fee_bloc.dart';
import 'package:first_app/features/doctor_features/doctorEConsult/1_controllers/doctor_e_consult_controller.dart';
import 'package:first_app/features/doctor_features/doctorEConsult/2_views/bloc/doctor_e_consult_bloc.dart';
import 'package:first_app/features/doctor_features/doctorEmergencyAnnouncements/1_controller/doctor_emergency_announcements_controller.dart';
import 'package:first_app/features/doctor_features/doctorEmergencyAnnouncements/2_views/bloc/doctor_emergency_announcements_bloc.dart';
import 'package:first_app/features/doctor_features/doctorForumBadge/1_controller/doctor_forum_badge_controller.dart';
import 'package:first_app/features/doctor_features/doctorForumBadge/2_views/bloc/doctor_forum_badge_bloc.dart';
import 'package:first_app/features/doctor_features/doctorForums/1_controllers/doctor_forums_controller.dart';
import 'package:first_app/features/doctor_features/doctorForums/2_views/bloc/doctor_forums_bloc.dart';
import 'package:first_app/features/doctor_features/doctorMyForums/2_views/bloc/doctor_my_forums_bloc.dart';
import 'package:first_app/features/doctor_features/doctorProfile/1_controllers/doctor_profile_controller.dart';
import 'package:first_app/features/doctor_features/doctorProfile/2_views/bloc/doctor_profile_bloc.dart';
import 'package:first_app/features/doctor_features/doctorProfile/2_views/widgets/doctor_profile_update_dialog/bloc/doctor_profile_update_bloc.dart';
import 'package:first_app/features/doctor_features/doctorScheduleManagement/1_controllers/doctor_schedule_controller.dart';
import 'package:first_app/features/doctor_features/doctorScheduleManagement/2_views/bloc/doctor_schedule_bloc.dart';
import 'package:first_app/features/doctor_features/doctorUpcomingAppointments/1_controllers/doctor_upcoming_appointments_controller.dart';
import 'package:first_app/features/doctor_features/doctorUpcomingAppointments/2_views/bloc/doctor_upcoming_appointments_bloc.dart';
import 'package:first_app/features/doctor_features/doctorViewPatientDetails/2_views/bloc/doctor_view_patient_details_bloc.dart';
import 'package:first_app/features/doctor_features/doctorViewPatients/1_controllers/doctor_view_patients_controller.dart';
import 'package:first_app/features/doctor_features/doctorViewPatients/2_views/bloc/doctor_view_patients_bloc.dart';
import 'package:first_app/features/doctor_features/homeDashboard/1_controllers/doctor_home_dashboard_controllers.dart';
import 'package:first_app/features/doctor_features/homeDashboard/2_views/bloc/home_dashboard_bloc.dart';
import 'package:first_app/features/patient_features/appointment/2_views/bloc/appointment_bloc.dart';
import 'package:first_app/features/patient_features/appointmentDetails/2_views/bloc/appointment_details_bloc.dart';
import 'package:first_app/features/patient_features/bookAppointment/1_controllers/appointment_controller.dart';
import 'package:first_app/features/patient_features/bookAppointment/2_views/bloc/book_appointment_bloc.dart';
import 'package:first_app/features/patient_features/bottomNavigation/bloc/bottom_navigation_bloc.dart';
import 'package:first_app/features/patient_features/consultation/1_controllers/appointment_chat_controller.dart';
import 'package:first_app/features/patient_features/consultation/1_controllers/chat_message_controllers.dart';
import 'package:first_app/features/patient_features/consultation/2_views/bloc/consultation_bloc.dart';
import 'package:first_app/features/patient_features/consultationFeeDetails/1_controller/consultation_fee_details_controller.dart';
import 'package:first_app/features/patient_features/consultationFeeDetails/2_views/bloc/consultation_fee_details_bloc.dart';
import 'package:first_app/features/patient_features/cycleHistory/1_controllers/cycle_history_controller.dart';
import 'package:first_app/features/patient_features/cycleHistory/2_views/bloc/cycle_history_bloc.dart';
import 'package:first_app/features/patient_features/doctorAvailability/1_controller/doctor_availability_controller.dart';
import 'package:first_app/features/patient_features/doctorAvailability/2_views/bloc/doctor_availability_bloc.dart';
import 'package:first_app/features/patient_features/doctorDetails/2_views/bloc/doctor_details_bloc.dart';
import 'package:first_app/features/patient_features/doctorOfficeAddress/2_views/bloc/doctor_office_address_bloc.dart';
import 'package:first_app/features/patient_features/emergencyAnnouncements/1_controllers/emergency_announcement_controllers.dart';
import 'package:first_app/features/patient_features/emergencyAnnouncements/2_views/bloc/emergency_announcements_bloc.dart';
import 'package:first_app/features/patient_features/find/1_controllers/find_controllers.dart';
import 'package:first_app/features/patient_features/find/2_views/bloc/find_bloc.dart';
import 'package:first_app/features/patient_features/forums/1_controllers/forums_controller.dart';
import 'package:first_app/features/patient_features/forums/2_views/bloc/forums_bloc.dart';
import 'package:first_app/features/patient_features/home/2_views/bloc/home_bloc.dart';
import 'package:first_app/features/patient_features/myForums/1_controllers/my_forums_controller.dart';
import 'package:first_app/features/patient_features/myForums/2_views/bloc/my_forums_bloc.dart';
import 'package:first_app/features/patient_features/periodTracker/1_controllers/period_tracker_controller.dart';
import 'package:first_app/features/patient_features/periodTracker/2_views/bloc/period_tracker_bloc.dart';
import 'package:first_app/features/patient_features/profile/1_controllers/profile_controller.dart';
import 'package:first_app/features/patient_features/profile/2_views/bloc/profile_bloc.dart';
import 'package:first_app/features/patient_features/profile/2_views/widgets/profile_update_dialog/bloc/profile_update_bloc.dart';
import 'package:first_app/features/splash/bloc/splash_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.I;

Future<void> init() async {
  //!Core
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerFactory(() => sharedPreferences);
  sl.registerLazySingleton<SharedPreferencesManager>(
      () => SharedPreferencesManager());

//---------------------------------------------------------------------------
  //! Features - Splash
  sl.registerFactory(
    () => SplashBloc(
      sharedPreferencesManager: sl(),
    ),
  );
  // ----------------------------------------------------------------------------------
  //! Features - Auth
  sl.registerFactory(() => AuthBloc(
        patientAuthenticationController: sl(),
        doctorAuthenticationController: sl(),
      ));

  sl.registerFactory(() => AuthenticationController());
  sl.registerFactory(() => DoctorAuthenticationController());

//* ------------------------------------------Admin Features----------------------------------------

//! Features - Admin Login
  sl.registerFactory(() => AdminLoginBloc(
        adminLoginControllers: sl(),
      ));

  sl.registerFactory(() => AdminLoginControllers());
  // ----------------------------------------------------------------------------------

//! Features - Admin Navigation Drawer
  sl.registerFactory(
    () => AdminNavigationDrawerBloc(),
  );
// ----------------------------------------------------------------------------------

//! Features - Admin Dashboard
  sl.registerFactory(
    () => AdminDashboardBloc(
      adminDashboardController: sl(),
      adminDoctorVerificationController: sl(),
    ),
  );

  sl.registerFactory(() => AdminDashboardController());

// ----------------------------------------------------------------------------------

//! Features - Admin Doctor Verification
  sl.registerFactory(
    () => AdminDoctorVerificationBloc(
      adminDoctorVerificationController: sl(),
    ),
  );

  sl.registerFactory(() => AdminDoctorVerificationController());

// ----------------------------------------------------------------------------------

//! Features - Admin Doctor List
  sl.registerFactory(
    () => AdminDoctorListBloc(
      adminDoctorVerificationController: sl(),
      adminDashboardController: sl(),
    ),
  );

// ----------------------------------------------------------------------------------

//! Features - Admin Patient List
  sl.registerFactory(
    () => AdminPatientListBloc(
      adminPatientListController: sl(),
    ),
  );

  sl.registerFactory(() => AdminPatientListController());
//* -----------------------------------------Patient Features------------------------------------

//! Features -Doctor Address Location

  sl.registerFactory(
    () => DoctorAddressBloc(),
  );

// ----------------------------------------------------------------------------------

  //! Features - Bottom Navigation Bar
  sl.registerFactory(
    () => BottomNavigationBloc(),
  );

// ----------------------------------------------------------------------------------

//! Features - Forgot Password

  sl.registerFactory(() => ForgotPasswordBloc());
// ----------------------------------------------------------------------------------

//! Features - Home

  sl.registerFactory(() => HomeBloc(
        appointmentController: sl(),
        periodTrackerController: sl(),
      ));

// ----------------------------------------------------------------------------------

//! Features - Profile

  sl.registerFactory(() => ProfileBloc(
        profileController: sl(),
      ));

  sl.registerFactory(() => ProfileUpdateBloc(
        profileController: sl(),
      ));

  sl.registerFactory(() => ProfileController());

// ----------------------------------------------------------------------------------

//! Features - Floating Menu

  sl.registerFactory(() => FloatingMenuBloc(
        profileController: sl(),
      ));

// ----------------------------------------------------------------------------------

  //! Features - Find

  sl.registerFactory(() => FindBloc(
        findController: sl(),
      ));

  sl.registerFactory(() => FindController());

// ----------------------------------------------------------------------------------

  //! Features - Doctor Details
  sl.registerFactory(() => DoctorDetailsBloc());

  // ----------------------------------------------------------------------------------

  //! Features - Appointment Details
  sl.registerFactory(() => AppointmentDetailsBloc(
        appointmentController: sl(),
        profileController: sl(),
      ));

  // ----------------------------------------------------------------------------------

  //! Features - Consultation Fee Details
  sl.registerFactory(() => ConsultationFeeDetailsController());

  sl.registerFactory(() => ConsultationFeeDetailsBloc(
        consultationFeeDetailsController: sl(),
      ));

  // ----------------------------------------------------------------------------------

  //! Features- Doctor Availability
  sl.registerFactory(() => DoctorAvailabilityBloc(
        doctorAvailabilityController: sl(),
      ));

  sl.registerFactory(() => DoctorAvailabilityController());

  // ----------------------------------------------------------------------------------

  //! Features- Doctor Office Address
  sl.registerFactory(() => DoctorOfficeAddressBloc());

  // ----------------------------------------------------------------------------------

  //! Features- Book Appointment
  sl.registerFactory(() => BookAppointmentBloc(
        doctorAvailabilityController: sl(),
        appointmentController: sl(),
        profileController: sl(),
      ));
  sl.registerFactory(() => AppointmentController());

  // ----------------------------------------------------------------------------------

  //! Features- Cycle History
  sl.registerFactory(() => CycleHistoryBloc(
        cycleHistoryController: sl(),
      ));

  sl.registerFactory(() => CycleHistoryController());

  // ----------------------------------------------------------------------------------

  //! Features- Appointment

  sl.registerFactory(() => AppointmentBloc(
        appointmentController: sl(),
        profileController: sl(),
        findController: sl(),
      ));

  // ----------------------------------------------------------------------------------

  //! Features- Period Tracker

  sl.registerFactory(() => PeriodTrackerBloc(
        periodTrackerController: sl(),
      ));

  sl.registerFactory(() => PeriodTrackerController());

  // ----------------------------------------------------------------------------------

  //! Features- Forums

  sl.registerFactory(() => ForumsBloc(
        forumsController: sl(),
      ));

  sl.registerFactory(() => ForumsController());
  // ----------------------------------------------------------------------------------

  //! Features- MyForums

  sl.registerFactory(() => MyForumsBloc(
        myForumsController: sl(),
      ));

  sl.registerFactory(() => MyForumsController());
  // ----------------------------------------------------------------------------------

  //! Features- Consultation

  sl.registerFactory(() => ConsultationBloc(
        chatMessageController: sl(),
        appointmentChatController: sl(),
      ));

  sl.registerFactory(() => ChatMessageController());
  sl.registerFactory(() => AppointmentChatController());

  // ----------------------------------------------------------------------------------

  //! Features- Emergency Announcements

  sl.registerFactory(() => EmergencyAnnouncementsBloc(
        emergencyController: sl(),
      ));
  sl.registerFactory(() => EmergencyAnnouncementsController());

  //* --------------------------------Doctor Features--------------------------------------------------

  //! Features- Doctor Floating Menu

  sl.registerFactory(() => FloatingDoctorMenuBarBloc(
        doctorProfileController: sl(),
      ));

  // ----------------------------------------------------------------------------------

  //! Features- Doctor Home Dashboard

  sl.registerFactory(() => HomeDashboardBloc(
        doctorHomeDashboardController: sl(),
      ));

  sl.registerFactory(() => DoctorHomeDashboardController());
  // ----------------------------------------------------------------------------------

  //! Features- Doctor Calendar Page

  sl.registerFactory(() => DoctorCalendarBloc());

  // ----------------------------------------------------------------------------------

  //! Features- Doctor Bottom Navigation Bar

  sl.registerFactory(() => DoctorBottomNavigationBloc());

  // ----------------------------------------------------------------------------------

  //! Features- Request Appointment

  sl.registerFactory(() => DoctorAppointmentRequestScreenLoadedBloc());

  // ----------------------------------------------------------------------------------

  //! Features- Approved Request Appointment

  sl.registerFactory(() => ApprovedRequestStateBloc(
        doctorAppointmentRequestController: sl(),
      ));

  sl.registerFactory(() => DoctorAppointmentRequestController());

  // ----------------------------------------------------------------------------------
  //! Features- Cancelled Request Appointment

  sl.registerFactory(() => CancelledRequestStateBloc(
        doctorAppointmentRequestController: sl(),
      ));

  // ----------------------------------------------------------------------------------

  //! Features- Cancelled Request Appointment

  sl.registerFactory(() => DeclinedRequestStateBloc(
        doctorAppointmentRequestController: sl(),
      ));

  // ----------------------------------------------------------------------------------

  //! Features- Pending Request Appointment

  sl.registerFactory(() => PendingRequestStateBloc(
        doctorAppointmentRequestController: sl(),
      ));
  // ----------------------------------------------------------------------------------

  //! Features- Doctor E consult

  sl.registerFactory(() => DoctorEConsultBloc(
        doctorEConsultController: sl(),
        doctorAppointmentRequestController: sl(),
      ));

  sl.registerFactory(() => DoctorEConsultController());

// ----------------------------------------------------------------------------------

  //! Features- Doctor Consultation

  sl.registerFactory(() => DoctorConsultationBloc(
        doctorChatMessageController: sl(),
        appointmentChatController: sl(),
        doctorAppointmentRequestController: sl(),
      ));

  sl.registerFactory(() => DoctorChatMessageController());

  // ----------------------------------------------------------------------------------

  //! Features- Doctor Forums

  // ----------------------------------------------------------------------------------

  sl.registerFactory(() => DoctorForumsBloc(
        docForumsController: sl(),
      ));
  sl.registerFactory(() => DoctorForumsController());

// ----------------------------------------------------------------------------------

//! Features - Doctor Profile

  sl.registerFactory(() => DoctorProfileBloc(
        docProfileController: sl(),
      ));

  sl.registerFactory(() => DoctorProfileUpdateBloc(
        doctorProfileController: sl(),
      ));

  sl.registerFactory(() => DoctorProfileController());

  //-------------------------------------------------------------------------------------

  //! Features - Doctor My Forums

  sl.registerFactory(() => DoctorMyForumsBloc(
        myForumsController: sl(),
      ));

  //-------------------------------------------------------------------------------------

  //! Features- Doctor Schedule Management

  // ----------------------------------------------------------------------------------

  sl.registerFactory(() => DoctorScheduleBloc(
        doctorProfileController: sl(),
        doctorScheduleController: sl(),
      ));

  sl.registerFactory(() => DoctorScheduleController());

  //! Features- Doctor Create Schedule Management

  // ----------------------------------------------------------------------------------

  sl.registerFactory(() => CreateDoctorScheduleBloc(
        scheduleController: sl(),
      ));

  sl.registerFactory(() => CreateDoctorScheduleController());

  //! Features- Doctor viewpatient list

  // ----------------------------------------------------------------------------------
  sl.registerFactory(() => DoctorViewPatientsBloc(
        doctorViewPatientsController: sl(),
      ));

  sl.registerFactory(() => DoctorViewPatientsController());

  //! Features- Doctor viewpatient details

  sl.registerFactory(() => DoctorViewPatientDetailsBloc());

  //! Features- Doctor consultation fee

  // ----------------------------------------------------------------------------------
  sl.registerFactory(() => DoctorConsultationFeeBloc(
        doctorConsultationFeeController: sl(),
      ));
  sl.registerFactory(() => DoctorConsultationFeeController());

  // ----------------------------------------------------------------------------------

  //! Features- Doctor Upcoming Appointments

  sl.registerFactory(() => DoctorUpcomingAppointmentsBloc(
        doctorUpcomingAppointmentControllers: sl(),
      ));

  sl.registerFactory(() => DoctorUpcomingAppointmentControllers());

  //! Features- Doctor Forum Badge
  // ----------------------------------------------------------------------------------
  sl.registerFactory(() => DoctorForumBadgeBloc(
        doctorConsultationFeeController: sl(),
        doctorForumBadgeController: sl(),
      ));

  sl.registerFactory(() => DoctorForumBadgeController());

  // ----------------------------------------------------------------------------------

  //! Features- Doctor Emergency Announcement

  sl.registerFactory(() => DoctorEmergencyAnnouncementsBloc(
        doctorEmergencyAnnouncementsController: sl(),
      ));

  sl.registerFactory(() => DoctorEmergencyAnnouncementsController());
}
