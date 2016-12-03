//
//  YHTContractListViewController.m
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/16.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import "YHTSDKDemoContractListViewController.h"
#import "YHTSDKDemoContract.h"
#import "YHT_MBProgressHUD+Wqz.h"
#import "YHTSdk.h"
@interface YHTSDKDemoContractListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)NSArray *dataArray;
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation YHTSDKDemoContractListViewController
+ (instancetype)instanceWithContractArray:(NSArray *)contractArray{
    YHTSDKDemoContractListViewController *vc = [[YHTSDKDemoContractListViewController alloc] init];
    vc.dataArray = contractArray;

    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"合同列表";
    self.tableView  = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.view = self.tableView;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }

    YHTSDKDemoContract  *contract = _dataArray[indexPath.row];
    cell.textLabel.text = contract.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@  %@",contract.contractID, contract.status];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    YHTSDKDemoContract *contract = _dataArray[indexPath.row];
    YHTContractContentViewController *vc = [YHTContractContentViewController instanceWithContractID:contract.contractID];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
