## [![pub package](https://appsonair.com/images/logo.svg)](https://pub.dev/packages/appsonair_flutter_sdk)

Deploy your builds to testers and clients in real-time before submitting them to the Google or Apple app stores.

To learn more about AppsOnAir, please visit the [AppsOnAir website](https://appsonair.com)

Featured in 
- App update 📤
	 By enabling App Update feature, users will be able to see any new releases published in this app.

- App maintenance mode 🛠️
		By enabling Maintenance mode feature, users won’t be able to access the app and will be noted as the app is under Maintenance mode.


## **Installation**
 
Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  appsonair_flutter_sdk: ^0.2.1
```

```dart
import  'package:appsonair_flutter_sdk/apps_on_air_service.dart';
```

## Integration
- Use this code after initializing [MaterialApp]
- Use this code in initState
- showNativeUI set true, by default its false
- showNativeUI set false only if you want to show customUI,

First initialize AppsOnAir by using below code

```dart
void main() async {
  AppsOnAir.setAppId('*********-e640-477c-aa48-***********',showNativeUI: true); ///appId From https://appsonair.com/
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
```

if you want to use default(native) ui then use this

```dart
    AppsOnAir.checkForAppUpdate(
      context,
    );
```

if you want to use your custom ui then use this, make sure you 
```dart
    AppsOnAir.checkForAppUpdate(
      context,
      customWidget: (response) {
        ///return your widget here
        return Container();
      },
    );
```

  ## Usage
To use this plugin, please visit the [Core usage documentation](https://doc.dev.appsonair.com/Mobile-Quickstart/flutter-sdk-setup)
  

App Update Mode (Android / iOS)

This feature enables you to configure the version update of your app directly through AoA.

In case you want to show the user an app update dialog in Android/iOS, you need to follow these steps:

  

1. Go to the app details page, from the apps dashboard
2. In the app details page, go o the App Services tab and then go to the Update tab
3. Enable Updates in for android and/ or iOS using the toggle and fill up required details
4. Details of the setting:
  i. The default mode would be a soft update wherein the user will be notified of any available update and they can choose to update or skip.

  ii. If you check the Force Update mode, the user will be notified about the available update and they will have to mandatorily install the update.

  iii. Minimum build version: If the app installed having lower version than the minimum build version mentioned in AOA dashboard then user will get dialog for an app update.

  iv. Store Link: If user clicks on Update button, it will redirect the user to the relevant store link.

- For more details please visit [Android/iOS update mode documentation](https://doc.dev.appsonair.com/#androidios-update-mode)


### Maintenance Mode​ 
  
In case the project needs to be put in maintenance mode, in order to fix any deployment issues, bug fixes or project upgrade, the AoA maintenance mode will save your day. Here's how you can configure your appp's maintenance mode

1. Go in the app for which you want to configure the maintenance
2. In the app details page, go o the App Services tab and then go to the Maintenance mode tab
3. Enable this mode using the toggle
4. After enabling this, put in the necessary details and click on Save button. The app is now in maintenance mode.
5. If the user opens the app, it will now show a maintenance screen which will not let user to use anything in mobile app.

- For more details please visit [Maintenance mode​ docuementation](https://doc.dev.appsonair.com/#maintenance-mode)

### Issue and feedback

Please file FlutterFire specific issues, bugs, or feature requests in our [issue tracker](https://github.com/apps-on-air/AppsOnAir-Flutter-SDK/issues).