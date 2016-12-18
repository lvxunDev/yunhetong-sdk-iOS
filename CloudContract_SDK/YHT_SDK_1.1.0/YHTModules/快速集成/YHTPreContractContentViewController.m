//
//  YHTPreContractContentViewController.m
//  CloudContract_SDK
//
//  Created by 吴清正 on 2016/12/13.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import "YHTPreContractContentViewController.h"
#import "MBProgressHUD+Wqz.h"
#import "YHTContractWebView.h"
#import "YHTContractPartner.h"
#import "YHTContractPreOperateMenu.h"
#import "UIImage+Wqz.h"
#import "YHTContract.h"

@interface YHTPreContractContentViewController ()<YHTHttpRequestDelegate, ContractPreOperateDelegate>

@property (nonatomic, strong)YHTContractPartner *partner;

@property (nonatomic, strong)YHTContractPreOperateMenu *operateMenu;

@property (nonatomic, strong)YHTContractWebView *webView;

@property (nonatomic, strong)NSNumber *contractID;
@end

@implementation YHTPreContractContentViewController

+ (instancetype)instanceWithContractID:(NSNumber *)contractID{
    YHTPreContractContentViewController *vc = [[YHTPreContractContentViewController alloc] init];
    vc.contractID = contractID;

    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"预览合同";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imagesNamedFromCustomYHTSdkBundle:@"nav_more_n"]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(buttonClick)];


    self.webView = [YHTContractWebView instanceWithContractID:_contractID delegate:nil];
    [self.view addSubview:self.webView];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self webViewRefresh];
    });

}

- (void)buttonClick{
    [self.operateMenu show];
}

- (void)webViewRefresh{
    [self.webView preRefresh];

    [[YHTContractManager sharedManager] preViewContactWithContractID:_contractID
                                                                 tag:@"PreViewContract"
                                                          backParams:nil
                                                            delegate:self];
}

#pragma mark - YHTHttpRequestDelegate
- (void)request:(YHTHttpRequest *)request didFailWithError:(NSError *)error{
    [MBProgressHUD showError:error.localizedDescription];
}

- (void)request:(YHTHttpRequest *)request didFinishLoadingWithResult:(id)result{
    if ([request.tag isEqualToString:@"PreViewContract"]) {
        self.partner = [YHTContractPartner instanceWithDict:result[@"value"][@"partner"]];

    }else if ([request.tag isEqualToString:@"AllSignContract"]){
        [MBProgressHUD showSuccess:@"签署成功"];
//        [self webViewRefresh];
        self.navigationItem.rightBarButtonItem = nil;
    }
}

#pragma mark - GET/SET

- (YHTContractPartner *)partner{
    if (!_partner) {
        _partner = [[YHTContractPartner alloc] init];
    }

    return _partner;
}

- (YHTContractPreOperateMenu *)operateMenu{
//    if (self.partner == nil || [self.partner titlesAndOperateTypes] == nil) {
//        self.navigationItem.rightBarButtonItem = nil;
//        return nil;
//    }

    _operateMenu = [YHTContractPreOperateMenu instanceWithContract:self.partner delegate:self];

    return _operateMenu;
}

#pragma mark - ContractOperateDelegate
- (void)didSelectedOperate:(ContractOperateType)__operateType{
    if(__operateType == ContractOperateType_AllSign){
        [[YHTContractManager sharedManager] allSignContractWithContractID:self.contractID
                                                                      tag:@"AllSignContract"
                                                                 delegate:self];

    }else if (__operateType == ContractOperateType_Cancel) {

        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
