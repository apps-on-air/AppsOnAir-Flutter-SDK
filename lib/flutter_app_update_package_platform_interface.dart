import 'package:flutter/material.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_app_update_package_method_channel.dart';
import 'src/model/app_info_model.dart';

abstract class FlutterAppUpdatePackagePlatform extends PlatformInterface {
  /// Constructs a FlutterAppUpdatePackagePlatform.
  FlutterAppUpdatePackagePlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterAppUpdatePackagePlatform _instance =
      MethodChannelFlutterAppUpdatePackage();

  /// The default instance of [FlutterAppUpdatePackagePlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterAppUpdatePackage].
  static FlutterAppUpdatePackagePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterAppUpdatePackagePlatform] when
  /// they register themselves.
  static set instance(FlutterAppUpdatePackagePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  ///[context] is required to show dialog
  ///
  ///[appId] is required to connect with backend
  ///
  ///[showNativeUI] is used to show [customWidget]
  ///
  ///[showNativeUI] false if you want to show your [cus tomWidget],by default its true
  ///
  Future<void> initMethod(
    BuildContext context, {
    required String appId,
    bool showNativeUI = true,
    Widget? Function(AppInfo)? customWidget,
   
  }) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
