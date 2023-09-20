
class AppInfo {
    String? appName;
    String? appLogo;
    String? id;
    bool? isMaintenance;
    UpdateData? updateData;
    MaintenanceData? maintenanceData;
    

    AppInfo({
        this.appName,
        this.appLogo,
        this.id,
        this.isMaintenance,
        this.updateData,
        this.maintenanceData,
    });

    factory AppInfo.fromJson(Map<String, dynamic> json) => AppInfo(

      /// jsonData is getting with type Map<Object?, Object?> so while parsing we are getting error of type mismatch
    /// so right now now we are using jsonEncode and jsonDecode to solve this
  
    // final encodedJson = jsonEncode(jsonData);
    // final json = jsonDecode(encodedJson);
    
        appName: json["appName"],
        appLogo: json["appLogo"],
        id: json["id"],
        isMaintenance: json["isMaintenance"],
        updateData: json["updateData"] == null ? null : UpdateData.fromJson(json["updateData"]),
        maintenanceData: json["maintenanceData"] == null ? null : MaintenanceData.fromJson(json["maintenanceData"]),
    );

    Map<String, dynamic> toJson() => {
        "appName": appName,
        "appLogo": appLogo,
        "id": id,
        "isMaintenance": isMaintenance,
        "updateData": updateData?.toJson(),
        "maintenanceData": maintenanceData?.toJson(),
    };
}

class MaintenanceData {
    MaintenanceData();

    factory MaintenanceData.fromJson(Map json) => MaintenanceData();

    Map toJson() => {};
}

class UpdateData {
    bool? isIosUpdate;
    String? iosBuildNumber;
    String? iosMinBuildVersion;
    String? iosUpdateLink;
    bool? isIosForcedUpdate;
    bool? isAndroidUpdate;
    String? androidBuildNumber;
    String? androidMinBuildVersion;
    String? androidUpdateLink;
    bool? isAndroidForcedUpdate;
    String? updateCheck;

    UpdateData({
        this.isIosUpdate,
        this.iosBuildNumber,
        this.iosMinBuildVersion,
        this.iosUpdateLink,
        this.isIosForcedUpdate,
        this.isAndroidUpdate,
        this.androidBuildNumber,
        this.androidMinBuildVersion,
        this.androidUpdateLink,
        this.isAndroidForcedUpdate,
        this.updateCheck,
    });

    factory UpdateData.fromJson(Map<String, dynamic> json) => UpdateData(
        isIosUpdate: json["isIOSUpdate"],
        iosBuildNumber: json["iosBuildNumber"],
        iosMinBuildVersion: json["iosMinBuildVersion"],
        iosUpdateLink: json["iosUpdateLink"],
        isIosForcedUpdate: json["isIOSForcedUpdate"],
        isAndroidUpdate: json["isAndroidUpdate"],
        androidBuildNumber: json["androidBuildNumber"],
        androidMinBuildVersion: json["androidMinBuildVersion"],
        androidUpdateLink: json["androidUpdateLink"],
        isAndroidForcedUpdate: json["isAndroidForcedUpdate"],
        updateCheck: json['exception'],
    );

    Map<String, dynamic> toJson() => {
        "isIOSUpdate": isIosUpdate,
        "iosBuildNumber": iosBuildNumber,
        "iosMinBuildVersion": iosMinBuildVersion,
        "iosUpdateLink": iosUpdateLink,
        "isIOSForcedUpdate": isIosForcedUpdate,
        "isAndroidUpdate": isAndroidUpdate,
        "androidBuildNumber": androidBuildNumber,
        "androidMinBuildVersion": androidMinBuildVersion,
        "androidUpdateLink": androidUpdateLink,
        "isAndroidForcedUpdate": isAndroidForcedUpdate,
        "exception" : updateCheck,
    };
}