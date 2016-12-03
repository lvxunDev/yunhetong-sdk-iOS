//
//  YHTWebView.m
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/12.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import "BaseWebView.h"
#import "YHT_NJKWebViewProgressView.h"
#import "YHT_NJKWebViewProgress.h"

@interface BaseWebView ()<UIWebViewDelegate, NJKWebViewProgressDelegate>

@end

@implementation BaseWebView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupScrollView];
        [self setupProgress];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupScrollView];
    [self setupProgress];
}

- (void)setupScrollView {
    self.scrollView.bounces = NO ;
    self.scalesPageToFit = YES;
    self.scrollView.showsHorizontalScrollIndicator = YES;
    self.scrollView.showsVerticalScrollIndicator = YES;
    for (int i = 0; i < self.scrollView.subviews.count ; i++) {
        UIView *__subView = [self.scrollView.subviews objectAtIndex:i];
        if ([__subView isKindOfClass:[UIImageView class]]) {
            __subView.hidden = YES ;
        }
    }
}

- (void)setupProgress {
    self.progressProxy = [[YHT_NJKWebViewProgress alloc] init];
    self.delegate = self.progressProxy;
    self.progressProxy.webViewProxyDelegate = self;
    self.progressProxy.progressDelegate = self;

    self.progressView = [[YHT_NJKWebViewProgressView alloc] initWithFrame:CGRectZero];

    self.progressView.frame = CGRectMake(0, 64, self.frame.size.width, 2);
    self.progressView.progressBarView.alpha = 0.0f;
    [self addSubview:self.progressView];
}


#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(YHT_NJKWebViewProgress *)webViewProgress updateProgress:(float)progress {
    [self.progressView setProgress:progress animated:YES];
}

@end
