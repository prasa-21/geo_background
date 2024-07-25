import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_latlong/flutter_latlong.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';

class BackgroundServiceManager {
  final FlutterBackgroundService service = FlutterBackgroundService();

  Future<void> initializeService() async {
    const notificationChannelId = 'my_foreground';

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      notificationChannelId,
      'Location Tracking Service',
      description: 'This channel is used for location tracking service.',
      importance: Importance.low,
    );

    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    if (Platform.isIOS || Platform.isAndroid) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStartService,
        isForegroundMode: true,
        notificationChannelId: notificationChannelId,
        initialNotificationTitle: 'Location Tracking Service',
        initialNotificationContent: 'Madurai No :1',
        foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStartService,
      ),
    );
    await service.startService();
  }
}

final FlutterBackgroundService service = FlutterBackgroundService();

int waitingTimeSeconds = 0;
Timer? standardTimer;
double distance = 0;
List<LatLng> route = [];
bool manualStopTimer = false;

double waitingFare = 0;
double speed = 0;

@pragma('vm:entry-point')
/// Called when the service starts. Initializes Firebase, fetches fare details, resets trip values, and starts handling standard service operations.
void onStartService(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  handleStartStandardService(service);
}

/// Resets trip-related values like waiting time, distance, route, fare, and speed, then updates the UI.
void resetTripValues(ServiceInstance service) {
  waitingTimeSeconds = 0;
  distance = 0;
  route = [];
  waitingFare = 0;
  speed = 0;
  updateUI(service);
}

void handleStartStandardService(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();


  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  service.on('resetTrip').listen((event) {
    resetTripValues(service);
  });

  const LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.bestForNavigation,
    distanceFilter: 0,
  );

  Position? lastPosition;

  Stream<Position> positionStream = Geolocator.getPositionStream(
    locationSettings: locationSettings,
  );

  positionStream.listen((Position position) {
    speed = position.speed * 3.6;

    if (lastPosition != null) {
      double appendDist = Geolocator.distanceBetween(
        lastPosition!.latitude,
        lastPosition!.longitude,
        position.latitude,
        position.longitude,
      );

      distance += appendDist;
      route.add(LatLng(position.latitude, position.longitude));
    }

    lastPosition = position;
    updateUI(service);
  });
}


void updateUI(ServiceInstance service) async {
  service.invoke('updateUI', {
    'distance': (distance / 1000).toStringAsFixed(1),
    'speed': speed.toStringAsFixed(1),
  });
}
