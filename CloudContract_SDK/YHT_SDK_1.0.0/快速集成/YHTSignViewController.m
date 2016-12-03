//
//  YHTSignListViewController.m
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/10.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import "YHTSignViewController.h"
#import "UIImage+Wqz.h"
#import "YHT_MBProgressHUD+Wqz.h"
#import "YHTSign.h"
#import "YHTSignView.h"
@interface YHTSignViewController ()<YHTHttpRequestDelegate>
@property (nonatomic, strong)YHTSign *sign;
@property (nonatomic, strong)YHTSignView *signView;
@end

@implementation YHTSignViewController
+ (instancetype)instance{
    YHTSignViewController *__vc = [[YHTSignViewController alloc] init];

    return __vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"签名列表";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imagesNamedFromCustomYHTSdkBundle:@"nav_add_h"]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(addSign)];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [YHT_MBProgressHUD showHTTPMessage:@""];
        [[YHTSignManager sharedManager] viewSignatureWithTag:@"ViewSignature"
                                                    delegate:self];
    });
}

- (void)addSign{
    YHTSignMadeViewController *vc = [YHTSignMadeViewController instanceWithDelegate:self];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)deleteSign:(YHTSign *)__sign {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"删除签名"
                                                          message:@"确定要删除该签名吗？"
                                                         delegate:nil
                                                cancelButtonTitle:@"取消"
                                                otherButtonTitles:@"确定", nil];
    [alertView show];
    alertView.delegate = self;
}

#pragma mark - YHTHttpRequestDelegate
- (void)request:(YHTHttpRequest *)request didFailWithError:(NSError *)error{
    [YHT_MBProgressHUD showError:error.localizedDescription];
}

- (void)request:(YHTHttpRequest *)request didFinishLoadingWithResult:(id)result{
    if ([request.tag isEqualToString:@"ViewSignature"]) {
        [YHT_MBProgressHUD hideHUDWithBlock:^{
            self.sign = [YHTSign instanceWithDic:result[@"value"]];
            [self.view addSubview:self.signView];
        }];

    }else if ([request.tag isEqualToString:@"DeleteSignature"]){
        [YHT_MBProgressHUD hideHUDWithBlock:^{
            [_signView removeFromSuperview];
        }];
    }
}

#pragma mark - SignMadeViewDelegate
- (void)onMadeSignSuccessed:(id)__id {
    [[YHTSignManager sharedManager] viewSignatureWithTag:@"ViewSignature"
                                                delegate:self];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        return;
    }else if (buttonIndex == 1){
        [YHT_MBProgressHUD showHTTPMessage:@""];
        [[YHTSignManager sharedManager] deleteSignatureWithTag:@"DeleteSignature"
                                                      delegate:self];
    }
}

#pragma mark - GET/SET
- (YHTSignView *)signView{
    //    if (!_signView) {
    _signView = [YHTSignView instanceWithSign:_sign delegate:self];
    _signView.frame = CGRectMake(0, 64, _kIOS_SCREEN_WIDTH, 100);
    _signView.backgroundColor = [UIColor whiteColor];
    //    }

    return _signView;
}

- (void)setSign:(YHTSign *)sign{
    _sign = sign;
    
}

@end