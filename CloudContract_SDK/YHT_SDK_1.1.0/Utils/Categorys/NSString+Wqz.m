//
//  NSString+Wqz.m
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/12.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import "NSString+Wqz.h"

@implementation NSString (Wqz)
- (NSString *)wqz_trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)wqz_equalsIgnoreCase:(NSString *)__str {
    NSString *__one = [self lowercaseString];
    NSString *__two = [__str lowercaseString];
    return [__one isEqualToString:__two];
}

+ (BOOL)wqz_isNotEmpty:(NSString *)__str {
    if (__str == nil || [__str isKindOfClass:[NSNull class]]) {
        return NO;
    }
    if([@"" isEqualToString:[__str wqz_trim]]){
        return NO;
    }

    if([@"null" wqz_equalsIgnoreCase:[__str wqz_trim]]){
        return NO;
    }

    if([@"<null>" wqz_equalsIgnoreCase:[__str wqz_trim]]){
        return NO;
    }


    if([@"undefined" wqz_equalsIgnoreCase:[__str wqz_trim]]){
        return NO;
    }

    return YES;
}

@end
