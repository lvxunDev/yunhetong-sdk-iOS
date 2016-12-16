//
//  YHTSDKDemoConfirmViewController.h
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/6/7.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHTSDKDemoBaseViewController.h"
@interface YHTSDKDemoConfirmViewController : YHTSDKDemoBaseViewController

@property (nonatomic, assign)BOOL isPreView;//判断查看合同/预览合同

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

+ (instancetype)instanceWithIsPreView:(BOOL)__isPreView;

@end
