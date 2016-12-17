//
//  YHTHttpRequest.h
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/4.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol YHTHttpRequestDelegate;

@interface YHTHttpRequest : NSObject

/**
 *  用户自定义请求地址'url'
 */
@property (nonatomic, copy)NSString *url;

/**
 *  用户自定义请求方式'GET' 'POST'
 */
@property (nonatomic, copy)NSString *httpMethod;

/**
 *  用户自定义请求参数字典
 */
@property (nonatomic, strong)NSDictionary *params;

/**
 *  YHTHttpRequestDelegate对象，用于接收云合同SDK对于发起的接口请求的响应
 */
@property (nonatomic, weak)id<YHTHttpRequestDelegate> delegate;

/**
 *  用户自定义'tag'，用于区分回调'request'
 */
@property (nonatomic, copy)NSString *tag;

/**
 *  完成请求后会回调handler，处理完成请求后的逻辑
 *
 *  @param httpRequest 具体的请求对象
 *  @param result      请求的返回结果
 *  @param error       错误信息
 */
typedef void (^YHTHttpRequestHandler)(YHTHttpRequest *httpRequest, id result, NSError *error);

/**
 *  'request'发起请求
 */
- (void)startRequest;

/**
 *  统一'HTTP'请求接口，调用此接口后，将发送一个'HTTP'网络请求
 *
 *  @param url         请求'url'地址
 *  @param httpMethod  支持'GET' 'POST'
 *  @param params      向接口传递的参数结构
 *  @param tag         用户自定义'tag'，将通过回调YHTHttpRequest实例的tag属性返回
 *  @param delegate    YHTHttpRequestDelegate对象，用于接收云合同SDK对于发起的接口请求的请求响应
 *
 *  @return  YHTHttpRequest实例
 */
+ (YHTHttpRequest *)requestWithURL:(NSString *)url
                        httpMethod:(NSString *)httpMethod
                            params:(NSDictionary *)params
                               tag:(NSString *)tag
                          delegate:(id<YHTHttpRequestDelegate>)delegate;
@end

#pragma mark - YHTHttpRequestDelegate

@protocol YHTHttpRequestDelegate <NSObject>
@optional
/**
 *  收到一个来自云合同'HTTP'请求失败的响应
 *
 *  @param request  具体的请求对象
 *  @param error    错误信息
 */

- (void)request:(YHTHttpRequest *)request didFailWithError:(NSError *)error;

/**
 *  收到一个来自云合同'HTTP'请求的响应
 *
 *  @param request  具体的请求对象
 *  @param result   请求的返回结果
 */
- (void)request:(YHTHttpRequest *)request didFinishLoadingWithResult:(id)result;
@end