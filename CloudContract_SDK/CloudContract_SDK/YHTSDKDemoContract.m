//
//  Contract.m
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/16.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import "YHTSDKDemoContract.h"

@implementation YHTSDKDemoContract

+ (instancetype)instanceWithDict:(NSDictionary *)dict{
    YHTSDKDemoContract *_contract = [[YHTSDKDemoContract alloc] init];
    _contract.contractID = dict[@"id"];
    _contract.title = dict[@"title"];
    _contract.status = dict[@"status"];

    return _contract;
}

+ (NSMutableArray *)pasingJSONWithDictionary:(NSDictionary *)dict{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in dict[@"contractList"]) {
        YHTSDKDemoContract *contract = [YHTSDKDemoContract instanceWithDict:dic];
        [dataArray addObject:contract];
    }

    return dataArray;
}

@end
