//
//  ContractManager.h
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/4/25.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHTHttpRequest.h"

@interface YHTContractManager : NSObject

/**
 *  @return ContractManager单例
 */
+ (YHTContractManager *)sharedManager;

/**
 *  签署合同
 *
 *  @param contractID  需要签署合同的编号
 *  @param tag         用户自定义'tag'，用于区分回调'request'
 *  @param delegate    YHTHttpRequestDelegate对象，用于接收云合同SDK对于发起的接口请求的请求响应
 */
- (void)signContractWithContractID:(NSNumber *)contractID
                               tag:(NSString *)tag
                          delegate:(id<YHTHttpRequestDelegate>)delegate;

/**
 *  作废合同
 *
 *  @param contractID  需要作废合同的编号
 *  @param tag         用户自定义'tag'，用于区分回调'request'
 *  @param delegate    YHTHttpRequestDelegate对象，用于接收云合同SDK对于发起的接口请求的请求响应
 */
- (void)invalidContractWithContractID:(NSNumber *)contractID
                                  tag:(NSString *)tag
                             delegate:(id<YHTHttpRequestDelegate>)delegate;

/**
 *  查看合同
 *
 *  @param contractID  需要查看合同的编号
 *  @param tag         用户自定义'tag'，用于区分回调'request'
 *  @param delegate    YHTHttpRequestDelegate对象，用于接收云合同SDK对于发起的接口请求的请求响应
 */
- (void)viewContactWithContractID:(NSNumber *)contractID
                              tag:(NSString *)tag
                         delegate:(id<YHTHttpRequestDelegate>)delegate;


- (void)viewContactWithContractID:(NSNumber *)contractID
                              tag:(NSString *)tag
                       backParams:(nullable NSString *)params
                         delegate:(id<YHTHttpRequestDelegate>)delegate;
@end
