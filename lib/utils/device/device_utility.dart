import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JDeviceUtility {
  // Singleton pattern for easy access throughout the app
  static final JDeviceUtility _instance = JDeviceUtility._internal();
  factory JDeviceUtility() => _instance;
  JDeviceUtility._internal();

  /// Gets the screen width of the device
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Gets the screen height of the device
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Gets the screen orientation (Portrait or Landscape)
  static Orientation orientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  /// Checks if the device is in portrait mode
  static bool isPortrait(BuildContext context) {
    return orientation(context) == Orientation.portrait;
  }

  /// Checks if the device is in landscape mode
  static bool isLandscape(BuildContext context) {
    return orientation(context) == Orientation.landscape;
  }

  /// Gets the platform type (iOS or Android)
  static String platformType() {
    if (Platform.isAndroid) return 'Android';
    if (Platform.isIOS) return 'iOS';
    return 'Unknown';
  }

  /// Checks if the current platform is Android
  static bool isAndroid() {
    return Platform.isAndroid;
  }

  /// Checks if the current platform is iOS
  static bool isIOS() {
    return Platform.isIOS;
  }

  /// Returns the device pixel ratio
  static double devicePixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  /// Returns the text scale factor
  static double textScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor;
  }

  /// Returns whether the current device is a tablet
  static bool isTablet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final diagonal = sqrt(size.width * size.width + size.height * size.height);
    return diagonal > 1100.0; // Adjust threshold as needed
  }

  /// Checks if the keyboard is visible
  static bool isKeyboardVisible(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  /// Gets the height of the keyboard if visible
  static double keyboardHeight(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom;
  }

  /// Checks if the device is a physical device (not an emulator)
  // static Future<bool> isPhysicalDevice() async {
  //   try {
  //     return await Platform.ios;
  //   } catch (e) {
  //     return false; // Return false if the platform doesn't support this property
  //   }
  // }

  /// Vibrates the device (requires Vibration package in `pubspec.yaml`)
  static Future<void> vibrate(
      {Duration duration = const Duration(milliseconds: 100)}) async {
    try {
      await HapticFeedback.vibrate();
      await Future.delayed(duration);
      await HapticFeedback.vibrate();
    } catch (e) {
      debugPrint("Vibration not supported on this device.");
    }
  }

  /// Gets the height of the bottom navigation bar
  static double bottomNavigationBarHeight(BuildContext context) {
    return kBottomNavigationBarHeight;
  }

  /// Gets the height of the status bar
  static double statusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  /// Gets the combined height of the status bar and bottom navigation bar (appear height)
  static double getAppBarHeight() {
    return kToolbarHeight;
  }
}
