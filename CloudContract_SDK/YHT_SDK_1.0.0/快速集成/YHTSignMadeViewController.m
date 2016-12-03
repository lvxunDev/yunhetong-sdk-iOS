//
//  YHTSignMadeViewController.m
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/9.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import "YHTSignMadeViewController.h"
#import "YHT_PPSSignatureView.h"
#import "UIButton+Wqz.h"
#import "YHT_MBProgressHUD+Wqz.h"
#import "NSData+Base64.h"

@interface YHTSignMadeViewController ()<YHTHttpRequestDelegate>

@property (nonatomic, strong) YHT_PPSSignatureView *signView;

@end

@implementation YHTSignMadeViewController

+ (instancetype)instanceWithDelegate:(id<YHTSignMadeViewDelegate>)delegate{
    YHTSignMadeViewController *__vc = [[YHTSignMadeViewController alloc] init];
    __vc.delegate = delegate;

    return __vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"绘制签名";
    self.view.backgroundColor = [UIColor whiteColor];

    EAGLContext *context = [[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES2];
    if (_kIOS_VERSION >= 8.0) {
        self.signView = [[YHT_PPSSignatureView alloc] initWithFrame:CGRectMake(0, 0, _kIOS_SCREEN_HEIGHT, _kIOS_SCREEN_WIDTH) context:context];
        //            self.signView.height = self.view.width - 44;
    }else{
        self.signView = [[YHT_PPSSignatureView alloc] initWithFrame:CGRectMake(0, 0, _kIOS_SCREEN_WIDTH, _kIOS_SCREEN_HEIGHT) context:context];
        //        self.signView.height = self.view.height - 64;
    }

    [self.view addSubview:self.signView] ;
    self.view.userInteractionEnabled = YES;

    UIButton *__clearButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [__clearButton setTitle:@"清除" forState:UIControlStateNormal];
    [__clearButton setTitle:@"清除" forState:UIControlStateHighlighted];
    [__clearButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [__clearButton setBackgroundColor:_kMAIN_COLOR];
    __clearButton.frame = CGRectMake(self.signView.frame.size.width - 60, self.signView.frame.size.height - 40, 50, 30);
    [__clearButton wqz_setButtonRadius:5.0f withColor:_kMAIN_COLOR withWidth:1.0f];
    [__clearButton addTarget:self action:@selector(clearSignEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:__clearButton];

    UIButton *__adopButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [__adopButton setTitle:@"采用" forState:UIControlStateNormal];
    [__adopButton setTitle:@"采用" forState:UIControlStateHighlighted];
    [__adopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [__adopButton setBackgroundColor:_kMAIN_COLOR];
    __adopButton.frame = CGRectMake(self.signView.frame.size.width - 60, self.signView.frame.size.height - 40 - 40, 50, 30);
    [__adopButton wqz_setButtonRadius:5.0f withColor:_kMAIN_COLOR withWidth:1.0f];
    [__adopButton addTarget:self action:@selector(saveSignEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:__adopButton];
}

- (void)clearSignEvent:(id)sender {
    [self.signView erase];
}

- (void)saveSignEvent:(id)sender {
//    [YHT_MBProgressHUD showHTTPMessage:@""];

    NSString *signStr = [UIImagePNGRepresentation(self.signView.signatureImage) base64EncodedString];

    NSString *baseString = (__bridge NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                         (CFStringRef)signStr,
                                                                                         NULL,
                                                                                         CFSTR(":/?#[]@!$&’()*+,;="),
                                                                                         kCFStringEncodingUTF8);

    if (!baseString) {
        UIAlertView *_alertView = [[UIAlertView alloc] initWithTitle:@"签名不能为空"
                                                             message:@"签名不能为空"
                                                            delegate:self
                                                   cancelButtonTitle:@"确定"
                                                   otherButtonTitles:nil];
        [_alertView show];
        return;
    }

    [[YHTSignManager sharedManager] generateSignatureWithSignData:baseString
                                                           tag:@"GenerateSignature"
                                                      delegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    if (_kIOS_VERSION >= 8.0) {
        CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
        [UIView animateWithDuration:duration animations:^{
            //View controller-based status bar appearance 设置为NO，否则状态栏不消失
            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];

            self.navigationController.view.transform = CGAffineTransformIdentity;
            self.navigationController.view.transform = CGAffineTransformMakeRotation(M_PI / 2);
            self.navigationController.view.bounds = CGRectMake(0, 0, _kIOS_SCREEN_HEIGHT, _kIOS_SCREEN_WIDTH);
        }];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    [UIView animateWithDuration:duration animations:^{
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
        self.navigationController.view.transform = CGAffineTransformIdentity;
        self.navigationController.view.transform = [self accessToTheSizeOfTheRotatingAngle];
        self.navigationController.view.bounds = CGRectMake(0, 0, _kIOS_SCREEN_WIDTH, _kIOS_SCREEN_HEIGHT);
    }];
}

//获取需要旋转角度的大小
- (CGAffineTransform)accessToTheSizeOfTheRotatingAngle{
    //获取当前状态栏的方向
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;

    //根据当前状态栏的方向，获取需要旋转的角度的大小
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        return CGAffineTransformMakeRotation(M_PI*1.5);
    } else if (orientation == UIInterfaceOrientationLandscapeRight) {
        return CGAffineTransformMakeRotation(M_PI/2);
    } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return CGAffineTransformMakeRotation(-M_PI);
    } else {
        return CGAffineTransformIdentity;
    }
}

#pragma mark - YHTHttpRequestDelegate
-(void)request:(YHTHttpRequest *)request didFinishLoadingWithResult:(id)result{
    [self.delegate onMadeSignSuccessed:self];
    if ([request.tag isEqualToString:@"GenerateSignature"]) {
        [YHT_MBProgressHUD hideHUDWithBlock:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    }
}

- (void)request:(YHTHttpRequest *)request didFailWithError:(NSError *)error{
    if ([request.tag isEqualToString:@"GenerateSignature"]) {
        [YHT_MBProgressHUD hideHUDWithBlock:^{
            [YHT_MBProgressHUD showError:error.localizedDescription];
        }];
    }
}

@end
