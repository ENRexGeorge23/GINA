import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/screens/bloc/doctor_appointment_request_screen_loaded_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorAppointmentRequestScreenLoaded extends StatelessWidget {
  const DoctorAppointmentRequestScreenLoaded({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.0),
              color: Colors.white,
            ),
            child: BlocBuilder<DoctorAppointmentRequestScreenLoadedBloc,
                DoctorAppointmentRequestScreenLoadedState>(
              builder: (context, state) {
                return SizedBox(
                  height: 33,
                  child: TabBar(
                    padding: EdgeInsets.zero,
                    dividerColor: Colors.transparent,
                    onTap: (index) {
                      context
                          .read<DoctorAppointmentRequestScreenLoadedBloc>()
                          .add(TabChangedEvent(tab: index));
                    },
                    labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                    unselectedLabelColor: GinaAppTheme.lightOutline,
                    labelStyle: const TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'SF UI Display',
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          30.0), // Adjusted to better fit the active tab
                      color: state.backgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Shadow color
                          spreadRadius: 2, // Spread radius
                          blurRadius: 4, // Blur radius
                          offset: const Offset(0, 2), // Offset
                        ),
                      ],
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: const [
                      Tab(text: 'Pending'),
                      Tab(text: 'Approved'),
                      Tab(text: 'Declined'),
                      Tab(text: 'Cancelled'),
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<DoctorAppointmentRequestScreenLoadedBloc,
                DoctorAppointmentRequestScreenLoadedState>(
              builder: (context, state) {
                return TabBarView(
                  children: [
                    Center(child: state.selectedScreen),
                    Center(child: state.selectedScreen),
                    Center(child: state.selectedScreen),
                    Center(child: state.selectedScreen),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
