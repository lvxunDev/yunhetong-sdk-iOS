//
//  YhtSdk.h
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/4/25.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "YHTHttpRequest.h"
#import "YHTConstants.h"
#import "YHTSignManager.h"
#import "YHTTokenManager.h"
#import "YHTContractManager.h"
#import "YHTSignMadeViewController.h"
#import "YHTSignViewController.h"
#import "YHTContractContentViewController.h"

typedef NS_ENUM(NSInteger, YHTSDKResponseStatusCode)
{
    YHTSDKResponseStatusCodeSuccess               = 200,//成功
    YHTSDKResponseStatusCodeTokenInvalid          = 400,//签名失效
    YHTSDKResponseStatusCodeSystemError           = 520,//签名已经存在
};

//请求完'tokenStr'的回调
typedef void(^ResetTokenBlock)(id obj);

@protocol YHTResetTokenDelegate;
@interface YHTSdk : NSObject

@property (nonatomic, copy)NSString *appId;

@property (nonatomic, strong)id<YHTResetTokenDelegate> resetTokenDelegate;

+ (YHTSdk *)sharedManager;

//设置token
+ (void)setToken:(NSString *)tokenStr;

//设置重置'token'的代理
+ (void)setResetTokenDelegate:(id)delegate;
@end

@protocol YHTResetTokenDelegate <NSObject>
@optional
- (void)resetTokenWithHtttpRequest:(YHTHttpRequest *)httpRequest;
@end