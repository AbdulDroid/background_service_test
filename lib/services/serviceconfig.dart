import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import '../services/createnewbornservice.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    iosConfiguration: IosConfiguration(
      onBackground: onIosBackground,
      onForeground: onStart,
      autoStart: false,
    ),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: false,
      autoStart: false,
    ),
  );
}

void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  service.on("stopService").listen((e) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(minutes: 20), (timer) async {
      await createNewborn();
  });
}

Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  await createNewborn();
  return true;
}
