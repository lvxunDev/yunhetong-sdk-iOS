//
//  YHTSignView.h
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/24.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHTSign.h"
@protocol YHTSignViewDelegate;
@interface YHTSignView : UIView

@property (nonatomic, strong)id<YHTSignViewDelegate> delegate;

+ (instancetype)instanceWithSign:(YHTSign *)sign delegate:(id<YHTSignViewDelegate>)delegate;

@end

@protocol YHTSignViewDelegate <NSObject>
@optional
- (void)deleteSign:(YHTSign *)sign;
@end