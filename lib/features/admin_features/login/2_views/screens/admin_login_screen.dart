import 'package:first_app/core/storage/sharedPreferences/shared_preferences_manager.dart';
import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/admin_features/login/2_views/bloc/admin_login_bloc.dart';
import 'package:first_app/features/admin_features/login/2_views/screens/view_states/admin_login_initial_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminLoginScreenProvider extends StatelessWidget {
  const AdminLoginScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdminLoginBloc>(
      create: (context) => sl<AdminLoginBloc>(),
      child: const AdminLoginScreen(),
    );
  }
}

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sharedPreferencesManager = sl<SharedPreferencesManager>();
    return Scaffold(
        body: BlocConsumer<AdminLoginBloc, AdminLoginState>(
      listenWhen: (previous, current) => current is AdminLoginActionState,
      buildWhen: (previous, current) => current is! AdminLoginActionState,
      listener: (context, state) async {
        if (state is AdminLoginSuccessState) {
          debugPrint('AdminLoginSuccessState');
          Navigator.pushReplacementNamed(context, '/adminNavigationDrawer');
          await sharedPreferencesManager.setAdminIsLoggedIn(true);
        } else if (state is AdminLoginFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is AdminLoginInitial) {
          return const AdminLoginInitialState();
        }
        return const AdminLoginInitialState();
      },
    ));
  }
}
