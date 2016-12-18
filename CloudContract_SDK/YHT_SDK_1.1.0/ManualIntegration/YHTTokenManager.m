//
//  TokenManager.m
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/4/25.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import "YHTTokenManager.h"

@interface YHTTokenManager()

/**
 *  token字符串
 */
@property (strong, nonatomic) NSString *tokenStr;

/**
 *  token日期
 */
@property (strong, nonatomic) NSDate *date;

@end

@implementation YHTTokenManager

static YHTTokenManager *_single = nil;

+ (YHTTokenManager *)sharedManager{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _single = [[self alloc] init];
    });

    return _single;
}

- (void)reloadToken{
    self.date = [NSDate date];
}

- (BOOL)isTokenValid{
    if (self.tokenStr == nil || self.date == nil) {
        return NO;
    }

    return [NSDate date].timeIntervalSinceReferenceDate - self.date.timeIntervalSinceReferenceDate < 30 * 60;
}

- (void)setTokenWithString:(NSString *)tokenStr{
    self.tokenStr = tokenStr;
    [self reloadToken];
}

- (NSString *)token{
    return self.tokenStr;
}

@end
