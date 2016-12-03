//
//  SignManager.h
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/4/25.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHTHttpRequest.h"

@interface YHTSignManager : NSObject

/**
 *  @return SignManager单例
 */
+ (YHTSignManager *)sharedManager;

/**
 *  查看签名,用户查看自己的签名
 *
 *  @param tag         用户自定义'tag'，用于区分回调'request'
 *  @param delegate    YHTHttpRequestDelegate对象，用于接收云合同SDK对于发起的接口请求的请求响应
 */
- (void)viewSignatureWithTag:(NSString *)tag
                    delegate:(id<YHTHttpRequestDelegate>)delegate;

/**
 *  绘制签名, 用户绘制签名
 *
 *  @param signData    签名信息
 *  @param tag         用户自定义'tag'，用于区分回调'request'
 *  @param delegate    YHTHttpRequestDelegate对象，用于接收云合同SDK对于发起的接口请求的请求响应
 */
- (void)generateSignatureWithSignData:(NSString *)signData
                                  tag:(NSString *)tag
                             delegate:(id<YHTHttpRequestDelegate>)delegate;

/**
 *  删除签名, 用户对未签署过的签名进行删除
 *
 *  @param tag         用户自定义'tag'，用于区分回调'request'
 *  @param delegate    YHTHttpRequestDelegate对象，用于接收云合同SDK对于发起的接口请求的请求响应
 */
- (void)deleteSignatureWithTag:(NSString *)tag
                      delegate:(id<YHTHttpRequestDelegate>)delegate;
@end
