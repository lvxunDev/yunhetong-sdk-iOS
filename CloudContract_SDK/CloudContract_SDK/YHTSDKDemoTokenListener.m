//
//  ResetTokenUtil.m
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/6/4.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import "YHTSDKDemoTokenListener.h"
#import "AFNetworking.h"
#import "YHTSDKDemoContract.h"
#import "MBProgressHUD+Wqz.h"
@interface YHTSDKDemoTokenListener()<YHTResetTokenDelegate>
@property (nonatomic, strong)NSString *tokenStr;
@property (nonatomic, strong)NSArray *contractArray;
@end

@implementation YHTSDKDemoTokenListener

+ (YHTSDKDemoTokenListener *)sharedManager{
    static YHTSDKDemoTokenListener *ManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        ManagerInstance = [[self alloc] init];
    });

    return ManagerInstance;
}

- (void)getTokenWithCompletionHander:(ResetTokenBlock)resetTokenBlock{

    [[AFHTTPSessionManager manager] GET:[YHTConstants urlByHost:kToken_URL] //这里的地址为第三方App从自己的服务器上获取'token'的url地址
                             parameters:nil
                               progress:nil
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    [MBProgressHUD hideHUDWithBlock:^{
                                        resetTokenBlock(responseObject);
                                    }];

                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    [MBProgressHUD hideHUDWithBlock:^{
                                        [MBProgressHUD showError:error.localizedDescription];
                                    }];
                                    
                                }];
}

- (void)getTokenContractWithCompletionHander:(ResetTokenBlock)resetTokenBlock{

    [[AFHTTPSessionManager manager] GET:[YHTConstants urlByHost:kTokenContract_URL] //这里的地址为第三方App从自己的服务器上创建合同获取'token'的url地址
                             parameters:nil
                               progress:nil
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    [MBProgressHUD hideHUDWithBlock:^{
                                        resetTokenBlock(responseObject);
                                    }];

                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    [MBProgressHUD hideHUDWithBlock:^{
                                        [MBProgressHUD showError:error.localizedDescription];
                                    }];
                                }];
}

#pragma mark - YHTResetTokenDelegate
- (void)resetTokenWithHtttpRequest:(YHTHttpRequest *)httpRequest{
    [self getTokenWithCompletionHander:^(id obj) {
        self.tokenStr = obj[@"value"][@"token"];
        self.contractArray = [YHTSDKDemoContract pasingJSONWithDictionary:obj[@"value"]];
        [YHTSdk setToken:_tokenStr];
        [httpRequest startRequest];
    }];
    
}
@end
