//
//  ContractOperateMenu.m
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/17.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import "YHTContractOperateMenu.h"
#import "YHTContract.h"
#import "BasePopMenu.h"
#import "BasePopTableView.h"
#import "YHTConstants.h"
@interface YHTContractOperateMenu ()<BasePopTableViewDelegate>

@property (nonatomic, strong)YHTContractPartner *partner;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)BasePopMenu *popMenu;
@property (nonatomic, strong)NSMutableArray *data;
@property (nonatomic, strong)NSMutableArray *operateTypes;
@property (nonatomic, strong)NSIndexPath *indexPath;

@property (nonatomic, weak)id<ContractOperateDelegate> delegate;

@end
@implementation YHTContractOperateMenu

+ (instancetype)instanceWithContract:(YHTContractPartner *)__partner delegate:(id<ContractOperateDelegate>)__delegate {
    YHTContractOperateMenu *__menu = [[YHTContractOperateMenu alloc] init];
    __menu.partner = __partner;
    __menu.delegate = __delegate;

    return __menu;
}

- (void)show {
    [self.tableView reloadData];
    [self.popMenu showInRect:CGRectMake(_kIOS_SCREEN_WIDTH - 120 - 2, 64 - 4, 120, self.data.count * 40 + 16)];
}

#pragma mark - BasePopTableViewDelegate
- (void)popTableView:(UITableView *)__tableView didSelectRowAtIndexPath:(NSIndexPath *)__indexPath {
    [self.popMenu dismiss];
    
    self.indexPath = __indexPath;
    ContractOperateType operateType = [self.operateTypes[_indexPath.row] integerValue];

    NSString *str = operateType == ContractOperateType_Sign? @"确认签署" : @"确认作废";

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:str
                                                        message:[NSString stringWithFormat:@"是否%@？",str]
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确认",
                              nil];
    [alertView show];

}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        return;
    }else{
        if (!self.partner.hasSign) {
            [self.delegate didPushWithViewController];
            return;
        }
        [self.delegate didSelectedOperate:[self.operateTypes[_indexPath.row] integerValue]];
    }

}

#pragma Get Set
- (BasePopMenu *)popMenu {
    if (_popMenu == nil) {
        _popMenu = [[BasePopMenu alloc ] initWithContentView:self.tableView];
        _popMenu.delegate = nil;
        _popMenu.arrowPosition = BasePopMenuArrowPositionRight;
    }
    return _popMenu;
}

- (UITableView *)tableView {
    _tableView = [BasePopTableView instanceWithData:self.data operateType:self.operateTypes delegate:self];

    return _tableView;
}

- (void)setPartner:(YHTContractPartner *)partner{
    _partner = partner;
    NSDictionary *__dic = [_partner titlesAndOperateTypes];
    if(__dic){
        self.data = __dic[@"titles"];
        self.operateTypes = __dic[@"types"];
    }else{
        self.data = nil, self.operateTypes = nil;
    }
}
@end

