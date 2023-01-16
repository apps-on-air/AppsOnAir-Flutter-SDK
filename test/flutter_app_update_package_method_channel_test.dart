// import 'package:flutter/services.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_app_update_package/flutter_app_update_package_method_channel.dart';

// void main() {
//   MethodChannelFlutterAppUpdatePackage platform =
//       MethodChannelFlutterAppUpdatePackage();
//   const MethodChannel channel = MethodChannel('flutter_app_update_package');

//   TestWidgetsFlutterBinding.ensureInitialized();

//   setUp(() {
//     channel.setMockMethodCallHandler((MethodCall methodCall) async {
//       return '42';
//     });
//   });

//   tearDown(() {
//     channel.setMockMethodCallHandler(null);
//   });

//   test('getPlatformVersion', () async {
//     // expect(await platform.initMethod(), '42');
//   });
// }
