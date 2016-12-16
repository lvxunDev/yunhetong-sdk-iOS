//
//  YHTContractPreOperateMenu.h
//  CloudContract_SDK
//
//  Created by 吴清正 on 2016/12/13.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHTContractPartner.h"
@protocol ContractPreOperateDelegate;

@interface YHTContractPreOperateMenu : NSObject

+ (instancetype)instanceWithContract:(YHTContractPartner *)__partner delegate:(id<ContractPreOperateDelegate>)__delegate;

- (void)show;
@end

@protocol ContractPreOperateDelegate <NSObject>

- (void)didSelectedOperate:(ContractOperateType)__operateType;

@end
