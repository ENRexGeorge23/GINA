import 'package:flutter/material.dart';

Widget styledFormField(
  BuildContext context,
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
