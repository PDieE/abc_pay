#import "AbcPayPlugin.h"
#import "ABCAppCaller.h"

#define SHEME_ABC @"bankabc://"

@implementation AbcPayPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"abc_pay"
            binaryMessenger:[registrar messenger]];
  AbcPayPlugin* instance = [[AbcPayPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  NSString* method = call.method;
  NSLog(@"%@-%@",call.method, call.arguments); 
  if ([method isEqualToString:@"isAvaiable"]) {
    // 获取农行掌银是否存在且可用
    result([NSNumber numberWithBool:[[ABCAppCaller sharedAppCaller] isABCePayAvailable:SHEME_ABC]]);
  } else if ([method isEqualToString:@"doPay"]) {
    // 发起支付
    NSString* callbackId = call.arguments[@"callbackId"];
    NSLog(callbackId);
    NSString* tokenId = call.arguments[@"tokenId"];
    NSLog(tokenId);
    NSString* params = [[NSString alloc] initWithFormat:@"CallbackID=%@&TokenID=%@&Method=pay", callbackId, tokenId ];
    NSLog(@"params");
    NSLog(params);
    [[ABCAppCaller sharedAppCaller] callBankABC:SHEME_ABC param:params];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
