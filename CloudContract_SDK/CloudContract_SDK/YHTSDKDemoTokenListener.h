//
//  ResetTokenUtil.h
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/6/4.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHTSdk.h"
@interface YHTSDKDemoTokenListener : NSObject

//获得'ResetTokenUtil'单例
+ (YHTSDKDemoTokenListener *)sharedManager;

//从自己的服务器上获取'token'
- (void)getTokenWithCompletionHander:(ResetTokenBlock)resetTokenBlock;

//从自己的服务器上创建合同获取'token'
- (void)getTokenContractWithCompletionHander:(ResetTokenBlock)resetTokenBlock;

@end
