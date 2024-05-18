import 'dart:io';

import 'package:flutter/material.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'app.dart';
import 'app/data/helper/preferences_helper.dart';
import 'app/data/helper/window_helper.dart';
import 'app/shared/utils/enums.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesHelper().init();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  launchAtStartup.setup(
    appName: packageInfo.appName,
    appPath: Platform.resolvedExecutable,
  );
  if (PreferencesHelper().settings().runAtStartUp) {
    await launchAtStartup.enable();
  } else {
    await launchAtStartup.disable();
  }
  final screenPosition = ScreenPosition.values[PreferencesHelper().settings().position];
  await WindowHelper().init(screenPosition: screenPosition);
  runApp(const App());
}
