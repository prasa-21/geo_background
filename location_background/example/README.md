Background Location Tracker with Foreground Notification

This Flutter package provides a simple and effective solution for tracking background location with foreground notifications. It allows you to monitor a user's location even when the app is not in the foreground, ensuring continuous updates and user awareness.


Features
1.Background Location Tracking: Continuously monitor the user's location while the app is in the background.
2.Foreground Notifications: Keeps users informed with persistent notifications about ongoing location tracking.
3.Easy to Use: Simple setup with a straightforward API for integration into your Flutter app.
4.Customizable Notifications: Configure notifications to match your app’s needs.

Getting Started
Installation
Add the package to your pubspec.yaml file:
dependencies:
Geo_Background: ^0.0.1

Setup
Configure your app to request the necessary location permissions.
Set up your app for background location tracking and notifications.


Usage
Import the package and use the provided API to start and stop location tracking:

import 'package:background_location/background_location.dart';

// Start tracking
BackgroundLocation.startLocationService();

// Stop tracking
BackgroundLocation.stopLocationService();


Example
A basic example of using the package:

import 'package:background_location/background_location.dart';

void main() {
// Start location tracking
BackgroundLocation.startLocationService();

// Stop location tracking
BackgroundLocation.stopLocationService();
}


License
This package is licensed under the MIT License. See the LICENSE file for more details.
