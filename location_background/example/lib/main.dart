import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'TrackingProvider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  requestPermission();
  runApp(
    ChangeNotifierProvider(
      create: (_) => TrackingProvider(),
      child: const MyApp(),
    ),
  );
}


Future<void> requestPermission() async {
  var status = await Permission.location.status;
  if (status.isDenied) {
    await Permission.location.request();
  }
  if (await Permission.location.isGranted) {
    var backgroundStatus = await Permission.locationAlways.status;
    if (backgroundStatus.isDenied) {
      await Permission.locationAlways.request();
    }
  }

  var batteryOptimizationStatus =
  await Permission.ignoreBatteryOptimizations.status;
  if (batteryOptimizationStatus.isDenied) {
    await Permission.ignoreBatteryOptimizations.request();
  }

  var notificationStatus = await Permission.notification.status;
  if (notificationStatus.isDenied) {
    await Permission.notification.request();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TrackingProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(),
      ),
    );
  }
}


class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Notify BG',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.blueGrey.shade100,
      ),
      body: Consumer<TrackingProvider>(
        builder: (context, trackingProvider, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Distance: ${trackingProvider.distance.toStringAsFixed(2)} km',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  'Speed: ${trackingProvider.speed.toStringAsFixed(2)} km/h',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: trackingProvider.isTracking
                      ? trackingProvider.stopTracking
                      : trackingProvider.startTracking,
                  child: Text(
                    trackingProvider.isTracking ? 'Stop Tracking' : 'Start Tracking',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey, // Background color
                  ),
                ),


              ],
            ),
          );
        },
      ),
    );
  }
}