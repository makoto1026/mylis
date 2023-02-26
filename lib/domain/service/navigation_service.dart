import 'package:flutter/material.dart';

class NavigationService {
  factory NavigationService() {
    return _instance;
  }

  NavigationService._internal();

  static final NavigationService _instance = NavigationService._internal();

  static final _navigatorKey = GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  static String get currentRouteName {
    var currentRouteName = "";
    Navigator.popUntil(NavigationService.navigatorKey.currentContext!, (route) {
      currentRouteName = route.settings.name ?? "";
      return true;
    });
    return currentRouteName;
  }

  static Future<T?> push<T>(Route<T> route) {
    return navigatorKey.currentState!.push<T>(route);
  }
}
