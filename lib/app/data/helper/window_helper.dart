import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:window_manager/window_manager.dart';

import '../../shared/utils/enums.dart';

class WindowHelper {
  WindowHelper._();

  static final WindowHelper _windowHelper = WindowHelper._();

  factory WindowHelper() => _windowHelper;

  WindowOptions options = const WindowOptions(
    titleBarStyle: TitleBarStyle.hidden,
    skipTaskbar: true,
  );

  late Size windowSize;

  Future<void> init({ScreenPosition screenPosition = ScreenPosition.right}) async {
    try {
      await windowManager.ensureInitialized();
      await windowManager.waitUntilReadyToShow(options, () => _callback(screenPosition: screenPosition));
    } catch (e) {
      log(e.toString());
    }
  }

  void _callback({ScreenPosition screenPosition = ScreenPosition.right}) async {
    final primaryDisplay = await screenRetriever.getPrimaryDisplay();
    windowSize = primaryDisplay.size;
    final size = Size(120, primaryDisplay.visibleSize?.height ?? windowSize.height);

    await Future.wait(
      [
        windowManager.setSize(size),
        windowManager.setMinimumSize(size),
        windowManager.setMaximumSize(size),
        windowManager.setMaximizable(false),
        windowManager.setMinimizable(false),
        windowManager.setResizable(false),
        windowManager.setBackgroundColor(Colors.transparent),
        windowManager.setAlwaysOnBottom(true),
      ],
    );
    if (screenPosition == ScreenPosition.right) {
      await windowManager.setAlignment(Alignment.centerRight);
    } else {
      await windowManager.setAlignment(Alignment.centerLeft);
    }

    await windowManager.show();
  }
}
