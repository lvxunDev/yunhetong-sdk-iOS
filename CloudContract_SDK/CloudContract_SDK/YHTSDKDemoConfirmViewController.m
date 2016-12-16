//
//  YHTSDKDemoConfirmViewController.m
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/6/7.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import "YHTSDKDemoConfirmViewController.h"
#import "YHTSdk.h"
#import "YHT_MBProgressHUD+Wqz.h"
#import "YHTSDKDemoTokenListener.h"
@interface YHTSDKDemoConfirmViewController ()
@property (nonatomic, strong)NSNumber *contractID;
@end

@implementation YHTSDKDemoConfirmViewController

+ (instancetype)instanceWithIsPreView:(BOOL)__isPreView{
    YHTSDKDemoConfirmViewController *__vc = [[YHTSDKDemoConfirmViewController alloc] init];
    __vc.isPreView = __isPreView;

    return __vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"确认业务细节";
    [self setRadiusAndBorderWithButton:self.confirmBtn];

    if (self.isPreView) {
        [self.confirmBtn setTitle:@"预览合同" forState:UIControlStateNormal];
    }

}

- (IBAction)confirmBtn_Action:(id)sender {

    [YHT_MBProgressHUD showHTTPMessage:@""];

    [[YHTSDKDemoTokenListener sharedManager] getTokenContractWithCompletionHander:^(id obj) {
        [[YHTTokenManager sharedManager] setTokenWithString:obj[@"token"]];
        self.contractID = obj[@"contractId"];

        if (self.isPreView) {
            //预览合同
            [self.navigationController pushViewController:[YHTPreContractContentViewController instanceWithContractID:_contractID] animated:YES];
            [self.confirmBtn setTitle:@"预览合同" forState:UIControlStateNormal];
        }else{
            //查看合同
            [self.navigationController pushViewController:[YHTContractContentViewController instanceWithContractID:_contractID] animated:YES];
        }

    }];


    /*
    [[YHTSDKDemoTokenListener sharedManager] getTokenContractWithCompletionHander:^(id obj) {
        if ([obj[@"key"] isEqualToValue:[NSNumber numberWithInteger:200]]) {
            [[YHTTokenManager sharedManager] setTokenWithString:obj[@"value"][@"token"]];
            self.contractID = obj[@"value"][@"contractId"];
            YHTContractContentViewController *vc = [YHTContractContentViewController instanceWithContractID:_contractID];
            vc.title= @"签署合同";
            [self.navigationController pushViewController:vc animated:YES];

        }else{
            [YHT_MBProgressHUD showError:obj[@"message"]];

        }
    }];
     */

}

- (void)setRadiusAndBorderWithButton:(UIButton *)button{
    button.layer.cornerRadius = 8.0f;
    button.layer.masksToBounds = YES;
    button.layer.borderWidth = 1.0f;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

@end
