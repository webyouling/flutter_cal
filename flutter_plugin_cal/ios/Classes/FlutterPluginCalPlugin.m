#import "FlutterPluginCalPlugin.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface FlutterPluginCalPlugin ()

@property(nonatomic,strong)JSContext *context;

@end

@implementation FlutterPluginCalPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_plugin_cal"
            binaryMessenger:[registrar messenger]];
  FlutterPluginCalPlugin* instance = [[FlutterPluginCalPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  }else if([@"calculate" isEqualToString:call.method]){
      NSDictionary *arguments = [call arguments];
      NSString *resultText = arguments[@"infodata"];
      NSLog(@"打印传递过来的值====：%@",resultText);
      if (self.context == nil) {
          self.context = [[JSContext alloc] init];
      }
      if(!resultText){
          result(nil);
      }else{
          JSValue *value = [self.context evaluateScript:resultText];
          NSLog(@"计算结果====：%@",value);
          if(value == nil||[@"undefined" isEqualToString:value.toString]){
              result(nil);
          }else{
              result(value.toString);
          }
      }
  }else {
    result(FlutterMethodNotImplemented);
  }
}

@end
