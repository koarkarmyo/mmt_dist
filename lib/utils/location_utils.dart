import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_android/geolocator_android.dart';
import 'package:geolocator_apple/geolocator_apple.dart';
import 'package:location/location.dart' as loc;

late LocationSettings locationSettings;

class LocationUtils {
  static final LocationUtils _instance = LocationUtils._();
  static loc.LocationData? locationData;

  LocationUtils._();

  factory LocationUtils() {
    return _instance;
  }

  static loc.Location _location = new loc.Location();

  static Future<bool> requestPermission() async {
    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        getCurrentLocation();
      }
    }
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        await _location.requestPermission();
      }
    }
    return _permissionGranted == loc.PermissionStatus.granted;
  }

  static listenLocation() async {
    _location.onLocationChanged.listen((loc.LocationData data) {
      locationData = data;
    });
  }

  static Future<loc.LocationData> getCurrentLocation() async {
    loc.LocationData _locationData;
    bool isGranted = await requestPermission();
    if (!isGranted) {
      getCurrentLocation();
    }

    _location.changeSettings(accuracy: loc.LocationAccuracy.high);

    _locationData = await _location.getLocation();

    if (_locationData.latitude == 0.0 && _locationData.longitude == 0.0) {
      getCurrentLocation();
    }
    return _locationData;
  }

  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    if (Platform.isAndroid) GeolocatorAndroid.registerWith();
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      bool locationOpened = await Geolocator.openLocationSettings();
      if (!locationOpened) {
        bool isOpened = await Geolocator.openLocationSettings();
        if (!isOpened) return Future.error('Location services are disabled.');
      }
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.unableToDetermine) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return await determinePosition();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      bool isOpened = await Geolocator.openAppSettings();
      if (!isOpened) return await determinePosition();
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    //
    final Position? position = await Geolocator.getLastKnownPosition(
        forceAndroidLocationManager: true);
    if (position != null) return position;
    return await Geolocator.getCurrentPosition(
        // desiredAccuracy: LocationAccuracy.medium,
        forceAndroidLocationManager: true);
  }

  static Future<Position> determineCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    if (defaultTargetPlatform == TargetPlatform.android) {
      GeolocatorAndroid.registerWith();
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      GeolocatorApple.registerWith();
    }

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      bool locationOpened = await Geolocator.openLocationSettings();
      if (!locationOpened) {
        bool isOpened = await Geolocator.openLocationSettings();
        if (!isOpened) return Future.error('Location services are disabled.');
      }
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.unableToDetermine) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        final opened = await Geolocator.openAppSettings();
        if (!opened) determineCurrentLocation();
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        // desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true);
    if (position.longitude == 0.0 && position.latitude == 0.0)
      return determineCurrentLocation();
    return position;
  }

  ///
  /// distance return as meter
  static double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)) * 1000;
  }
}
