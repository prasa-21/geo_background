import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import 'background_setup.dart';
import 'main.dart';

class TrackingProvider extends ChangeNotifier {
  bool isTracking = false;
  double speed = 0.0;
  double distance = 0.0;

  final BackgroundServiceManager _backgroundServiceManager = BackgroundServiceManager();

  TrackingProvider() {
    // Listen for data from the background service
    FlutterBackgroundService().on('updateUI').listen((data) {
      if (data != null) {
        double newDistance = double.tryParse(data['distance'] ?? '0') ?? 0;
        double newSpeed = double.tryParse(data['speed'] ?? '0') ?? 0;
        updateData(newSpeed, newDistance);
      }
    });
  }

  void updateData(double newSpeed, double newDistance) {
    speed = newSpeed;
    distance = newDistance;
    notifyListeners();
  }

  void startTracking() {
    isTracking = true;
    notifyListeners();
    requestPermission();
    _backgroundServiceManager.initializeService();
  }

  void stopTracking() {
    isTracking = false;
    notifyListeners();
    _backgroundServiceManager.service.invoke('stopService');
  }

}
