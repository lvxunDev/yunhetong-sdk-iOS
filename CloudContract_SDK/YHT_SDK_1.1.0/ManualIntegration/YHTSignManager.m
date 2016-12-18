//
//  SignManager.m
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/4/25.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import "YHTSignManager.h"
#import "YHTConstants.h"
@implementation YHTSignManager

+ (YHTSignManager *)sharedManager{
    static YHTSignManager *_single = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _single = [[self alloc] init];
    });

    return _single;
}

- (void)viewSignatureWithTag:(NSString *)tag
                    delegate:(id<YHTHttpRequestDelegate>)delegate{
    [YHTHttpRequest requestWithURL:[YHTConstants urlByHost:kViewSignature_URL]
                        httpMethod:@"GET"
                            params:nil
                            tag:tag
                          delegate:delegate];
}

- (void)generateSignatureWithSignData:(NSString *)signData
                                  tag:(NSString *)tag
                             delegate:(id<YHTHttpRequestDelegate>)delegate{
    [YHTHttpRequest requestWithURL:[YHTConstants urlByHost:kGenerateSignature_URL]
                        httpMethod:@"POST"
                            params:@{@"sign" : signData}
                               tag:tag
                          delegate:delegate];
}

- (void)deleteSignatureWithTag:(NSString *)tag
                      delegate:(id<YHTHttpRequestDelegate>)delegate{
    [YHTHttpRequest requestWithURL:[YHTConstants urlByHost:kDeleteSignature_URL]
                        httpMethod:@"POST"
                            params:nil
                               tag:tag
                          delegate:delegate];
}
@end
