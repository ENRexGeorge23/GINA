import 'package:first_app/core/theme/theme_service.dart';
import 'package:flutter/material.dart';

Future<dynamic> postedConfirmationDialog(BuildContext context, String content) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: GinaAppTheme.appbarColorLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      icon: const Icon(
        Icons.check_circle_rounded,
        color: Colors.green,
        size: 80,
      ),
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
    ),
  );
}
