import 'package:first_app/core/theme/theme_service.dart';
import 'package:flutter/material.dart';

class EditProfileTextField extends StatelessWidget {
  const EditProfileTextField({
    super.key,
    required this.textController,
    required this.ginaTheme,
    required this.labelText,
    required this.readOnly,
  });

  final TextEditingController textController;
  final ThemeData ginaTheme;
  final String labelText;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly,
      controller: textController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        labelText: readOnly ? "$labelText (Can't be edited)" : labelText,
        labelStyle: ginaTheme.textTheme.bodyLarge
            ?.copyWith(color: GinaAppTheme.lightOutline),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: GinaAppTheme.lightOutline,
            width: 1,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: GinaAppTheme.lightOutline,
            width: 1,
          ),
        ),
      ),
      autocorrect: false,
    );
  }
}
