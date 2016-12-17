//
//  CCError.m
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/16.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import "YHTError.h"

@implementation YHTError

+ (instancetype)instance {
    return [[self alloc] init];
}

+ (instancetype)instanceWithErrorMsg:(NSString *)__msg {
    return [[self alloc] initWithErrorMsg:__msg];
}

- (id)initWithErrorMsg:(NSString *)__errorMsg {
    self = [super init];
    if (self != nil) {
        _errorMsg = __errorMsg;
    }

    return self;
}

- (NSString *)localizedDescription {
    return _errorMsg;
}
@end