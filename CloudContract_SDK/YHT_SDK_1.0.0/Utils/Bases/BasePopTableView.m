//
//  BasePopTableView.m
//  CloudContract
//
//  Created by 邬一平 on 15/5/11.
//  Copyright (c) 2015年 邬一平. All rights reserved.
//

#import "BasePopTableView.h"
#import "UIImage+Wqz.h"
#import "YHTContractPartner.h"
@interface BasePopTableView () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation BasePopTableView

+ (instancetype)instanceWithData:(NSArray *)__data delegate:(id<BasePopTableViewDelegate>) __popDelegate{
    BasePopTableView *__tableView = [[BasePopTableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    __tableView.data = __data;
    __tableView.popDelegate = __popDelegate;

    __tableView.delegate = __tableView;
    __tableView.backgroundColor = [UIColor clearColor];
    __tableView.dataSource = __tableView;
    __tableView.scrollEnabled = NO;

    return __tableView;
}

+ (instancetype)instanceWithData:(NSArray *)__data operateType:(NSArray *)__typeArr delegate:(id<BasePopTableViewDelegate>) __popDelegate{
    BasePopTableView *__tableView = [[BasePopTableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    __tableView.data = __data;
    __tableView.typeArr = __typeArr;
    __tableView.popDelegate = __popDelegate;

    __tableView.delegate = __tableView;
    __tableView.backgroundColor = [UIColor clearColor];
    __tableView.dataSource = __tableView;
    __tableView.scrollEnabled = NO;

    return __tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"BasePopTableView";
    UITableViewCell *__cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!__cell) {
        __cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        __cell.textLabel.textColor = [UIColor grayColor];
        __cell.backgroundColor = [UIColor clearColor];
        UIView *__selectedBG = [[UIView alloc] initWithFrame:__cell.bounds];
        __selectedBG.backgroundColor = [UIColor lightGrayColor];
        __cell.selectedBackgroundView = __selectedBG;
        if (self.typeArr) {
            __cell.imageView.image = [self image4ContractOperateType:[self.typeArr[indexPath.row] integerValue]];
        }

    }

    if([self.popDelegate respondsToSelector:@selector(popTableView: cell: indexPath:)]){
        [self.popDelegate popTableView:tableView cell:__cell indexPath:indexPath];
    }

    __cell.textLabel.text = self.data[indexPath.row];
    return __cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if ([self.popDelegate respondsToSelector:@selector(popTableView: didSelectRowAtIndexPath:)]) {
        [self.popDelegate popTableView:tableView didSelectRowAtIndexPath:indexPath];
    }

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }

    if ([cell  respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }

    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (UIImage *)image4ContractOperateType:(NSInteger)__type {
    if (__type == ContractOperateType_Sign) {
        return [UIImage imagesNamedFromCustomYHTSdkBundle:@"operate_sign"];

    }else if(__type == ContractOperateType_Invalid){
        return [UIImage imagesNamedFromCustomYHTSdkBundle:@"operate_invalid"];

    }

    return nil;
}

@end
