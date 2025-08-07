import 'package:first_app/core/reusable_widgets/doctor_reusable_widgets/gina_doctor_app_bar.dart';
import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/doctor_features/doctorConsultationFee/2_views/bloc/doctor_consultation_fee_bloc.dart';
import 'package:first_app/features/doctor_features/doctorConsultationFee/2_views/view_states/doctor_consultation_fee_screen_loaded.dart';
import 'package:first_app/features/doctor_features/doctorConsultationFee/2_views/view_states/edit_doctor_consultation_fee_screen_loaded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorConsultationFeeScreenProvider extends StatelessWidget {
  const DoctorConsultationFeeScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DoctorConsultationFeeBloc>(
      create: (context) {
        final profileBloc = sl<DoctorConsultationFeeBloc>();
        profileBloc.add(GetDocotorConsultationFeeEvent());
        return profileBloc;
      },
      child: const DoctorConsultationFeeScreen(),
    );
  }
}

class DoctorConsultationFeeScreen extends StatelessWidget {
  const DoctorConsultationFeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorConsultationFeeBloc, DoctorConsultationFeeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: GinaDoctorAppBar(
            leading: state is NavigateToEditDoctorConsultationFeeState
                ? IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      context
                          .read<DoctorConsultationFeeBloc>()
                          .add(GetDocotorConsultationFeeEvent());
                    },
                  )
                : null,
            title: state is NavigateToEditDoctorConsultationFeeState
                ? 'Edit Consultation Fee'
                : 'Consultation Fee',
          ),
          body: BlocConsumer<DoctorConsultationFeeBloc,
              DoctorConsultationFeeState>(
            listenWhen: (previous, current) =>
                current is DoctorConsultationFeeActionState,
            buildWhen: (previous, current) =>
                current is! DoctorConsultationFeeActionState,
            listener: (context, state) {
              // if (state is DoctorProfileNavigateToMyForumsPostState) {
              //   Navigator.pushNamed(context, '/doctorMyForumPosts')
              //       .then((value) => profileBloc.add(GetDoctorProfileEvent()));
              // }
            },
            builder: (context, state) {
              if (state is DoctorConsultationFeeLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DoctorConsultationFeeLoadedState) {
                final doctorData = state.doctor;
                return DoctorConsultationFeeScreenLoaded(
                  doctorData: doctorData,
                );
              } else if (state is DoctorConsultationFeeErrorState) {
                return Center(child: Text(state.message));
              } else if (state is NavigateToEditDoctorConsultationFeeState) {
                final doctorData = state.doctorData;
                return EditDoctorConsultationFeeScreenLoaded(
                  doctorData: doctorData,
                );
              }
              return const SizedBox();
            },
          ),
        );
      },
    );
  }
}
