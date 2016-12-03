//
//  ContractOperateMenu.h
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/17.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHTContractPartner.h"
@protocol ContractOperateDelegate;

@interface YHTContractOperateMenu : NSObject

+ (instancetype)instanceWithContract:(YHTContractPartner *)__partner delegate:(id<ContractOperateDelegate>)__delegate;

- (void)show;
@end

@protocol ContractOperateDelegate <NSObject>

- (void)didSelectedOperate:(ContractOperateType)__operateType;

- (void)didPushWithViewController;
@end
