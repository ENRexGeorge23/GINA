import 'package:first_app/core/theme/theme_service.dart';
import 'package:flutter/material.dart';

Future<dynamic> newDoctorModal(BuildContext context) {
  return showDialog(
    barrierColor: Colors.black.withOpacity(0.1),
    context: context,
    builder: (context) => Dialog(
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          height: 150,
          width: 80,
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: GinaAppTheme.cancelledTextColor.withOpacity(0.1),
                child: const Icon(
                  Icons.star_rounded,
                  color: GinaAppTheme.cancelledTextColor,
                  size: 30,
                ),
              ),
              const Text(
                'New Doctor',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: GinaAppTheme.cancelledTextColor,
                ),
              ),
            ],
          )),
    ),
  );
}
