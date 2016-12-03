//
//  YHTSDKDemoRootViewController.m
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/6/6.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import "YHTSDKDemoShowViewController.h"

#import "YHTSDKDemoContractListViewController.h"
#import "YHTSDKDemoConfirmViewController.h"
#import "YHTSdk.h"
#import "YHT_MBProgressHUD+Wqz.h"
#import "YHTSDKDemoTokenListener.h"
#import "YHTSDKDemoContract.h"
@interface YHTSDKDemoShowViewController ()
@property (nonatomic, strong)NSMutableArray *contractArray;
@end

@implementation YHTSDKDemoShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"云合同SDK演示Demo";

    self.button_partyA.layer.cornerRadius = 8.0f;
    self.button_partyA.layer.masksToBounds = YES;
    self.button_partyA.layer.borderWidth = 1.0f;
    self.button_partyA.layer.borderColor = [UIColor lightGrayColor].CGColor;

    [self setRadiusAndBorderWithButton:self.button_partyA];
    [self setRadiusAndBorderWithButton:self.button_partyB];
}


- (IBAction)partyA_Action:(id)sender {
    YHTSDKDemoConfirmViewController *vc = [[YHTSDKDemoConfirmViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)partyB_Action:(id)sender {
    [YHT_MBProgressHUD showHTTPMessage:@""];
    [[YHTSDKDemoTokenListener sharedManager] getTokenWithCompletionHander:^(id obj) {
        /*
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"tokenStr"
                                                            message:obj[@"value"][@"token"]
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];
         */
        [[YHTTokenManager sharedManager] setTokenWithString:obj[@"value"][@"token"]];
        self.contractArray = [YHTSDKDemoContract pasingJSONWithDictionary:obj[@"value"]];
        YHTSDKDemoContractListViewController *vc = [YHTSDKDemoContractListViewController instanceWithContractArray:_contractArray];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)setRadiusAndBorderWithButton:(UIButton *)button{
    button.layer.cornerRadius = 8.0f;
    button.layer.masksToBounds = YES;
    button.layer.borderWidth = 1.0f;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

@end
