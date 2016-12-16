//
//  ContractManager.m
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/4/25.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//
#import "YHTContractManager.h"
#import "YHTHttpRequest.h"
#import "YHTConstants.h"
@implementation YHTContractManager

+ (YHTContractManager *)sharedManager{
    static YHTContractManager *_single = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _single = [[super allocWithZone:NULL] init] ;
    });

    return _single;
}

- (void)signContractWithContractID:(NSNumber *)contractID
                               tag:(NSString *)tag
                          delegate:(id<YHTHttpRequestDelegate>)delegate{
    [YHTHttpRequest requestWithURL:[YHTConstants urlByHost:kSignContract_URL]
                        httpMethod:@"POST"
                            params:@{@"contractId" : contractID}
                               tag:tag
                          delegate:delegate];
}

- (void)allSignContractWithContractID:(NSNumber *)contractID
                                  tag:(NSString *)tag
                             delegate:(id<YHTHttpRequestDelegate>)delegate{
    [YHTHttpRequest requestWithURL:[YHTConstants urlByHost:kAllSignContract_URL]
                        httpMethod:@"POST"
                            params:@{@"contractId" : contractID}
                               tag:tag
                          delegate:delegate];
}

- (void)invalidContractWithContractID:(NSNumber *)contractID
                                  tag:(NSString *)tag
                             delegate:(id<YHTHttpRequestDelegate>)delegate{
    [YHTHttpRequest requestWithURL:[YHTConstants urlByHost:kInvalidContract_URL]
                        httpMethod:@"POST"
                            params:@{@"contractId" : contractID}
                               tag:tag
                          delegate:delegate];
}

- (void)viewContactWithContractID:(NSNumber *)contractID
                              tag:(NSString *)tag
                         delegate:(id<YHTHttpRequestDelegate>)delegate {
    [self viewContactWithContractID:contractID tag:tag backParams:nil delegate:delegate];
}

- (void)viewContactWithContractID:(NSNumber *)contractID
                              tag:(NSString *)tag
                       backParams:(NSString *)params
                         delegate:(id<YHTHttpRequestDelegate>)delegate{

    NSDictionary *parameter = @{@"contractId" : contractID, @"backParams" : params? params:@""};

    [YHTHttpRequest requestWithURL:[YHTConstants urlByHost:kViewContract_URL]
                        httpMethod:@"POST"
                            params:parameter
                               tag:tag
                          delegate:delegate];
}

- (void)preViewContactWithContractID:(NSNumber *)contractID
                              tag:(NSString *)tag
                       backParams:(NSString *)params
                         delegate:(id<YHTHttpRequestDelegate>)delegate{

    NSDictionary *parameter = @{@"contractId" : contractID};

    [YHTHttpRequest requestWithURL:[YHTConstants urlByHost:kPreViewContract_URL]
                        httpMethod:@"POST"
                            params:parameter
                               tag:tag
                          delegate:delegate];
}
@end
