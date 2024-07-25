<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# Background Location Tracker with Foreground Notification

This Flutter package provides a simple and efficient solution for tracking background location with foreground notifications. It allows you to track a user’s location even when the app is not in the foreground and keeps users informed with persistent notifications.

## Features

- **Background Location Tracking:** Track the user's location in the background.
- **Foreground Notifications:** Notify users about ongoing location tracking with customizable notifications.
- **Customizable:** Adjust notification settings to fit your app’s design.

## Getting Started

To use this package, add it to your `pubspec.yaml` file:




## Usage
Here’s a basic example of how to use the package:

import 'package:background_location/background_location.dart';

// Start location tracking
BackgroundLocation.startLocationService();

// Stop location tracking
BackgroundLocation.stopLocationService();


For more detailed examples, refer to the /example folder.


## yaml
geo_background ^0.0.1


## Additional Information
For more details, see the documentation.

If you encounter any issues or have questions, please file an issue on the GitHub repository.

Contributions are welcome! Please refer to our contributing guidelines for more information on how to contribute.

The package is licensed under the MIT License. See the LICENSE file for more details.
Author: Prasanth P


