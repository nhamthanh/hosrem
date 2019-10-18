//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"
#import <connectivity/ConnectivityPlugin.h>
#import <firebase_messaging/FirebaseMessagingPlugin.h>
#import <flutter_facebook_login/FacebookLoginPlugin.h>
#import <flutter_full_pdf_viewer/FlutterFullPdfViewerPlugin.h>
#import <flutter_money_formatter/FlutterMoneyFormatterPlugin.h>
#import <path_provider/PathProviderPlugin.h>
#import <shared_preferences/SharedPreferencesPlugin.h>
#import <sqflite/SqflitePlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FLTConnectivityPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTConnectivityPlugin"]];
  [FLTFirebaseMessagingPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTFirebaseMessagingPlugin"]];
  [FacebookLoginPlugin registerWithRegistrar:[registry registrarForPlugin:@"FacebookLoginPlugin"]];
  [FlutterFullPdfViewerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterFullPdfViewerPlugin"]];
  [FlutterMoneyFormatterPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterMoneyFormatterPlugin"]];
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
  [FLTSharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharedPreferencesPlugin"]];
  [SqflitePlugin registerWithRegistrar:[registry registrarForPlugin:@"SqflitePlugin"]];
}

@end
