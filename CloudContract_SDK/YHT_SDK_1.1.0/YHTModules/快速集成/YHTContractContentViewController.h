//
//  YHTContractContentViewController.h
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/10.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHTSdk.h"

@interface YHTContractContentViewController : UIViewController

/**
 *  'YHTContractContentViewController'实例方法
 *
 *  @param contractID 合同编号
 *
 *  @return 'YHTContractContentViewController'的实例
 */

+ (instancetype)instanceWithContractID:(NSNumber *)contractID;
@end
