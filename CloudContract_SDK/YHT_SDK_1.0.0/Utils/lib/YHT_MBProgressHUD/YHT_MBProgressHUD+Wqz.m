//
//  YHT_MBProgressHUD+Wqz.m
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/21.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import "YHT_MBProgressHUD+Wqz.h"
#import "UIImage+Wqz.h"
#import "NSNumber+Wqz.h"
#import "NSString+Wqz.h"
#import <objc/runtime.h>

#define kDefault_success_delay                      0.7
#define kDefault_error_delay                        1.5

static const void *hudFinishedBlockKey = &hudFinishedBlockKey;
@implementation YHT_MBProgressHUD (Wqz)

- (void)setBlock:(WypActionBlock) __aBlock {
    objc_setAssociatedObject(self, hudFinishedBlockKey, __aBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)show:(NSString *)__text icon:(NSString *)__icon view:(UIView *)__view afterDelay:(CGFloat)__delay withblock:(WypActionBlock)__aBlock{
    if (__view == nil) {
        __view = [[UIApplication sharedApplication].windows lastObject];
    }
    YHT_MBProgressHUD *__hud = [YHT_MBProgressHUD showHUDAddedTo:__view animated:YES];
    [__hud setBlock:__aBlock];

    if ([NSString wqz_isNotEmpty:__text]) {
        NSMutableString *__mutableText = [NSMutableString stringWithString:__text];
        int __space = 10;
        int __loop = [[NSNumber wqz_roundingWithNum:__mutableText.length / __space afterPoint:0 mode:NSRoundDown] intValue];
        for (int i=0; i<__loop; i++) {
            int __index = (i+1)*__space + i;
            __index = __index < __mutableText.length ? __index : -1;
            if (__index < __space) {
                continue;
            }
            [__mutableText insertString:@"\n" atIndex:__index];
        }
        __hud.labelText = __mutableText;
    }else{
        __hud.labelText = __text;
    }

    __hud.customView = [[UIImageView alloc] initWithImage:[UIImage imagesNamedFromCustomYHTSdkBundle:__icon]];
    __hud.mode = MBProgressHUDModeCustomView;
    __hud.removeFromSuperViewOnHide = YES;
    [__hud hide:YES afterDelay:__delay];

}

#pragma mark - Success
+ (void)showSuccess:(NSString *)__success {
    [self showSuccess:__success toView:nil afterDelay:kDefault_success_delay withblock:nil];
}

+ (void)showSuccess:(NSString *)__success toView:(UIView *)__view afterDelay:(CGFloat)__delay {
    __delay = __delay <= 0 ? kDefault_success_delay : __delay;
    [self showSuccess:__success toView:__view afterDelay:__delay withblock:nil];
}

+ (void)showSuccess:(NSString *)__success toView:(UIView *)__view afterDelay:(CGFloat)__delay withblock:(WypActionBlock)__aBlock {
    __delay = __delay <= 0 ? kDefault_success_delay : __delay;
    [self show:__success icon:@"success.png" view:__view afterDelay:__delay withblock:__aBlock];
}

#pragma mark - Error
+ (void)showError:(NSString *)__error; {
    [self showError:__error toView:nil afterDelay:kDefault_error_delay withblock:nil];
}

+ (void)showError:(NSString *)__error toView:(UIView *)__view afterDelay:(CGFloat)__delay {
    __delay = __delay <= 0 ? kDefault_error_delay : __delay;
    [self showError:__error toView:__view afterDelay:__delay withblock:nil];
}

+ (void)showError:(NSString *)__error toView:(UIView *)__view afterDelay:(CGFloat)__delay withblock:(WypActionBlock)__aBlock {
    __delay = __delay <= 0 ? kDefault_error_delay : __delay;
    [self show:__error icon:@"error.png" view:__view  afterDelay:__delay withblock:__aBlock];
}


#pragma mark - Message
+ (YHT_MBProgressHUD *)showHTTPMessage:(NSString *)__message {
    return [self showHTTPMessage:__message toView:nil];
}

+ (YHT_MBProgressHUD *)showHTTPMessage:(NSString *)__message toView:(UIView *)__view {
    if (__view == nil) {
        __view = [[UIApplication sharedApplication].windows lastObject];
    }
    YHT_MBProgressHUD *__hud = [YHT_MBProgressHUD showHUDAddedTo:__view animated:YES];
    __hud.labelText = __message;
    __hud.removeFromSuperViewOnHide = YES;
    __hud.dimBackground = YES;//蒙版
    return __hud;
}

#pragma mark - Hide
+ (void)hideHUDForView:(UIView *)__view {
    if (__view == nil) {
        __view = [[UIApplication sharedApplication].windows lastObject];
    }
    [self hideHUDForView:__view animated:YES];
}

+ (void)hideHUD {
    [self hideHUDForView:nil];
}

+ (void)hideHUDWithBlock:(void (^)(void))__aBlock{
    [self hideHUD];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __aBlock();
    });
}

@end
