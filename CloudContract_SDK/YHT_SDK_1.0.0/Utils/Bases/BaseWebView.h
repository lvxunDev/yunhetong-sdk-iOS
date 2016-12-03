//
//  YHTWebView.h
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/12.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHT_NJKWebViewProgress;
@class YHT_NJKWebViewProgressView;

@interface BaseWebView : UIWebView

@property (nonatomic, strong)YHT_NJKWebViewProgressView *progressView;

@property (nonatomic, strong)YHT_NJKWebViewProgress *progressProxy;

@end
