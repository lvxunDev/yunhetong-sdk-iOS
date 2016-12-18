//
//  Sign.m
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/4/25.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#define Date1970(VALUE) ([NSDate dateWithTimeIntervalSince1970:VALUE/1000])
#import "NSData+Base64.h"
#import "YHTSign.h"
@implementation YHTSign

+ (instancetype)instanceWithDic:(NSDictionary *)dic{
    YHTSign *__sign = [[YHTSign alloc] init];
    __sign.aid = [dic[@"id"] longLongValue];
    __sign.gmtCreate = Date1970([dic[@"gmtCreate"] longLongValue]);
    __sign.gmtModify = Date1970([dic[@"gmtModify"] longLongValue]);
    __sign.status = [dic[@"status"] integerValue];
    __sign.isUsed = [dic[@"used"] boolValue];
    __sign.content = dic[@"sign"][@"signData"];

    return __sign;
}

- (NSDate *)dispalyDate {
    return [self.gmtCreate laterDate:self.gmtModify];
}

- (UIImage *)signImage {
//    NSData *__data = [NSData dataFromBase64String:[self.content stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
    NSData *__data = [NSData dataFromBase64String:self.content];
    return [UIImage imageWithData:__data];
}
@end
