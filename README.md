## AppsOnAir App_update_package

# appsonair_flutter_sdk_example

```dart
import 'package:appsonair_flutter_sdk/apps_on_air_service.dart';
```

 - Use this code after initializing [MaterialApp]
 - Use this code in initState  

if you want to use default(native) ui then use this

```dart
    AppsOnAirService.checkUpdateAvailable(
      context,
      appId: '*********-e640-477c-aa48-***********', ///appId From appsOnAir Domain
    );
```

if you want to use your custom ui then use this
```dart
    AppsOnAirService.checkUpdateAvailable(
      context,
      appId: 'a*******-e640-477c-aa48-************', ///appId From appsOnAir Domain
      isShowNativeUI: false,
      customWidget: (response) {
        ///return your widget here
        return Container();
      },
    );
```



- [Android/iOS Update Mode](https://doc.dev.appsonair.com/#androidios-update-mode)
This feature enables you to configure the version update of your app directly through AoA. 
In case you want to show the user an app update dialog in Android/iOS, you need to follow these steps:
1. Go to the app details page, from the apps dashboard
2. In the app details page, go o the App Services tab and then go to the Update tab
3.  Enable Updates in for android and/ or iOS using the toggle and fill up required details
4. Details of the setting:
       i. The default mode would be a soft update wherein the user will be notified of any available update and they can choose to update or skip. 
     ii. If you check the Force Update mode, the user will be notified about the available update and they will have to mandatorily install the update.
    iii. Minimum build version: If the app installed having lower version than the minimum build version mentioned in AOA dashboard then user will get dialog for an app update.
     iv. Store Link: If user clicks on Update button, it will redirect the user to the relevant store link.



- [Maintenance Mode​](https://doc.dev.appsonair.com/#maintenance-mode)
In case the project needs to be put in maintenance mode, in order to fix any deployment issues, bug fixes or project upgrade, the AoA maintenance mode will save your day. Here's how you can configure your appp's maintenance mode
1. Go in the app for which you want to configure the maintenance
2. In the app details page, go o the App Services tab and then go to the Maintenance mode tab
3. Enable this mode using the toggle
4. After enabling this, put in the necessary details and click on Save button. The app is now in maintenance mode. 
5. If the user opens the app, it will now show a maintenance screen which will not let user to use anything in mobile app.
