//
//  UIImage+Bundle.m
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/10.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import "UIImage+Wqz.h"

@implementation UIImage (Bundle)
+ (UIImage *)imagesNamedFromCustomYHTSdkBundle:(NSString *)name{
    NSString *main_images_dir_path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"YHTSdk.bundle/images"];
    NSString *image_path = [main_images_dir_path stringByAppendingPathComponent:name];

    return [UIImage imageWithContentsOfFile:image_path];
}

+ (UIImage *)wqz_resizableImage4Center:(NSString *)__imageName {
    return [[UIImage imagesNamedFromCustomYHTSdkBundle:__imageName] wqz_resizableImage4Center];
}

- (UIImage *)wqz_resizableImage4Center {
    CGFloat __v = self.size.height * 0.5;
    CGFloat __h = self.size.width * 0.5;
    UIEdgeInsets __insets = UIEdgeInsetsMake(__v, __h, __v, __h);
    return[self resizableImageWithCapInsets:__insets];
}

@end
