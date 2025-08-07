import 'package:first_app/core/theme/theme_service.dart';
import 'package:flutter/material.dart';

class DoctorCreatePostTextFields extends StatelessWidget {
  final TextEditingController textFieldController;
  final String contentTitle;
  final int maxLines;

  const DoctorCreatePostTextFields({
    super.key,
    required this.textFieldController,
    required this.contentTitle,
    required this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contentTitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: GinaAppTheme.lightOutline,
                  ),
            ),
            TextField(
              controller: textFieldController,
              maxLines: maxLines,
              style: Theme.of(context).textTheme.bodyLarge,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.multiline,
              enableSuggestions: false,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
