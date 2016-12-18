//
//  ContractModel.m
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/17.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import "YHTContract.h"

@implementation YHTContract

+ (instancetype)instanceWithDict:(NSDictionary *)dict{
    YHTContract *_contract = [[YHTContract alloc] init];
    _contract.contractID = dict[@"id"];
    _contract.title = dict[@"title"];
    _contract.status = dict[@"status"];

    return _contract;
}

+ (NSMutableArray *)pasingJSONWithDictionary:(NSDictionary *)dict{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in dict[@"contractList"]) {
        YHTContract *contract = [YHTContract instanceWithDict:dic];
        [dataArray addObject:contract];
    }

    return dataArray;
}
@end
