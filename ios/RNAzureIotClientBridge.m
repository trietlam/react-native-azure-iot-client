//
//  AzureIoTClientBridge.m
//  ReactNativeIoT
//
//  Created by Admin on 13/12/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface RCT_EXTERN_MODULE(RNAzureIotClient, RCTEventEmitter)
RCT_EXTERN_METHOD(supportedEvents)
RCT_EXTERN_METHOD(testEvent:(NSString *)name)
RCT_EXTERN_METHOD(connect:(NSString *)hostName deviceId:(NSString *)deviceId)
RCT_EXTERN_METHOD(sendMessage:(NSString *)message)
RCT_EXTERN_METHOD(addEvent:(NSString *)name location:(NSString *)location date:(nonnull NSNumber *)date)

@end

