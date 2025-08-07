import 'package:first_app/core/enum/enum.dart';
import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:first_app/features/doctor_features/doctorConsultationFee/2_views/bloc/doctor_consultation_fee_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ToggleValue extends ValueNotifier<bool> {
  ToggleValue(super.value);

  void toggle() {
    value = !value;
  }
}

class DoctorConsultationFeeScreenLoaded extends StatelessWidget {
  final DoctorModel doctorData;
  const DoctorConsultationFeeScreenLoaded({
    super.key,
    required this.doctorData,
  });

  @override
  Widget build(BuildContext context) {
    ToggleValue toggleValue = ToggleValue(doctorData.showConsultationprice!);
    final ginaTheme = Theme.of(context);
    final doctorConsultationBloc = context.read<DoctorConsultationFeeBloc>();
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
          const Gap(10),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Show Pricing",
                  style: TextStyle(
                    color: GinaAppTheme.lightOnPrimaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: "SF UI Display",
                  ),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: toggleValue,
                  builder: (context, value, child) {
                    return Switch(
                      thumbColor: MaterialStateProperty.all<Color>(
                          GinaAppTheme.appbarColorLight),
                      value: value,
                      onChanged: (newValue) {
                        doctorConsultationBloc
                            .add(ToggleDoctorConsultationPriceFeeEvent());
                        toggleValue.toggle();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          const Gap(10),
          ValueListenableBuilder<bool>(
            valueListenable: toggleValue,
            builder: (context, value, child) {
              return value
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Face-to-Face Consultation',
                                    style: ginaTheme.textTheme.labelLarge
                                        ?.copyWith(
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
                                height:
                                    MediaQuery.of(context).size.height * 0.18,
                                width: MediaQuery.of(context).size.width * 0.9,
                                padding: const EdgeInsets.all(30.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Initial Consultation",
                                          style: TextStyle(
                                            color:
                                                GinaAppTheme.lightOnSecondary,
                                            fontFamily: "SF UI Display",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          doctorData.f2fInitialConsultationPrice !=
                                                  null
                                              ? "₱ ${doctorData.f2fInitialConsultationPrice?.toStringAsFixed(2)}"
                                              : "₱ 0.00",
                                          style: const TextStyle(
                                            color:
                                                GinaAppTheme.lightOnSecondary,
                                            fontFamily: "SF UI Display",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Gap(20),
                                    const Divider(
                                      thickness: 0.5,
                                      color: GinaAppTheme.lightOutline,
                                    ),
                                    const Gap(20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Follow Up Consultation",
                                          style: TextStyle(
                                            color:
                                                GinaAppTheme.lightOnSecondary,
                                            fontFamily: "SF UI Display",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          doctorData.f2fFollowUpConsultationPrice !=
                                                  null
                                              ? "₱ ${doctorData.f2fFollowUpConsultationPrice?.toStringAsFixed(2)}"
                                              : "₱ 0.00",
                                          style: const TextStyle(
                                            color:
                                                GinaAppTheme.lightOnSecondary,
                                            fontFamily: "SF UI Display",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
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
                                  style:
                                      ginaTheme.textTheme.labelLarge?.copyWith(
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
                                height:
                                    MediaQuery.of(context).size.height * 0.18,
                                width: MediaQuery.of(context).size.width * 0.9,
                                padding: const EdgeInsets.all(30.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Initial Consultation",
                                          style: TextStyle(
                                            color:
                                                GinaAppTheme.lightOnSecondary,
                                            fontFamily: "SF UI Display",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          doctorData.olInitialConsultationPrice !=
                                                  null
                                              ? "₱ ${doctorData.olInitialConsultationPrice?.toStringAsFixed(2)}"
                                              : "₱ 0.00",
                                          style: const TextStyle(
                                            color:
                                                GinaAppTheme.lightOnSecondary,
                                            fontFamily: "SF UI Display",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Gap(20),
                                    const Divider(
                                      thickness: 0.5,
                                      color: GinaAppTheme.lightOutline,
                                    ),
                                    const Gap(20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Follow Up Consultation",
                                          style: TextStyle(
                                            color:
                                                GinaAppTheme.lightOnSecondary,
                                            fontFamily: "SF UI Display",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          doctorData.olFollowUpConsultationPrice !=
                                                  null
                                              ? "₱ ${doctorData.olFollowUpConsultationPrice?.toStringAsFixed(2)}"
                                              : "₱ 0.00",
                                          style: const TextStyle(
                                            color:
                                                GinaAppTheme.lightOnSecondary,
                                            fontFamily: "SF UI Display",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Image.asset(
                      Images.hideConsultationPricing,
                      width: 500,
                    );
            },
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
                doctorConsultationBloc
                    .add(NavigateToEditDoctorConsultationFeeEvent());
              },
              child: const Text(
                'Edit Consultation Fees',
                style: TextStyle(
                  color: GinaAppTheme.lightOnSecondary,
                  fontFamily: "SF UI Display",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
