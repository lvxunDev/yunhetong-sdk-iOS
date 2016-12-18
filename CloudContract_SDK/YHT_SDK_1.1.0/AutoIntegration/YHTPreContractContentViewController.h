//
//  YHTPreContractContentViewController.h
//  CloudContract_SDK
//
//  Created by 吴清正 on 2016/12/13.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHTSdk.h"

@interface YHTPreContractContentViewController : UIViewController

/**
 *  'YHTPreContractContentViewController'实例方法
 *
 *  @param contractID 合同编号
 *
 *  @return 'YHTPreContractContentViewController'的实例
 */
+ (instancetype)instanceWithContractID:(NSNumber *)contractID;
@end
