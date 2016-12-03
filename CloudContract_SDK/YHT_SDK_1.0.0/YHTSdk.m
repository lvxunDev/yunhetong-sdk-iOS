//
//  YhtSdk.m
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/4/25.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import "YHTSdk.h"

@implementation YHTSdk

+ (YHTSdk *)sharedManager{
    static YHTSdk *_single = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _single = [[self alloc] init];
    });

    return _single;
}

+ (void)setResetTokenDelegate:(id)delegate{
    YHTSdk *sdk = [YHTSdk sharedManager];
    sdk.resetTokenDelegate = delegate;
}

+ (void)setToken:(NSString *)tokenStr{
    [[YHTTokenManager sharedManager] setTokenWithString:tokenStr];
}
@end
