//
//  TokenManager.h
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/4/25.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHTTokenManager : NSObject

+ (YHTTokenManager *)sharedManager;

- (void)setTokenWithString:(NSString *)tokenStr;

- (BOOL)isTokenValid;

- (void)reloadToken;

- (NSString *)token;

@end
