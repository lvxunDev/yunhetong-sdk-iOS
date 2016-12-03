//
//  CCError.h
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/16.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHTError : NSObject{
    NSString *_errorMsg;
}

+ (instancetype)instanceWithErrorMsg:(NSString *)__msg;

+ (instancetype)instance;

- (id)initWithErrorMsg:(NSString *)__errorMsg;

- (NSString *)localizedDescription;
@end
