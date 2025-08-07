import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/auth/2_views/bloc/auth_bloc.dart';
import 'package:first_app/features/auth/2_views/widgets/signup_widgets/doctor/doctor_account_verification/doctor_upload_status.dart';
import 'package:first_app/features/patient_features/forums/2_views/widgets/posted_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DoctorVerificationStatusScreen extends StatelessWidget {
  const DoctorVerificationStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Doctor Verification'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Document Validation',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const Gap(10),
              const Text(
                "Our team will thoroughly review the submitted documents to verify their authenticity and ensure they meet the required criteria. This process typically takes 24 hours. Upon successful verification, you will receive an e-mail confirming your verified status as an Ob-Gyne doctor on the GINA app. You can then use the app.",
                textAlign: TextAlign.justify,
              ),
              const Gap(35),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: GinaAppTheme.appbarColorLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Gap(30),
                    const Icon(
                      Icons.contact_emergency_outlined,
                      color: GinaAppTheme.lightOnSecondary,
                    ),
                    const Gap(20),
                    Text(
                      'Medical License',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const DoctorUploadStatusScreen()));
                      },
                      child: BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is UploadMedicalImageState) {
                            final image = state.medicalImageId;
                            return image.path.isEmpty
                                ? const CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Color(0xffD6D7D8),
                                    child: Icon(
                                      Icons.arrow_forward_rounded,
                                      color: GinaAppTheme.appbarColorLight,
                                      size: 18,
                                    ),
                                  )
                                : const CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.green,
                                    child: Icon(
                                      Icons.check,
                                      color: GinaAppTheme.appbarColorLight,
                                      size: 18,
                                    ),
                                  );
                          }
                          return const CircleAvatar(
                            radius: 15,
                            backgroundColor: Color(0xffD6D7D8),
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              color: GinaAppTheme.appbarColorLight,
                              size: 18,
                            ),
                          );
                        },
                      ),
                    ),
                    const Gap(20),
                  ],
                ),
              ),
              const Gap(35),
              Row(
                children: [
                  const Icon(
                    Icons.info_outline_rounded,
                    color: GinaAppTheme.lightOnSecondary,
                  ),
                  const Gap(5),
                  Text(
                    'Instruction',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
              const Gap(10),
              const Text(
                "• The file must be submitted in the format JPG, JPEG, PNG or PDF, and the file size is limited to 2.5 MB.\n• Select the type of document that you are submitting.\n• Warning: Submitting fake or altered documents will result in account suspension",
                textAlign: TextAlign.justify,
              ),
              const Gap(35),
              const Text(
                "Note: Please ensure the submitted documents are clear, legible, and contain all relevant information. If any documents are found to be incomplete or invalid, you may be requested to resubmit them.",
                textAlign: TextAlign.justify,
              ),
              const Gap(35),
              BlocConsumer<AuthBloc, AuthState>(
                listenWhen: (previous, current) => current is AuthActionState,
                buildWhen: (previous, current) => current is! AuthActionState,
                listener: (context, state) {
                  if (state is UploadMedicalImageSuccessState) {
                    postedConfirmationDialog(
                            context, 'Submitted for verification')
                        .then((value) =>
                            Navigator.pushReplacementNamed(context, '/login'));
                  } else if (state is UploadMedicalImageFailureState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Failed to Submit Medical License'),
                        backgroundColor: GinaAppTheme.lightError,
                      ),
                    );
                  } else if (state is SubmittingVerificationLoadingState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Submitting Your Medical License'),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is UploadMedicalImageState) {
                    final image = state.medicalImageId;
                    final title = state.medicalImageIdTitle;
                    return image.path.isEmpty
                        ? const SizedBox()
                        : SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: FilledButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                authBloc.add(
                                    SubmitDoctorMedicalVerificationEvent(
                                        doctorUid: registeredDoctorUid!,
                                        medicalLicenseImage: image,
                                        medicalLicenseImageTitle:
                                            title.path.split('/').last));
                              },
                              child: Text(
                                'Submit',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ));
  }
}
