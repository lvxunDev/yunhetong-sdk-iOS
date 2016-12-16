//
//  PartnerModel.m
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/17.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import "YHTContractPartner.h"

@implementation YHTContractPartner

+ (instancetype)instanceWithDict:(NSDictionary *)dict{
    YHTContractPartner *_model = [[YHTContractPartner alloc] init];
    _model.contractId = dict[@"contractId"];
    _model.invalid = [dict[@"invalid"] boolValue];
    _model.sdkUserId = dict[@"sdkUserId"];
    _model.sign = [dict[@"sign"] boolValue];
    _model.hasSign = [dict[@"hasSign"] boolValue];

    return _model;
}

- (NSDictionary *)titlesAndOperateTypes {

    NSMutableArray *__titles = [NSMutableArray array];
    NSMutableArray *__operateTypes = [NSMutableArray array];

    //签署 && 作废
    if (self.sign && self.invalid) {
        [__titles addObject:@"签署"], [__operateTypes addObject:[NSNumber numberWithInteger:ContractOperateType_Sign]];
        [__titles addObject:@"作废"], [__operateTypes addObject:[NSNumber numberWithInteger:ContractOperateType_Invalid]];
        return @{@"titles":__titles, @"types":__operateTypes};

    } else if (!self.sign && self.invalid) {//作废
        [__titles addObject:@"作废"], [__operateTypes addObject:[NSNumber numberWithInteger:ContractOperateType_Invalid]];
        return @{@"titles":__titles, @"types":__operateTypes};

    }else if (self.sign && !self.invalid) {//签署
        [__titles addObject:@"签署"], [__operateTypes addObject:[NSNumber numberWithInteger:ContractOperateType_Sign]];
        return @{@"titles":__titles, @"types":__operateTypes};

    }

    return nil;
}

- (NSDictionary *)titlesAndPreOperateTypes {

    NSMutableArray *__titles = [NSMutableArray array];
    NSMutableArray *__operateTypes = [NSMutableArray array];

    [__titles addObject:@"签署合同"], [__operateTypes addObject:[NSNumber numberWithInteger:ContractOperateType_AllSign]];
    [__titles addObject:@"取消"], [__operateTypes addObject:[NSNumber numberWithInteger:ContractOperateType_Cancel]];

    return @{@"titles":__titles, @"types":__operateTypes};
}


@end
