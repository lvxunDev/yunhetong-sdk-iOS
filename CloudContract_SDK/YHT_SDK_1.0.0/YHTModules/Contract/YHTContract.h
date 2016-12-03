//
//  ContractModel.h
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/17.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHTContract : NSObject

/**
 *  合同ID
 */
@property (nonatomic, strong)NSNumber *contractID;

/**
 *  合同名称
 */
@property (nonatomic, copy)NSString *title;

/**
 *  合同状态
 */
@property (nonatomic, copy)NSString *status;

+ (instancetype)instanceWithDict:(NSDictionary *)dict;

+ (NSMutableArray *)pasingJSONWithDictionary:(NSDictionary *)dict;
@end
