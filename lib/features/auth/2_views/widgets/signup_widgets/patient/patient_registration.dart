import 'package:first_app/features/auth/2_views/widgets/patient_sign_up_button.dart';
import 'package:first_app/features/auth/2_views/widgets/validators_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class PatientRegistration extends StatefulWidget {
  const PatientRegistration({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PatientRegistrationState createState() => _PatientRegistrationState();
}

class _PatientRegistrationState extends State<PatientRegistration> {
  final patientRegistrationFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String? selectedGender;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: patientRegistrationFormKey,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _styledFormField('Name', nameController, false),
              const Gap(15),
              _styledFormField('Email Address', emailController, false),
              const Gap(15),
              _styledFormField('Password', passwordController, obscurePassword,
                  togglePasswordVisibility: _togglePasswordVisibility),
              const Gap(15),
              _styledFormField(
                'Confirm Password',
                confirmPasswordController,
                obscureConfirmPassword,
                togglePasswordVisibility: _toggleConfirmPasswordVisibility,
              ),
              passwordMatchValidator(
                passwordController.text,
                confirmPasswordController.text,
              ),
              const Gap(15),
              _styledFormField(
                'Date of Birth',
                dobController,
                false,
                icon: Icons.calendar_today,
                onTap: () => _selectDate(context),
                readOnly: true,
              ),
              const Gap(15),
              _styledGenderDropdown('Gender'),
              const Gap(15),
              _styledFormField('Address', addressController, false),
              const Gap(30),
              SignUpButton(
                patientRegistrationFormKey: patientRegistrationFormKey,
                nameController: nameController,
                emailController: emailController,
                passwordController: passwordController,
                dobController: dobController,
                selectedGender: selectedGender,
                addressController: addressController,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    dobController.dispose();
    super.dispose();
  }

  Widget _styledFormField(
    String hintText,
    TextEditingController controller,
    bool obscureText, {
    Function()? togglePasswordVisibility,
    IconData? icon,
    Function()? onTap,
    bool readOnly = false,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.28,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $hintText';
              }
              return null;
            },
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              hintText: readOnly ? hintText : null,
              labelText: !readOnly ? hintText : null,
              labelStyle: const TextStyle(
                fontSize: 14,
                fontFamily: 'SF UI Display',
                fontWeight: FontWeight.w500,
                color: Color(0xFF9493A0),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              suffixIcon: icon != null
                  ? IconButton(
                      icon: Icon(icon),
                      onPressed: onTap,
                    )
                  : null,
            ),
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'SF UI Display',
              fontWeight: FontWeight.w500,
              color: Color(0xFF36344E),
            ),
            readOnly: readOnly,
            onTap: onTap, // Invoke the onTap function if provided
          ),
          if (togglePasswordVisibility != null)
            IconButton(
              icon: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: togglePasswordVisibility,
            ),
        ],
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        // Use DateFormat to format the date as "May 23, 2000"
        dobController.text = DateFormat('MMMM d, y').format(picked);
      });
    }
  }

  Widget _styledGenderDropdown(String hintText) {
    final genderOptions = ['Male', 'Female', 'Non-Binary', 'Prefer not to say'];

    return Container(
      width: MediaQuery.of(context).size.width / 1.28,
      height: 49,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFF979797)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        underline: const SizedBox.shrink(),
        hint: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            hintText,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'SF UI Display',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        value: selectedGender,
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              selectedGender = newValue;
            });
          }
        },
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.grey,
        ),
        items: genderOptions.map((gender) {
          return DropdownMenuItem<String>(
            value: gender,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                gender,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'SF UI Display',
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF36344E),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }

  void _togglePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      obscureConfirmPassword = !obscureConfirmPassword;
    });
  }
}
