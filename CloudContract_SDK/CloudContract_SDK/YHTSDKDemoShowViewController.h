//
//  YHTSDKDemoRootViewController.h
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/6/6.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHTSDKDemoBaseViewController.h"
@interface YHTSDKDemoShowViewController : YHTSDKDemoBaseViewController

//发起方签署按钮
@property (weak, nonatomic) IBOutlet UIButton *button_partyA;

//接收方签署按钮
@property (weak, nonatomic) IBOutlet UIButton *button_partyB;

@end
