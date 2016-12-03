//
//  YHTContractContentViewController.m
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/10.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import "YHTContractContentViewController.h"
#import "YHT_MBProgressHUD+Wqz.h"
#import "YHTContractWebView.h"
#import "YHTContractPartner.h"
#import "YHTContractOperateMenu.h"
#import "UIImage+Wqz.h"
#import "YHTContract.h"
@interface YHTContractContentViewController ()<YHTHttpRequestDelegate>

@property (nonatomic, strong)YHTContractPartner *partner;

@property (nonatomic, strong)YHTContractOperateMenu *operateMenu;

@property (nonatomic, strong)YHTContractWebView *webView;

@property (nonatomic, strong)NSNumber *contractID;
@end

@implementation YHTContractContentViewController

+ (instancetype)instanceWithContractID:(NSNumber *)contractID{
    YHTContractContentViewController *vc = [[YHTContractContentViewController alloc] init];
    vc.contractID = contractID;

    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"签署合同";
    self.view.backgroundColor = [UIColor whiteColor];
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
    [self.webView refresh];

    [[YHTContractManager sharedManager] viewContactWithContractID:_contractID
                                                              tag:@"ViewContract"
                                                         delegate:self];

}

- (void)rightBarButtonItemRefresh{
    if (self.partner.invalid == NO && self.partner.sign == NO) {
        self.navigationItem.rightBarButtonItem = nil;
    }else{
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imagesNamedFromCustomYHTSdkBundle:@"nav_more_n"]
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self
                                                                                 action:@selector(buttonClick)];
    }

}

#pragma mark - YHTHttpRequestDelegate
- (void)request:(YHTHttpRequest *)request didFailWithError:(NSError *)error{
    [YHT_MBProgressHUD showError:error.localizedDescription];
}

- (void)request:(YHTHttpRequest *)request didFinishLoadingWithResult:(id)result{
    if ([request.tag isEqualToString:@"ViewContract"]) {
        self.partner = [YHTContractPartner instanceWithDict:result[@"value"][@"partner"]];
        [self rightBarButtonItemRefresh];
    }else if ([request.tag isEqualToString:@"SignContract"]){
        [YHT_MBProgressHUD showSuccess:@"签署成功"];
        [self webViewRefresh];
    }else if ([request.tag isEqualToString:@"InvalidContract"]){
        [YHT_MBProgressHUD showSuccess:@"作废成功"];
        [self webViewRefresh];
        [self rightBarButtonItemRefresh];
    }
}

#pragma mark - GET/SET
- (YHTContractPartner *)partner{
    if (!_partner) {
        _partner = [[YHTContractPartner alloc] init];
    }

    return _partner;
}

- (YHTContractOperateMenu *)operateMenu{
    if (self.partner == nil || [self.partner titlesAndOperateTypes] == nil) {
        self.navigationItem.rightBarButtonItem = nil;
        return nil;
    }

    _operateMenu = [YHTContractOperateMenu instanceWithContract:self.partner delegate:self];

    return _operateMenu;
}

#pragma mark - ContractOperateDelegate
- (void)didSelectedOperate:(ContractOperateType)__operateType{
    if(__operateType == ContractOperateType_Sign){
        [[YHTContractManager sharedManager] signContractWithContractID:self.contractID
                                                                   tag:@"SignContract"
                                                              delegate:self];

    }else if (__operateType == ContractOperateType_Invalid) {
        [[YHTContractManager sharedManager] invalidContractWithContractID:self.contractID
                                                                      tag:@"InvalidContract"
                                                                 delegate:self];
        
    }
}

- (void)didPushWithViewController{
    [self.navigationController pushViewController:[YHTSignMadeViewController instanceWithDelegate:self] animated:YES];
}

- (void)onMadeSignSuccessed:(id)__id{
    [[YHTContractManager sharedManager] signContractWithContractID:self.contractID
                                                               tag:@"SignContract"
                                                          delegate:self];
}
@end
