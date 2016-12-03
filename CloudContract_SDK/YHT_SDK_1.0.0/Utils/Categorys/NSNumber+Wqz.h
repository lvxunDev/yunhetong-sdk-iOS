//
//  NSNumber+Wqz.h
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/12.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Wqz)

+(NSNumber *)wqz_roundingWithNum:(float)__num afterPoint:(int)__position mode:(NSRoundingMode)__mode;

@end
