import 'package:appsonair_flutter_sdk/apps_on_air_service.dart';
import 'package:flutter/material.dart';

void main() async {
  AppsOnAir.initialize('*********-e640-477c-aa48-***********');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const DemoAppp(),
      ),
    );
  }
}

class DemoAppp extends StatefulWidget {
  const DemoAppp({super.key});

  @override
  State<DemoAppp> createState() => _DemoApppState();
}

class _DemoApppState extends State<DemoAppp> {
  @override
  void initState() {
    AppsOnAir.checkUpdateAvailable(
      context,
      showNativeUI: false,

      ///use customWidget only if you want to use Your custom ui,
      ///make sure to pass false in param [showNativeUI]
      customWidget: (response) {
        return Column(children: [
          Text("Application Name : ${response["appName"]}"),
          Text(
            "Application Version : ${response["updateData"]["androidBuildNumber"]}",
          ),
          MaterialButton(
            onPressed: () {},
          )
        ]);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
