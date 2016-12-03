//
//  Constant.m
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/6.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import "YHTConstants.h"

@implementation YHTConstants

NSString * const kSignContract_URL         = @"sdk/contract/sign";

NSString * const kInvalidContract_URL      = @"sdk/contract/invalid";

NSString * const kViewContract_URL         = @"sdk/contract/view";

NSString * const kViewSignature_URL        = @"sdk/sign/getSign";

NSString * const kGenerateSignature_URL    = @"sdk/sign/createSign";

NSString * const kDeleteSignature_URL      = @"sdk/sign/delSign";

NSString * const kViewWebContract_URL      = @"sdk/contract/mobile/view";

#pragma mark - Java

/*
 *  NSString * const kToken_URL                = @"sdkdemo/token";
 *
 *  NSString * const kTokenContract_URL        = @"sdkdemo/token_contract";
 */

#pragma mark - PHP
NSString * const kToken_URL                = @"phpDemo/token.php";

NSString * const kTokenContract_URL        = @"phpDemo/token_contract.php";

+ (NSString *)host {

    NSString *__returnURL = @"http://testsdk.yunhetong.com";

#ifdef TEST_SERVICE
    __returnURL = @"http://testsdk.yunhetong.com";

#else
    __returnURL = @"http://sdk.yunhetong.com";
#endif

    return __returnURL;
}

+ (NSString *)urlByHost:(NSString *)path{
    NSURL *__url = [[NSURL URLWithString:[self host]] URLByAppendingPathComponent:path];
    NSLog(@"__url:%@",__url.absoluteString);
    return __url.absoluteString;
}

@end