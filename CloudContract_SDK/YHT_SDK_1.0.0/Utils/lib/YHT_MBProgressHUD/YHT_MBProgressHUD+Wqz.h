//
//  YHT_MBProgressHUD+Wqz.h
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/21.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import "YHT_MBProgressHUD.h"
typedef void (^WypActionBlock)(id __send);

@interface YHT_MBProgressHUD (Wqz)

+ (void)showSuccess:(NSString *)__success;
+ (void)showSuccess:(NSString *)__success toView:(UIView *)__view afterDelay:(CGFloat)__delay;
+ (void)showSuccess:(NSString *)__success toView:(UIView *)__view afterDelay:(CGFloat)__delay withblock:(WypActionBlock)__aBlock;

+ (void)showError:(NSString *)__error;
+ (void)showError:(NSString *)__error toView:(UIView *)__view afterDelay:(CGFloat)__delay;
+ (void)showError:(NSString *)__error toView:(UIView *)__view afterDelay:(CGFloat)__delay withblock:(WypActionBlock)__aBlock;

+ (YHT_MBProgressHUD *)showHTTPMessage:(NSString *)__message;
+ (YHT_MBProgressHUD *)showHTTPMessage:(NSString *)__message toView:(UIView *)__view;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;
+ (void)hideHUDWithBlock:(void (^)(void))__aBlock;

@end
