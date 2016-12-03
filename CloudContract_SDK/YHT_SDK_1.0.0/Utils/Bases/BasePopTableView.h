//
//  BasePopTableView.h
//  CloudContract
//
//  Created by 邬一平 on 15/5/11.
//  Copyright (c) 2015年 邬一平. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BasePopTableViewDelegate;

@interface BasePopTableView : UITableView

@property (nonatomic, strong)NSArray *data;
@property (nonatomic, strong)NSArray *typeArr;
@property (nonatomic, weak)id<BasePopTableViewDelegate> popDelegate;

+ (instancetype)instanceWithData:(NSArray *)__data delegate:(id<BasePopTableViewDelegate>) __popDelegate;
+ (instancetype)instanceWithData:(NSArray *)__data operateType:(NSArray *)__typeArr delegate:(id<BasePopTableViewDelegate>) __popDelegate;
@end

@protocol BasePopTableViewDelegate <NSObject>

@optional
- (void)popTableView:(UITableView *)__tableView didSelectRowAtIndexPath:(NSIndexPath *)__indexPath;
- (void)popTableView:(UITableView *)__tableView cell:(UITableViewCell *)__cell indexPath:(NSIndexPath *)__indexPath;
@end
