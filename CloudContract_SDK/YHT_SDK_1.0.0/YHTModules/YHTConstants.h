//
//  Constant.h
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/6.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import <Foundation/Foundation.h>
//#define TEST_SERVICE                    1
@interface YHTConstants : NSObject

#define _kIOS_SCREEN_HEIGHT                           ([UIScreen mainScreen].bounds.size.height)

#define _kIOS_SCREEN_WIDTH                            ([UIScreen mainScreen].bounds.size.width)

#define _kIOS_SCREEN                                  ([UIScreen mainScreen].bounds)

#define _kIOS_VERSION                                 ([[UIDevice currentDevice].systemVersion doubleValue])

#define _kMAIN_COLOR                                  [UIColor colorWithRed:0.31f green:0.73f blue:0.96f alpha:1.00f]

#pragma mark - Configuring the ContractManager URL

/**
 *  签署合同'url'
 */
extern NSString * const kSignContract_URL;

/**
 *  作废合同'url'
 */
extern NSString * const kInvalidContract_URL;

/**
 *  查看合同'url'
 */
extern NSString * const kViewContract_URL;

#pragma mark - Configuring the SignManager URL

/**
 *  查看签名'url'
 */
extern NSString * const kViewSignature_URL;

/**
 *  生成签名'url'
 */
extern NSString * const kGenerateSignature_URL;

/**
 *  删除签名'url'
 */
extern NSString * const kDeleteSignature_URL;

/**
 *  查看网页合同'url'
 */
extern NSString * const kViewWebContract_URL;

/**
 *  'token'
 */
extern NSString * const kToken_URL;

/**
 *  'token_contract'
 */
extern NSString * const kTokenContract_URL;

+ (NSString *)urlByHost:(NSString *)path;
@end
