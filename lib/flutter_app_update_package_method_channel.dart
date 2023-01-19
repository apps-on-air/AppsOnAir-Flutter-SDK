import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'flutter_app_update_package_platform_interface.dart';

/// An implementation of [FlutterAppUpdatePackagePlatform] that uses method channels.
class MethodChannelFlutterAppUpdatePackage
    extends FlutterAppUpdatePackagePlatform {
  /// The method channel used to interact with the native platform.
  late BuildContext context;
  @visibleForTesting
  final methodChannel = const MethodChannel('updateCheck/isUpdateAvailable');

  ///[context] is required to show dialog
  ///[isShowNative] is used to show [customWidget]
  ///[isShowNative] turn it off if you want to show your [customWidget]
  /// you can show your [customWidget] ui
  @override
  Future<Map<String, dynamic>> initMethod(
    BuildContext context, {
    required String appId,
    bool showNativeUI = true,
    Widget Function(Map<String, dynamic> response)? customWidget,
  }) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      this.context = context;
      final result = await methodChannel.invokeMethod(
          'setApplicationID', {"AppId": appId, "isShowNative": showNativeUI});
      if (result) {
        final appUpdateResponse = await _check();
        if (customWidget != null) {
          final widget = customWidget.call(appUpdateResponse);

          ///custom ui dialog
          _alertDialog(widget);
        }
      }
    });

    return {};
  }

  void _alertDialog(Widget widget) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: widget,
        );
      },
    );
  }

  Future<Map<String, dynamic>> _check() async {
    String updateCheck = '';
    try {
      final result = await methodChannel.invokeMethod(
        'isUpdateAvailable',
      );
      if (result != null && result is String) {
        return Map<String, dynamic>.from(json.decode(result));
      }
      return Map<String, dynamic>.from(((result ?? {}) as Map));
    } on PlatformException catch (e) {
      updateCheck = "Failed to check for update: '${e.message}'.";
    }
    if (kDebugMode) {
      print(updateCheck);
    }
    return {"exception": updateCheck};
  }
}
