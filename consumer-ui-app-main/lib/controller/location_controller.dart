// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'base_controller.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationController extends GetxController with BaseController {
  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future getCountry() async {
    return "India";
    final response = await http.get(Uri.parse('https://ipwho.is/'));
    print("location status code${response.statusCode}");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['country'];
    } else {
      return '';
    }
    // Check if location services are enabled
    // bool serviceEnabled;
    // LocationPermission permission;

    // // Check if location services are enabled
    // serviceEnabled = await Geolocator.isLocationServiceEnabled();

    // if (!serviceEnabled) {
    //   // Location services are not enabled, request to enable them
    //   serviceEnabled = await Geolocator.openLocationSettings();
    //   if (!serviceEnabled) {
    //     // User declined to enable location services, handle accordingly
    //     return;
    //   }
    // }

    // // Check for location permission
    // permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   // Request location permission
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     // User denied location permission, handle accordingly
    //     return;
    //   }
    // }

    // if (permission == LocationPermission.deniedForever) {
    //   // Permissions are denied forever, handle accordingly
    //   return;
    // }

    // Get the current position
    // Position position = await Geolocator.getCurrentPosition(
    //   desiredAccuracy: LocationAccuracy.high,
    // );
    // var locationName =
    //     await getLocationName(position.latitude, position.longitude);
    // return locationName != null ? locationName.toString() : '';
  }

  Future<String?> getLocationName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark firstPlacemark = placemarks.first;
        return firstPlacemark.country ?? '';
      }
    } catch (e) {
      print("Error getting location name: $e");
    }
    return null;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
