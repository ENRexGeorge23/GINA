import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/admin_features/adminDoctorList/2_views/bloc/admin_doctor_list_bloc.dart';
import 'package:first_app/features/admin_features/adminDoctorList/2_views/screens/view_states/admin_doctor_details_state.dart';
import 'package:first_app/features/admin_features/adminDoctorList/2_views/screens/view_states/admin_doctor_loaded_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminDoctorListScreenProvider extends StatelessWidget {
  const AdminDoctorListScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdminDoctorListBloc>(
      create: (context) {
        final adminDoctorListBloc = sl<AdminDoctorListBloc>();
        adminDoctorListBloc.add(AdminDoctorListGetRequestEvent());
        return adminDoctorListBloc;
      },
      child: const AdminDoctorListScreen(),
    );
  }
}

class AdminDoctorListScreen extends StatelessWidget {
  const AdminDoctorListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        notificationPredicate: (notification) => false,
        automaticallyImplyLeading: false,
        title: const Text(''),
      ),
      body: BlocConsumer<AdminDoctorListBloc, AdminDoctorListState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AdminDoctorListLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AdminDoctorListLoadedState) {
            return AdminDoctorListLoaded(
              approvedDoctorList: state.approvedDoctorList,
            );
          } else if (state is AdminDoctorListErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is AdminDoctorListDoctorDetailsState) {
            return AdminDoctorDetailsState(
              approvedDoctorDetails: state.approvedDoctorDetails,
              doctorVerification: state.doctorVerification, appointments: state.appointmentDetails,
            );
          }
          return Container();
        },
      ),
    );
  }
}