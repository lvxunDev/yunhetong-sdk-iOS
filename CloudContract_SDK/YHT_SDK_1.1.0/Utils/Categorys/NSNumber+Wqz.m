//
//  NSNumber+Wqz.m
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/12.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import "NSNumber+Wqz.h"

@implementation NSNumber (Wqz)

+ (NSNumber *)wqz_roundingWithNum:(float)__num afterPoint:(int)__position mode:(NSRoundingMode)__mode {
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:__mode scale:__position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;

    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:__num];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];

    return roundedOunces;;
}
@end
