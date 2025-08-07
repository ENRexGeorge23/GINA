import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:first_app/features/patient_features/find/0_models/city_model.dart';
import 'package:first_app/features/patient_features/home/2_views/bloc/home_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geodesy/geodesy.dart' as geo;

class FindController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuthException? error;
  bool working = false;

  Future<Either<Exception, List<DoctorModel>>> getDoctors() async {
    try {
      final doctorSnapshot = await firestore
          .collection('doctors')
          .where('doctorVerificationStatus', isEqualTo: 1)
          .get();

      if (doctorSnapshot.docs.isNotEmpty) {
        final doctorList = doctorSnapshot.docs
            .map((doctor) => DoctorModel.fromJson(doctor.data()))
            .toList();
        return Right(doctorList);
      }
      return const Right([]);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      debugPrint(e.code);
      working = false;
      error = e;
      return Left(Exception(e.message));
    } catch (e) {
      debugPrint(e.toString());
      working = false;
      error = FirebaseAuthException(message: e.toString(), code: 'error');
      return Left(Exception(e.toString()));
    }
  }

  Future<Either<Exception, List<DoctorModel>>> getDoctorsNearMe() async {
    try {
      // 10km radius of the user's current location
      const double maxDistance = 10000;
      final doctorSnapshot = await firestore
          .collection('doctors')
          .where('doctorVerificationStatus', isEqualTo: 1)
          .get();
      if (doctorSnapshot.docs.isNotEmpty) {
        final doctorList = doctorSnapshot.docs
            .map((doctor) {
              final doctorData = doctor.data();
              final geo.LatLng officeLatLng =
                  parseLatLngFromString(doctorData['officeLatLngAddress']);
              doctorData['officeLatLng'] = officeLatLng;

              // Calculate the distance between the doctor's office and the current location
              final distance = geo.Geodesy().distanceBetweenTwoGeoPoints(
                  storePatientCurrentGeoLatLng!, officeLatLng);

              // Check if the distance is within the maximum threshold
              if (distance <= maxDistance) {
                return DoctorModel.fromJson(doctorData);
              } else {
                return null; // Exclude doctor if too far away
              }
            })
            .where((doctor) => doctor != null)
            .toList();
        return Right(doctorList.cast<DoctorModel>());
      } else {
        return const Right([]);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      debugPrint(e.code);
      working = false;
      error = e;
      return Left(Exception(e.message));
    } catch (e) {
      debugPrint(e.toString());
      working = false;
      error = FirebaseAuthException(message: e.toString(), code: 'error');
      return Left(Exception(e.toString()));
    }
  }

  geo.LatLng parseLatLngFromString(String locationString) {
    String cleanedString =
        locationString.replaceAll('LatLng(', '').replaceAll(')', '');
    List<String> values = cleanedString.split(', ');
    double latitude = double.parse(values[0]);
    double longitude = double.parse(values[1]);
    return geo.LatLng(latitude, longitude);
  }

  Future<List<CityModel>> getCitiesInPhilippines() async {
    // Read the JSON file containing city data
    String cityData =
        await rootBundle.loadString('assets/cities_data/city_data.json');

    // Decode the JSON string
    List<dynamic> citiesJson = json.decode(cityData);

    // Convert JSON data to a list of City objects
    List<CityModel> cities = citiesJson.map((cityJson) {
      String cityName = cityJson['name'];
      double latitude = cityJson['latitude'];
      double longitude = cityJson['longitude'];
      geo.LatLng coordinates = geo.LatLng(latitude, longitude);
      return CityModel(name: cityName, coordinates: coordinates);
    }).toList();
    return cities;
  }

  Future<Either<Exception, Map<String, List<DoctorModel>>>>
      getDoctorsInCities() async {
    try {
      final cities = await getCitiesInPhilippines();
      final doctorSnapshot = await firestore
          .collection('doctors')
          .where('doctorVerificationStatus', isEqualTo: 1)
          .get();

      // Initialize an empty map to store the doctors in each city
      final Map<String, List<DoctorModel>> doctorsInCities = {};

      for (final doctor in doctorSnapshot.docs) {
        final doctorData = doctor.data();
        final officeMapsLocationAddress =
            doctorData['officeMapsLocationAddress'];

        // Check if the officeMapsLocationAddress contains the name of any city
        for (final city in cities) {
          if (officeMapsLocationAddress.contains(city.name)) {
            if (doctorsInCities.containsKey(city.name)) {
              doctorsInCities[city.name]!.add(DoctorModel.fromJson(doctorData));
            } else {
              doctorsInCities[city.name] = [DoctorModel.fromJson(doctorData)];
            }
          }
        }
      }

      // Convert the map to a list of entries, sort the list, and convert it back to a map
      final sortedDoctorsInCities = Map.fromEntries(
        doctorsInCities.entries.toList()
          ..sort((a, b) => a.key.compareTo(b.key)),
      );

      return Right(sortedDoctorsInCities);
    } catch (e) {
      debugPrint(e.toString());
      working = false;
      return Left(Exception('Failed to get doctors in cities'));
    }
  }
}
