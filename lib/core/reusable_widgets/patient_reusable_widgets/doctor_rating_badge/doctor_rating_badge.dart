// import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/doctor_rating_badge/doctor_rating_modals/active_doctor_modal.dart';
import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/doctor_rating_badge/doctor_rating_modals/contributing_doctor_modal.dart';
import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/doctor_rating_badge/doctor_rating_modals/new_doctor_modal.dart';
import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/doctor_rating_badge/doctor_rating_modals/doctor_badge_widget.dart';
import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/doctor_rating_badge/doctor_rating_modals/top_doctor_modal.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:flutter/material.dart';
// import 'package:web/helpers.dart';

// ignore: must_be_immutable
class DoctorRatingBadge extends StatelessWidget {
  final int doctorRating;
  double? scale;
  double? width;

  DoctorRatingBadge({
    super.key,
    required this.doctorRating,
    this.scale,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    Widget badge;
    void Function()? onTap;

    switch (doctorRating) {
      case 0:
        badge = const DoctorBadge(
          badgeName: 'New Doctor',
          badgeBgColor: GinaAppTheme.searchBarColor,
          badgeTextColor: GinaAppTheme.lightOutline,
        );
        onTap = () => newDoctorModal(context);
        break;
      case 1:
        badge = const DoctorBadge(
          badgeName: 'Active Doctor',
          badgeBgColor: Color(0xffFFEBD8),
          badgeTextColor: GinaAppTheme.pendingTextColor,
        );
        onTap = () => activeDoctorModal(context);
        break;
      case 2:
        badge = const DoctorBadge(
          badgeName: 'Contributing Doctor',
          badgeBgColor: Color(0xffFFEAE7),
          badgeTextColor: GinaAppTheme.lightTertiary,
        );
        onTap = () => contributingDoctorModal(context);
        break;
      case 3:
        badge = const DoctorBadge(
          badgeName: 'Top Doctor',
          badgeBgColor: GinaAppTheme.lightPrimaryContainer,
          badgeTextColor: GinaAppTheme.declinedTextColor,
        );
        onTap = () => topDoctorModal(context);
        break;
      default:
        badge = const DoctorBadge(
          badgeName: 'New Doctor',
          badgeBgColor: GinaAppTheme.searchBarColor,
          badgeTextColor: GinaAppTheme.lightOutline,
        );
        onTap = () => newDoctorModal(context);
    }
    return InkWell(
      onTap: onTap,
      child: badge,
      //   scale: scale,
      //   width: width,
      // ),
    );
  }
}
