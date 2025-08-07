import 'package:first_app/core/enum/enum.dart';
import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:first_app/features/doctor_features/doctorConsultationFee/2_views/bloc/doctor_consultation_fee_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class EditDoctorConsultationFeeScreenLoaded extends StatelessWidget {
  final DoctorModel doctorData;
  const EditDoctorConsultationFeeScreenLoaded({
    super.key,
    required this.doctorData,
  });

  @override
  Widget build(BuildContext context) {
    final ginaTheme = Theme.of(context);
    final doctorUpdateConsultationBloc =
        context.read<DoctorConsultationFeeBloc>();
    final TextEditingController f2fInitialConsultationPriceController =
        TextEditingController(
            text: doctorData.f2fInitialConsultationPrice != null
                ? doctorData.f2fInitialConsultationPrice.toString()
                : "0.00");
    final TextEditingController f2fFollowUpConsultationPriceController =
        TextEditingController(
            text: doctorData.f2fFollowUpConsultationPrice != null
                ? doctorData.f2fFollowUpConsultationPrice.toString()
                : "0.00");
    final TextEditingController olInitialConsultationPriceController =
        TextEditingController(
            text: doctorData.olInitialConsultationPrice != null
                ? doctorData.olInitialConsultationPrice.toString()
                : "0.00");
    final TextEditingController olFollowUpConsultationPriceController =
        TextEditingController(
            text: doctorData.olFollowUpConsultationPrice != null
                ? doctorData.olFollowUpConsultationPrice.toString()
                : "0.00");
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            Images.doctorProfileImagePlaceholder,
                            width: 122,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Gap(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          doctorData.doctorRatingId ==
                                  DoctorRating.newDoctor.index
                              ? Image.asset(
                                  Images.newDoctorBadge,
                                  width: 100,
                                )
                              : Container(),
                          doctorData.doctorRatingId ==
                                  DoctorRating.activeDoctor.index
                              ? Image.asset(
                                  Images.activeDoctorBadge,
                                  width: 100,
                                )
                              : Container(),
                          doctorData.doctorRatingId ==
                                  DoctorRating.contributingDoctor.index
                              ? Image.asset(
                                  Images.contributingDoctorBadge,
                                  width: 100,
                                )
                              : Container(),
                          doctorData.doctorRatingId ==
                                  DoctorRating.topDoctor.index
                              ? Image.asset(
                                  Images.topDoctorBadge,
                                  width: 100,
                                )
                              : Container(),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Dr. ${doctorData.name}",
                            style: const TextStyle(
                              color: GinaAppTheme.lightOnBackground,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: "SF UI Display",
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Gap(5),
                          const Icon(
                            Icons.verified,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                      Text(
                        doctorData.medicalSpecialty,
                        style: const TextStyle(
                          color: GinaAppTheme.lightOutline,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: "SF UI Display",
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        doctorData.officeAdress,
                        style: const TextStyle(
                          color: GinaAppTheme.lightOutline,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: "SF UI Display",
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Face-to-Face Consultation',
                      style: ginaTheme.textTheme.labelLarge?.copyWith(
                        color: GinaAppTheme.lightOnPrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily: 'SF UI Display',
                      )),
                ),
                const Gap(5),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Initial Consultation",
                        style: TextStyle(
                          color: GinaAppTheme.lightOnSecondary,
                          fontFamily: "SF UI Display",
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      TextField(
                        controller: f2fInitialConsultationPriceController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: const InputDecoration(
                          hintText: "Enter price",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const Gap(20),
                      const Divider(
                        thickness: 0.5,
                        color: GinaAppTheme.lightOutline,
                      ),
                      const Gap(20),
                      const Text(
                        "Follow Up Consultation",
                        style: TextStyle(
                          color: GinaAppTheme.lightOnSecondary,
                          fontFamily: "SF UI Display",
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      TextField(
                        controller: f2fFollowUpConsultationPriceController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: const InputDecoration(
                          hintText: "Enter price",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Online Consultation',
                    style: ginaTheme.textTheme.labelLarge?.copyWith(
                      color: GinaAppTheme.lightOnPrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      fontFamily: 'SF UI Display',
                    ),
                  ),
                ),
                const Gap(5),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Initial Consultation",
                        style: TextStyle(
                          color: GinaAppTheme.lightOnSecondary,
                          fontFamily: "SF UI Display",
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      TextField(
                        controller: olInitialConsultationPriceController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: const InputDecoration(
                          hintText: "Enter price",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const Gap(20),
                      const Divider(
                        thickness: 0.5,
                        color: GinaAppTheme.lightOutline,
                      ),
                      const Gap(20),
                      const Text(
                        "Follow Up Consultation",
                        style: TextStyle(
                          color: GinaAppTheme.lightOnSecondary,
                          fontFamily: "SF UI Display",
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      TextField(
                        controller: olFollowUpConsultationPriceController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: const InputDecoration(
                          hintText: "Enter price",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Gap(10),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.9,
            child: FilledButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              onPressed: () {
                doctorUpdateConsultationBloc
                    .add(SaveEditDoctorConsultationFeeEvent(
                  f2fFollowUpConsultationPrice:
                      double.parse(f2fFollowUpConsultationPriceController.text),
                  f2fInitialConsultationPrice:
                      double.parse(f2fInitialConsultationPriceController.text),
                  olFollowUpConsultationPrice:
                      double.parse(olFollowUpConsultationPriceController.text),
                  olInitialConsultationPrice:
                      double.parse(olInitialConsultationPriceController.text),
                ));
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Success'),
                    content:
                        const Text('Consultation Fees updated successfully'),
                    actions: <Widget>[
                      FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Ok'),
                      ),
                    ],
                  ),
                ).then((value) => doctorUpdateConsultationBloc
                    .add(GetDocotorConsultationFeeEvent()));
              },
              child: const Text(
                'Save Consultation Fees',
                style: TextStyle(
                  color: GinaAppTheme.lightOnSecondary,
                  fontFamily: "SF UI Display",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
