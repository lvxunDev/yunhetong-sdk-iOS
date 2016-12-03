//
//  YHTSignMadeViewController.h
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/9.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHTSdk.h"

@protocol YHTSignMadeViewDelegate;

@interface YHTSignMadeViewController : UIViewController

@property (nonatomic, weak)id<YHTSignMadeViewDelegate> delegate;

/**
 *  签名生成
 *
 *  @param delegate  YHTSignMadeViewDelegate对象
 *
 *  @return 签名生成视图控制器的实例
 */
+ (instancetype)instanceWithDelegate:(id<YHTSignMadeViewDelegate>)delegate;
@end

@protocol YHTSignMadeViewDelegate <NSObject>

- (void)onMadeSignSuccessed:(id)__id;

@end
