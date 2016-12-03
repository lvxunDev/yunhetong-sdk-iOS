//
//  PartnerModel.h
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/17.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ContractOperateType){
    ContractOperateType_Other            = -99999,
    ContractOperateType_Sign             = 0,
    ContractOperateType_Invalid          = 1,
};

@interface YHTContractPartner : NSObject

@property (nonatomic, strong)NSNumber *contractId;

@property (nonatomic, assign)BOOL invalid;

@property (nonatomic, assign)BOOL sign;

@property (nonatomic, assign)BOOL hasSign;

@property (nonatomic, strong)NSNumber *sdkUserId;

+ (instancetype)instanceWithDict:(NSDictionary *)dict;

- (NSDictionary *)titlesAndOperateTypes;

@end
