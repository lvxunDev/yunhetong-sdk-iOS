//
//  UIButton+Wqz.m
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/11.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import "UIButton+Wqz.h"

@implementation UIButton (Wqz)

- (void)wqz_setButtonRadius:(CGFloat)radius
                  withColor:(UIColor *)color
                  withWidth:(CGFloat)width{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

@end
