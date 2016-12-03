//
//  YHTContractWebView.m
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/17.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import "YHTContractWebView.h"
#import "YHTTokenManager.h"
#import "YHTConstants.h"
#import "YHTContract.h"
@interface YHTContractWebView()

@property (nonatomic, strong)YHTContract *contract;
@property (nonatomic, strong)NSNumber *contractID;

@property (nonatomic, strong)NSURL *contractURL;

@end

@implementation YHTContractWebView
+ (instancetype)instanceWithContractID:(NSNumber *)contractID delegate:(id<ContractWebViewDelegate>)delegate{
    YHTContractWebView *webView = [[YHTContractWebView alloc] initWithFrame:CGRectMake(0, 0, _kIOS_SCREEN_WIDTH, _kIOS_SCREEN_HEIGHT)];
    webView.contractID = contractID;
    webView.contractDelegate = delegate;
    webView.scrollView.bounces=YES;
    webView.scalesPageToFit = YES;

    return webView;
}

- (void)refresh{
    NSMutableString *__urlStr = [NSMutableString stringWithString:[YHTConstants urlByHost:kViewWebContract_URL]];
    [__urlStr appendFormat:@"?contractId=%lld", [self.contractID longValue]];
    [__urlStr appendFormat:@"&token=%@", [YHTTokenManager sharedManager].token];

    self.contractURL = [NSURL URLWithString:__urlStr];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLRequest *__request = [NSURLRequest requestWithURL:self.contractURL
                                               cachePolicy:NSURLRequestReloadIgnoringCacheData
                                           timeoutInterval: 20.0];
    [self loadRequest:__request];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (self.contractDelegate) {
        [self.contractDelegate webViewDidFinishLoad:self];
    }
}

@end
