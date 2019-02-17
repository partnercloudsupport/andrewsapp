//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"
#import <background_fetch/BackgroundFetchPlugin.h>
#import <barcode_scan/BarcodeScanPlugin.h>
#import <camera/CameraPlugin.h>
#import <cloud_firestore/CloudFirestorePlugin.h>
#import <cloud_functions/CloudFunctionsPlugin.h>
#import <connectivity/ConnectivityPlugin.h>
#import <device_info/DeviceInfoPlugin.h>
#import <firebase_analytics/FirebaseAnalyticsPlugin.h>
#import <firebase_auth/FirebaseAuthPlugin.h>
#import <firebase_core/FirebaseCorePlugin.h>
#import <firebase_ml_vision/FirebaseMlVisionPlugin.h>
#import <firebase_storage/FirebaseStoragePlugin.h>
#import <flutter_background_geolocation/FLTBackgroundGeolocationPlugin.h>
#import <image_picker/ImagePickerPlugin.h>
#import <launch_review/LaunchReviewPlugin.h>
#import <location/LocationPlugin.h>
#import <path_provider/PathProviderPlugin.h>
#import <share/SharePlugin.h>
#import <shared_preferences/SharedPreferencesPlugin.h>
#import <url_launcher/UrlLauncherPlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [BackgroundFetchPlugin registerWithRegistrar:[registry registrarForPlugin:@"BackgroundFetchPlugin"]];
  [BarcodeScanPlugin registerWithRegistrar:[registry registrarForPlugin:@"BarcodeScanPlugin"]];
  [CameraPlugin registerWithRegistrar:[registry registrarForPlugin:@"CameraPlugin"]];
  [FLTCloudFirestorePlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTCloudFirestorePlugin"]];
  [CloudFunctionsPlugin registerWithRegistrar:[registry registrarForPlugin:@"CloudFunctionsPlugin"]];
  [FLTConnectivityPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTConnectivityPlugin"]];
  [FLTDeviceInfoPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTDeviceInfoPlugin"]];
  [FLTFirebaseAnalyticsPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTFirebaseAnalyticsPlugin"]];
  [FLTFirebaseAuthPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTFirebaseAuthPlugin"]];
  [FLTFirebaseCorePlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTFirebaseCorePlugin"]];
  [FLTFirebaseMlVisionPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTFirebaseMlVisionPlugin"]];
  [FLTFirebaseStoragePlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTFirebaseStoragePlugin"]];
  [FLTBackgroundGeolocationPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTBackgroundGeolocationPlugin"]];
  [FLTImagePickerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTImagePickerPlugin"]];
  [LaunchReviewPlugin registerWithRegistrar:[registry registrarForPlugin:@"LaunchReviewPlugin"]];
  [LocationPlugin registerWithRegistrar:[registry registrarForPlugin:@"LocationPlugin"]];
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
  [FLTSharePlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharePlugin"]];
  [FLTSharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharedPreferencesPlugin"]];
  [FLTUrlLauncherPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTUrlLauncherPlugin"]];
}

@end
