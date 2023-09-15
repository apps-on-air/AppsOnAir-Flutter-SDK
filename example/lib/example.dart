import 'package:appsonair_flutter_sdk/apps_on_air_service.dart';
import 'package:flutter/material.dart';

void main() async {
  AppsOnAir.setAppId('*********-e640-477c-aa48-***********',
      showNativeUI: true);
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
   
    AppsOnAir.checkForAppUpdate(
      context,
      ///use customWidget only if you want to use Your custom ui,
      ///make sure to pass false in param [showNativeUI]
      customWidget: 
    
      (response) {
        return
         Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisSize: MainAxisSize.min,
          children: [
         
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text("${response.appName} : need an update "),
          ),
          
            Padding(
           padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
              "To use this app, download the latest version:${response.updateData?.androidBuildNumber}",
                      ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {}, child: const Text("Update"),
              ),
            ],
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
