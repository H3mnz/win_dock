// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';
import 'dart:developer';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart' as win32;

Future<void> launchPath(String path) async {
  final isSuccess = win32.ShellExecute(
    0,
    'open'.toNativeUtf16(),
    path.toNativeUtf16(),
    ''.toNativeUtf16(),
    ''.toNativeUtf16(),
    win32.SW_SHOW,
  );

  if (isSuccess > 32) {
    log("successfully launched");
  } else {
    log("launch failed");
  }
}
