import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/admin_features/adminDoctorList/2_views/bloc/admin_doctor_list_bloc.dart';
import 'package:first_app/features/admin_features/adminDoctorVerification/2_views/widgets/doctor_verification_status_chip.dart';
import 'package:first_app/features/admin_features/adminPatientList/2_views/widgets/admin_patient_appointment_status.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:first_app/features/auth/0_model/doctor_verification_model.dart';
import 'package:first_app/features/patient_features/bookAppointment/0_model/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class AdminDoctorDetailsState extends StatelessWidget {
  final DoctorModel approvedDoctorDetails;
  final List<DoctorVerificationModel> doctorVerification;
  final List<AppointmentModel> appointments;

  const AdminDoctorDetailsState(
      {super.key,
      required this.approvedDoctorDetails,
      required this.doctorVerification,
      required this.appointments});

  @override
  Widget build(BuildContext context) {
    final themeOfContext = Theme.of(context);
    final adminDoctorListBloc = context.read<AdminDoctorListBloc>();

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 1.15,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: GinaAppTheme.appbarColorLight,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //----Back Button ------
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 20.0),
                child: InkWell(
                  onTap: () {
                    adminDoctorListBloc.add(AdminDoctorListGetRequestEvent());
                  },
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: GinaAppTheme.lightOutline,
                  ),
                ),
              ),
              //------------Doctor Primary Details----------------
              Padding(
                padding: const EdgeInsets.only(
                  left: 60.0,
                  right: 40.0,
                ),
                child: Row(
                  children: [
                    Image.asset(Images.doctorVerificationPlaceholderImage),
                    const Gap(40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Dr. ${approvedDoctorDetails.name}',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 27,
                                  ),
                            ),
                            const Gap(8),
                            const Icon(Icons.verified,
                                color: Colors.blue, size: 20),
                            const Gap(20),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_pin,
                                  color: GinaAppTheme.lightSecondary,
                                ),
                                Text(
                                  approvedDoctorDetails
                                      .officeMapsLocationAddress,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        color: GinaAppTheme.lightSecondary,
                                      ),
                                ),
                              ],
                            ),
                            const Gap(570),
                          ],
                        ),
                        const Gap(10),
                        Container(
                          // Remove the width property
                          height: MediaQuery.of(context).size.height * 0.025,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: GinaAppTheme.lightSurfaceVariant,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10.0), // Add some horizontal padding
                          child: Center(
                            child: Text(approvedDoctorDetails.medicalSpecialty,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w800)),
                          ),
                        ),
                        const Gap(15),
                        Row(
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'License number: ',
                                      style: themeOfContext
                                          .textTheme.labelMedium
                                          ?.copyWith(
                                        color: GinaAppTheme.lightOutline,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Gap(7),
                                    Text(
                                      'Email: ',
                                      style: themeOfContext
                                          .textTheme.labelMedium
                                          ?.copyWith(
                                        color: GinaAppTheme.lightOutline,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Gap(7),
                                    Text(
                                      'Contact Number: ',
                                      style: themeOfContext
                                          .textTheme.labelMedium
                                          ?.copyWith(
                                        color: GinaAppTheme.lightOutline,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Gap(7),
                                    Text(
                                      'Office Address: ',
                                      style: themeOfContext
                                          .textTheme.labelMedium
                                          ?.copyWith(
                                        color: GinaAppTheme.lightOutline,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      approvedDoctorDetails
                                          .medicalLicenseNumber,
                                      style: themeOfContext
                                          .textTheme.labelMedium
                                          ?.copyWith(
                                        color: GinaAppTheme.lightOnSecondary,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const Gap(7),
                                    Text(
                                      approvedDoctorDetails.email,
                                      style: themeOfContext
                                          .textTheme.labelMedium
                                          ?.copyWith(
                                        color: GinaAppTheme.lightSecondary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Gap(7),
                                    Text(
                                      approvedDoctorDetails.officeAdress,
                                      style: themeOfContext
                                          .textTheme.labelMedium
                                          ?.copyWith(
                                        color: GinaAppTheme.lightSecondary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Gap(7),
                                    Text(
                                      approvedDoctorDetails.officeAdress,
                                      style: themeOfContext
                                          .textTheme.labelMedium
                                          ?.copyWith(
                                        color: GinaAppTheme.lightOnSecondary,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Gap(300),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      Images.doctorDateRegistered,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.045,
                                      filterQuality: FilterQuality.high,
                                    ),
                                    const Gap(20),
                                    Text(
                                      'DATE REGISTERED ',
                                      style: themeOfContext.textTheme.labelLarge
                                          ?.copyWith(
                                        color: GinaAppTheme.lightOutline,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Gap(20),
                                    Text(
                                      DateFormat('MM/dd/yyyy').format(
                                          approvedDoctorDetails.created!
                                              .toDate()),
                                      style: themeOfContext.textTheme.labelLarge
                                          ?.copyWith(
                                        color: GinaAppTheme.lightOnSecondary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(5),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.17,
                                  child: const Divider(
                                    color: GinaAppTheme.lightOutline,
                                    thickness: 0.3,
                                  ),
                                ),
                                const Gap(5),
                                Row(
                                  children: [
                                    Image.asset(
                                      Images.doctorDateSubmitted,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.045,
                                      filterQuality: FilterQuality.high,
                                    ),
                                    const Gap(20),
                                    Text(
                                      'DATE SUBMITTED ',
                                      style: themeOfContext.textTheme.labelLarge
                                          ?.copyWith(
                                        color: GinaAppTheme.lightOutline,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Gap(20),
                                    Text(
                                      doctorVerification.isEmpty
                                          ? 'N/A'
                                          : DateFormat('MM/dd/yyyy').format(
                                              approvedDoctorDetails
                                                  .verifiedDate!
                                                  .toDate()
                                                  .toLocal()),
                                      style: themeOfContext.textTheme.labelLarge
                                          ?.copyWith(
                                        color: GinaAppTheme.lightOnSecondary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Gap(10),
              //---------------------------------Divider--------------------------------
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 55.0),
                    child: Divider(
                      color: GinaAppTheme.lightOutline,
                      thickness: 0.3,
                    ),
                  ),
                ),
              ),
              //-----------------------------------------------------------------------

              Padding(
                padding: const EdgeInsets.only(left: 60.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(30),
                        Text(
                          'Board Certification',
                          style: themeOfContext.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(20),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name of the Board\nCertification Organization: ',
                                  style: themeOfContext.textTheme.labelMedium
                                      ?.copyWith(
                                    color: GinaAppTheme.lightOutline,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Gap(10),
                                Text(
                                  'Date of Certification: ',
                                  style: themeOfContext.textTheme.labelMedium
                                      ?.copyWith(
                                    color: GinaAppTheme.lightOutline,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(25),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  approvedDoctorDetails
                                      .boardCertificationOrganization,
                                  style: themeOfContext.textTheme.labelMedium
                                      ?.copyWith(
                                    color: GinaAppTheme.lightOnSecondary,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const Gap(24),
                                Text(
                                  approvedDoctorDetails.boardCertificationDate,
                                  style: themeOfContext.textTheme.labelMedium
                                      ?.copyWith(
                                    color: GinaAppTheme.lightOnSecondary,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Gap(15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: const Padding(
                              padding: EdgeInsets.only(right: 55.0),
                              child: Divider(
                                color: GinaAppTheme.lightOutline,
                                thickness: 0.3,
                              ),
                            ),
                          ),
                        ),
                        const Gap(10),
                        Text(
                          'Education Experience',
                          style: themeOfContext.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(10),
                        Text(
                          'Medical School',
                          style: themeOfContext.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const Gap(10),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name of the Medical\nSchool Attended: ',
                                  style: themeOfContext.textTheme.labelMedium
                                      ?.copyWith(
                                    color: GinaAppTheme.lightOutline,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Gap(10),
                                Text(
                                  'Start Date: ',
                                  style: themeOfContext.textTheme.labelMedium
                                      ?.copyWith(
                                    color: GinaAppTheme.lightOutline,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Gap(10),
                                Text(
                                  'End Date: ',
                                  style: themeOfContext.textTheme.labelMedium
                                      ?.copyWith(
                                    color: GinaAppTheme.lightOutline,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(65),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  approvedDoctorDetails.medicalSchool,
                                  style: themeOfContext.textTheme.labelMedium
                                      ?.copyWith(
                                    color: GinaAppTheme.lightOnSecondary,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const Gap(24),
                                Text(
                                  approvedDoctorDetails.medicalSchoolStartDate,
                                  style: themeOfContext.textTheme.labelMedium
                                      ?.copyWith(
                                    color: GinaAppTheme.lightOnSecondary,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const Gap(10),
                                Text(
                                  approvedDoctorDetails.medicalSchoolEndDate,
                                  style: themeOfContext.textTheme.labelMedium
                                      ?.copyWith(
                                    color: GinaAppTheme.lightOnSecondary,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Gap(20),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.37,
                      child: const VerticalDivider(
                        color: GinaAppTheme.lightOutline,
                        thickness: 0.3,
                      ),
                    ),
                    const Gap(70),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(30),
                        Text(
                          'Residency Program',
                          style: themeOfContext.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(20),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name of the Medical\nSchool Attended: ',
                                  style: themeOfContext.textTheme.labelMedium
                                      ?.copyWith(
                                    color: GinaAppTheme.lightOutline,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Gap(10),
                                Text(
                                  'Start Date: ',
                                  style: themeOfContext.textTheme.labelMedium
                                      ?.copyWith(
                                    color: GinaAppTheme.lightOutline,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Gap(10),
                                Text(
                                  'End Date: ',
                                  style: themeOfContext.textTheme.labelMedium
                                      ?.copyWith(
                                    color: GinaAppTheme.lightOutline,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(65),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  approvedDoctorDetails.residencyProgram,
                                  style: themeOfContext.textTheme.labelMedium
                                      ?.copyWith(
                                    color: GinaAppTheme.lightOnSecondary,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const Gap(24),
                                Text(
                                  approvedDoctorDetails
                                      .residencyProgramStartDate,
                                  style: themeOfContext.textTheme.labelMedium
                                      ?.copyWith(
                                    color: GinaAppTheme.lightOnSecondary,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const Gap(10),
                                Text(
                                  approvedDoctorDetails
                                      .residencyProgramGraduationYear,
                                  style: themeOfContext.textTheme.labelMedium
                                      ?.copyWith(
                                    color: GinaAppTheme.lightOnSecondary,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Gap(15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: const Padding(
                              padding: EdgeInsets.only(right: 55.0),
                              child: Divider(
                                color: GinaAppTheme.lightOutline,
                                thickness: 0.3,
                              ),
                            ),
                          ),
                        ),
                        const Gap(10),
                        Text(
                          'Fellowship',
                          style: themeOfContext.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(10),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name of the Medical\nSchool Attended: ',
                                  style: themeOfContext.textTheme.labelMedium
                                      ?.copyWith(
                                    color: GinaAppTheme.lightOutline,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Gap(10),
                                Text(
                                  'Start Date: ',
                                  style: themeOfContext.textTheme.labelMedium
                                      ?.copyWith(
                                    color: GinaAppTheme.lightOutline,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Gap(10),
                                Text(
                                  'End Date: ',
                                  style: themeOfContext.textTheme.labelMedium
                                      ?.copyWith(
                                    color: GinaAppTheme.lightOutline,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(65),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  approvedDoctorDetails.fellowShipProgram,
                                  style: themeOfContext.textTheme.labelMedium
                                      ?.copyWith(
                                    color: GinaAppTheme.lightOnSecondary,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const Gap(24),
                                Text(
                                  approvedDoctorDetails
                                      .fellowShipProgramStartDate,
                                  style: themeOfContext.textTheme.labelMedium
                                      ?.copyWith(
                                    color: GinaAppTheme.lightOnSecondary,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const Gap(10),
                                Text(
                                  approvedDoctorDetails
                                      .fellowShipProgramEndDate,
                                  style: themeOfContext.textTheme.labelMedium
                                      ?.copyWith(
                                    color: GinaAppTheme.lightOnSecondary,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: const Divider(
                    color: GinaAppTheme.lightOutline,
                    thickness: 0.3,
                  ),
                ),
              ),
              const Gap(15),
              Padding(
                padding: const EdgeInsets.only(left: 60.0),
                child: Text(
                  'Submitted Requirements',
                  style: themeOfContext.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Gap(20),
              Container(
                height: MediaQuery.of(context).size.height * 0.035,
                width: double.infinity,
                color: const Color(0xffFFE7EB),
                child: Row(
                  children: [
                    const Gap(20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.09,
                      child: Text(
                        'FULL NAME',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                    const Gap(90),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.08,
                      child: Text(
                        'EMAIL ADDRESS',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                    const Gap(90),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        'MEDICAL LICENSE NUMBER',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                    const Gap(90),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        'MEDICAL LICENSE DOCUMENT',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                    const Gap(90),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.08,
                      child: Text(
                        'SUBMISSION DATE',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                    const Gap(80),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        'VERIFICATION STATUS',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(10),

              doctorVerification.isEmpty
                  ? const Center(
                      child: Text(
                        'No verification submitted yet',
                        style: TextStyle(
                          color: GinaAppTheme.lightOutline,
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const Divider(
                          color: GinaAppTheme.lightScrim,
                          thickness: 0.2,
                          height: 8,
                        ),
                        itemCount: doctorVerification.length,
                        itemBuilder: (context, index) {
                          final verification = doctorVerification[index];
                          return InkWell(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Gap(10),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  child: Text(
                                    'Dr. ${approvedDoctorDetails.name}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                const Gap(60),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.09,
                                  child: Text(
                                    approvedDoctorDetails.email,
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                                const Gap(130),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.09,
                                  child: Text(
                                    approvedDoctorDetails.medicalLicenseNumber,
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                                const Gap(100),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.6,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color:
                                                  GinaAppTheme.appbarColorLight,
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  verification
                                                      .medicalLicenseImage,
                                                ),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.09,
                                    child: Text(
                                        verification.medicalLicenseImageTitle,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                              color:
                                                  GinaAppTheme.lightSecondary,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor:
                                                  GinaAppTheme.lightSecondary,
                                            )),
                                  ),
                                ),
                                const Gap(100),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.075,
                                  child: Text(
                                    DateFormat('MM/dd/yyyy').format(
                                        verification.dateSubmitted.toDate()),
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                                const Gap(100),
                                DoctorVerificationStatusChip(
                                  verificationStatus:
                                      verification.verificationStatus,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
              // TODO: ADMIN CHANGES
              Padding(
                padding: const EdgeInsets.only(left: 60.0),
                child: Text(
                  'Appointments History (${appointments.length.toString()})',
                  style: themeOfContext.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Gap(20),
              Container(
                height: MediaQuery.of(context).size.height * 0.035,
                width: double.infinity,
                color: const Color(0xffFFE7EB),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Gap(20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.09,
                      child: Text(
                        'APPOINTMENT ID',
                        style: themeOfContext.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Gap(110),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.08,
                      child: Text(
                        'PATIENT NAME',
                        style: themeOfContext.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Gap(120),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.12,
                      child: Text(
                        'DATE & TIME OF CONSULTATION',
                        style: themeOfContext.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Gap(95),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.08,
                      child: Text(
                        'CLINIC ADDRESS',
                        style: themeOfContext.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Gap(105),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.08,
                      child: Text(
                        'MODE OF APPOINTMENT',
                        style: themeOfContext.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Gap(120),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.03,
                      child: Text(
                        'STATUS',
                        style: themeOfContext.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    color: GinaAppTheme.lightScrim,
                    thickness: 0.2,
                    height: 8,
                  ),
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    final appointment = appointments[index];
                    return InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: const VerticalDivider(
                              color: GinaAppTheme.appbarColorLight,
                              thickness: 3,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Text(
                              appointment.appointmentUid!,
                              style: themeOfContext.textTheme.labelMedium
                                  ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Gap(100),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.09,
                            child: Text(
                              appointment.patientName!,
                              style: themeOfContext.textTheme.labelMedium
                                  ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Gap(100),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.12,
                            // TODO THIS LINE
                            child: Text(
                              '${DateFormat('MM/dd/yyyy').format(DateFormat('MMMM d, yyyy').parse(appointment.appointmentDate!))} @ ${appointment.appointmentTime!}',
                              style: themeOfContext.textTheme.labelMedium,
                            ),
                          ),
                          const Gap(100),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Text(
                              appointment.doctorClinicAddress!,
                              style: themeOfContext.textTheme.labelMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Gap(120),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.08,
                            child: Text(
                              appointment.modeOfAppointment == 0
                                  ? 'Online'
                                  : 'Face-to-Face',
                              style: themeOfContext.textTheme.labelMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Gap(45),
                          AdminPatientAppointmentStatus(
                            themeOfContext: themeOfContext,
                            appointmentStatus: appointment.appointmentStatus,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
