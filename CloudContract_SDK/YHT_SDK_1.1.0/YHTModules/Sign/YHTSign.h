//
//  Sign.h
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/4/25.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//刚创建签名时，处于可用状态;设置为默认签名后，状态置为0;将签名删除后，状态置为2
typedef NS_ENUM(NSInteger, SignStatus) {
    SignStatus_default                  = 0,//0为默认
    SignStatus_enable                   = 1,//1为可用
    SignStatus_destory                  = 2,//2为保留
};

@interface YHTSign : NSObject

@property (nonatomic, assign)long long aid;
@property (nonatomic, strong)NSDate *gmtCreate;
@property (nonatomic, strong)NSDate *gmtModify;
@property (nonatomic, strong)NSString *content;
@property (nonatomic, assign)BOOL isUsed;
@property (nonatomic, assign)SignStatus status;

@property (nonatomic, weak, readonly)NSDate *dispalyDate;
@property (nonatomic, weak, readonly)UIImage *signImage;

+ (instancetype)instanceWithDic:(NSDictionary *)dic;

@end
