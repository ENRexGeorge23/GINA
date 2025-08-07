
import 'package:first_app/core/resources/images.dart';

import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/gina_patient_app_bar/gina_patient_app_bar.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/patient_features/appointment/2_views/bloc/appointment_bloc.dart';
import 'package:first_app/features/patient_features/appointment/2_views/widgets/prescription_images_list.dart';
import 'package:first_app/features/patient_features/appointment/2_views/widgets/upload_successfully_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class UploadPrescripionStateScreen extends StatelessWidget {
  const UploadPrescripionStateScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final appointmentBloc = context.read<AppointmentBloc>();
    return Scaffold(
      appBar: GinaPatientAppBar(title: 'Upload Prescription'),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Please select the prescription(s) to be uploaded',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: GinaAppTheme.lightOutline,
                    ),
              ),
              const Gap(20),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      Images.doctorVerificatonBorder,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      appointmentBloc.prescriptionImages.clear();
                      appointmentBloc.imageTitles.clear();

                      appointmentBloc.add(
                        ChooseImageEvent(),
                      );
                    },
                    child: Image.asset(
                      Images.doctorImportButton,
                    ),
                  ),
                ),
              ),
              const Gap(20),
              BlocConsumer<AppointmentBloc, AppointmentState>(
                listenWhen: (previous, current) =>
                    current is AppointmentActionState,
                buildWhen: (previous, current) =>
                    current is! AppointmentActionState,
                listener: (context, state) {
                  if (state is PrescriptionUploadedSuccessfully) {
                    showUploadSuccessDialog(context)
                        .then((value) => Navigator.pop(context));
                  } else if (state is UploadingPrescriptionInFirebase) {
                    showDialog(
                      barrierColor: Colors.black.withOpacity(0.1),
                      context: context,
                      builder: (BuildContext context) {
                        return Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: GinaAppTheme.appbarColorLight,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 200,
                            width: 200,
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CircularProgressIndicator(),
                                const Gap(30),
                                Text(
                                  'Uploading Prescription...',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ).then((value) {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/appointment');
                    });
                  }
                },
                builder: (context, state) {
                  if (state is UploadPrescriptionState) {
                    final prescriptionImage = state.prescriptionImage;
                    final imageTitle = state.imageTitle;

                    return prescriptionImage.isEmpty
                        ? const SizedBox()
                        : PrescriptionImagesList(
                            prescriptionImage: prescriptionImage,
                            imageTitle: imageTitle,
                            appointmentBloc: appointmentBloc);
                  } else if (state is UploadPrescriptionLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
