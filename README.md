# 云合同 SDK iOS 集成文档
---
[TOC]
>注：本文为云合同 iOS SDK 的使用教程，默认读者已经熟悉Xcode开发工具的基本使用方法。

### 1. 集成准备
##### 1.1 获取 AppId
登录云合同 SDK 开发者平台，注册应用，获得 `AppId`。
##### 1.2 在你的工程中引入 SDK
<!--下载[云合同SDK][1]并解压缩-->
 Installation with CocoaPods：  pod 'CloudContract_SDK', '~> 1.1.1’
##### 1.3 导入 SDK
a. 在 `Info.plist` 中加入 `App Transport Security Settings` 设置 `Allow Arbitrary Loads` 值为 YES；

b. 如果你的项目中引用了 `NSData+Base64`, 在 `TARGETS` - `Build Phases` - `Compile Sources` 中删除 `NSData+Base64.m` 即可；

### 2. 基本功能集成
#### 2.1 基本功能集成准备
开发者需要自己实现 ```YHTSDKDemoTokenListener``` 类，该类的主要作用是获取 `token`，且在 `token` 失效时能自动去重新获取 `token` ，并将该类设置为单例（参照 Demo ）。

* 第三方 APP 实现获取 `token` 的方法，```resetTokenBlock``` 回调中实现该操作，代码示例如下，详情见Demo

```
- (void)getTokenWithCompletionHander:(ResetTokenBlock)resetTokenBlock{
	//异步获取'token'字符串并返回，TODU...
	resetTokenBlock(responseObject);
}

```

* 第三方 APP 在获取到 `token` 后，设置 `token` ，在方法 ```- (void)getTokenWithCompletionHander:(ResetTokenBlock)resetTokenBlock``` 中实现该操作，代码示例如下，详情见 Demo

```
    [self getTokenWithCompletionHander:^(id obj) {
        self.tokenStr = obj[@"value"][@"token"];
        [YHTSdk setToken:_tokenStr];
        [httpRequest startRequest];
    }];
```

* 如果 `token`超时，需要在 ```AppDelegate.m``` 中，设置 `token` 超时回调代理，调用下面这个方法，```+ (void)setResetTokenDelegate:(id)delegate;``` 代码示例如下，详情见 Demo

``` 
    [YHTSdk setResetTokenDelegate:[YHTSDKDemoTokenListener sharedManager]];
```
    
* 在 ```YHTSDKDemoTokenListener.m``` 中，实现 ```YHTResetTokenDelegate``` 中定义的协议方法 ```- (void)resetTokenWithHtttpRequest:(YHTHttpRequest *)httpRequest```，在 `token` 失效时能自动去重新获取 `token`，代码示例如下，详情见 Demo

```
- (void)resetTokenWithHtttpRequest:(YHTHttpRequest *)httpRequest{
    [self getTokenWithCompletionHander:^(id obj) {
        self.tokenStr = obj[@"value"][@"token"];
        [YHTSdk setToken:_tokenStr];
        [httpRequest startRequest];
    }];
    
}
```
#### 2.2 SDK的基本功能集成
##### 2.2.1 快速集成
* 快速集成合同的**查看**、**签署**、**作废**功能，可使用此 SDK 提供的 ```YHTContractContentViewController```，详情参考Demo

```
    YHTContractContentViewController *vc = [YHTContractContentViewController instanceWithContractID:contract.contractID];
    [self.navigationController pushViewController:vc animated:YES];
```
* 快速集成签名的**查看**、**删除**功能，可使用 SDK 提供的 ```YHTSignViewController```，详情参考Demo

```
	YHTSignViewController *vc = [YHTSignViewController instance];
	[self.navigationController pushViewController:vc animated:YES];
```

* 快速集成签名的**绘制**功能，可使用 SDK 提供的 ```YHTSignMadeViewController```，详情参考Demo

```
	YHTSignMadeViewController *vc = [YHTSignMadeViewController instanceWithDelegate:self];
	[self.navigationController pushViewController:vc animated:YES];
```
##### 2.2.2 自定义集成
**云合同合同管理模块** 指用户在第三方 APP 对合同进行操作的功能。开发者只需要调用SDK提供的 ```YHTContractManager``` 类中方法，即可完成包括合同**查看**、**签署**、**作废**功能。

合同详情页面,为 UIWebView 展示直接展示 url 地址, 示例url地址： http://sdk.yunhetong.com/sdk/contract/mobile/view?contractId=1612211728205000&token=TGT-10105-5wt5KL5xuwGLjEUBXxfESsv65Dsv65eAqhzta6uT5mpiVzZvdp-cas01.example.org

```
/**
 *  根据'contractID'直接展示拼接的 url 地址在’UIWebView‘展示即可，
 *
 **/      
- (void)refresh{
    NSMutableString *__urlStr = [NSMutableString stringWithString:[YHTConstants urlByHost:kViewWebContract_URL]];
    [__urlStr appendFormat:@"?contractId=%ld", [self.contractID longValue]];
    [__urlStr appendFormat:@"&token=%@", [YHTTokenManager sharedManager].token];

    self.contractURL = [NSURL URLWithString:__urlStr];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLRequest *__request = [NSURLRequest requestWithURL:self.contractURL
                                               cachePolicy:NSURLRequestReloadIgnoringCacheData
                                           timeoutInterval: 20.0];
    [self loadRequest:__request];
}
```

第三方应用可实现 YHTHttpRequestDelegate 中的两个协议方法来监听此次 HTTP 请求，方法如下：

```
/**
 *  收到一个来自云合同'HTTP'请求成功的响应
 *
 *  @param request  具体的请求对象
 *  @param result   请求的返回结果
 */
- (void)request:(YHTHttpRequest *)request didFinishLoadingWithResult:(id)result;

/**
 *  收到一个来自云合同'HTTP'请求失败的响应
 *
 *  @param request  具体的请求对象
 *  @param error    请求的错误信息
 */
- (void)request:(YHTHttpRequest *)request didFailWithError:(NSError *)error;

```

* 合同查看  指在 SDK 客户端中点击查看合同进入合同查看页面。
	
```
/**
 *  查看合同
 *
 *  @param contractID  需要查看合同的编号
 *  @param tag         用户自定义'tag'，用于区分回调'request'
 *  @param delegate    YHTHttpRequestDelegate对象，用于接收云合同SDK对于发起的接口请求的请求响应
 */
- (void)viewContactWithContractID:(NSNumber *)contractID
                              tag:(NSString *)tag
                         delegate:(id<YHTHttpRequestDelegate>)delegate;
                         
```

* 合同签署  指云合同根据用户签名信息替换占位符完成签署的功能或者根据自动签署标识自动完成签署的功能。

```
/**
 *  签署合同
 *
 *  @param contractID  需要签署合同的编号
 *  @param tag         用户自定义'tag'，用于区分回调'request'
 *  @param delegate    YHTHttpRequestDelegate对象，用于接收云合同SDK对于发起的接口请求的请求响应
 */
- (void)signContractWithContractID:(NSNumber *)contractID
                               tag:(NSString *)tag
                          delegate:(id<YHTHttpRequestDelegate>)delegate;

```
* 合同作废 指用户对至少有一人已签署但尚未签署完成的合同执行作废的功能。

```
/**
 *  作废合同
 *
 *  @param contractID  需要作废合同的编号
 *  @param tag         用户自定义'tag'，用于区分回调'request'
 *  @param delegate    YHTHttpRequestDelegate对象，用于接收云合同SDK对于发起的接口请求的请求响应
 */
- (void)invalidContractWithContractID:(NSNumber *)contractID
                                  tag:(NSString *)tag
                             delegate:(id<YHTHttpRequestDelegate>)delegate;
```

**合同管理模块示例如下，详情见Demo**

```
//合同查看
[[YHTContractManager sharedManager] viewContactWithContractID:_contractID
                                                          tag:@"ViewContract"
                                                     delegate:self];

//合同签署
[[YHTContractManager sharedManager] signContractWithContractID:self.contractID
                                                           tag:@"SignContract"
                                                      delegate:self];
//合同作废                                              
[[YHTContractManager sharedManager] invalidContractWithContractID:self.contractID
                                                              tag:@"InvalidContract"
                                                         delegate:self];                    
                                                         
#pragma mark - YHTHttpRequestDelegate
 
//请求失败
- (void)request:(YHTHttpRequest *)request didFailWithError:(NSError *)error{
    //合同查看、签署、作废失败，TODU...

}

//请求成功
- (void)request:(YHTHttpRequest *)request didFinishLoadingWithResult:(id)result{
    if ([request.tag isEqualToString:@"ViewContract"]) {
		//合同查看，TODU...
	
    }else if ([request.tag isEqualToString:@"SignContract"]){
		//合同签署，TODU...

    }else if ([request.tag isEqualToString:@"InvalidContract"]){
		//合同作废，TODU...
		
    }
}

```

**云合同签名管理模块** 指用户在第三方 APP 对用户的签名进行操作的功能。开发者只需要调用SDK提供的 ```YHTSignManager``` 类中方法，即可完成签名**查看**，**绘制**及**删除**功能。

第三方应用可实现 ```YHTHttpRequestDelegate``` 中的两个协议方法来监听 HTTP 请求，方法同上；

* 签名查看 指用户查看自己签名的功能

```
/**
 *  查看签名,用户查看自己的签名
 *
 *  @param tag         用户自定义'tag'，用于区分回调'request'
 *  @param delegate    YHTHttpRequestDelegate对象，用于接收云合同SDK对于发起的接口请求的请求响应
 */
- (void)viewSignatureWithTag:(NSString *)tag
                    delegate:(id<YHTHttpRequestDelegate>)delegate;

```

* 签名绘制 指用户绘制签名，并可对绘制签名执行采用或清除的功能

```
/**
 *  绘制签名, 用户绘制签名
 *
 *  @param signData    签名信息
 *  @param tag         用户自定义'tag'，用于区分回调'request'
 *  @param delegate    YHTHttpRequestDelegate对象，用于接收云合同SDK对于发起的接口请求的请求响应
 */
- (void)generateSignatureWithSignData:(NSString *)signData
                                  tag:(NSString *)tag
                             delegate:(id<YHTHttpRequestDelegate>)delegate;
```

* 签名删除 指用户在签名管理页对没有签署过的签名进行删除的功能

```
/**
 *  删除签名, 用户对未签署过的签名进行删除
 *
 *  @param tag         用户自定义'tag'，用于区分回调'request'
 *  @param delegate    YHTHttpRequestDelegate对象，用于接收云合同SDK对于发起的接口请求的请求响应
 */
- (void)deleteSignatureWithTag:(NSString *)tag
                      delegate:(id<YHTHttpRequestDelegate>)delegate;
```


**签名管理模块示例如下，详情见Demo**

```
//签名查看
[[YHTSignManager sharedManager] viewSignatureWithTag:@"ViewSignature"
                                            delegate:self];
                                                    
//签名生成
[[YHTSignManager sharedManager] generateSignatureWithSignData:signStr
                                                          tag:@"GenerateSignature"
                                                     delegate:self];
                                                         
//签名删除                                                 
[[YHTSignManager sharedManager] deleteSignatureWithTag:@"DeleteSignature"
                                              delegate:self];
                                                  
#pragma mark - YHTHttpRequestDelegate

//请求失败
- (void)request:(YHTHttpRequest *)request didFailWithError:(NSError *)error{
    //签名查看、删除、生成失败，TODU...
    
}

//请求成功
- (void)request:(YHTHttpRequest *)request didFinishLoadingWithResult:(id)result{
    if ([request.tag isEqualToString:@"ViewSignature"]) {
		//签名查看，TODU...

    }else if ([request.tag isEqualToString:@"DeleteSignature"]){
		//签名删除，TODU...
        
    }else if ([request.tag isEqualToString:@"GenerateSignature"]) {
	  	//签名生成，TODU...
	  	
    }
}

```
### 3. 主要类的相关说明

Class | Class description 
------------ | ------------- 
YhtSdk| SDK的入口类。提供SDK初始化，'token'初始化，相关请求的方法。
YHTContractManager | 合同管理类，提供合同**查看**、**签署**、**作废**功能
YHTSignManager | 签名管理类，提供签名**查看**、**绘制**、**删除**功能
YHTTokenManager	| 'token'管理类。提供'token'生成、刷新、判断是否失效功能
YHTContractContentViewController|	合同详情 ViewController，集成了合同**查看**、**签署**、**作废**功能
YhtSignMadeViewController	|签名绘制 ViewController，集成了签名**生成**功能
YHTSignViewController|	签名管理 ViewController，提供了签名**删除**、**查看**功能
YHTConstants|SDK常量类，包含请求 URL 常量等
YHTError|	SDK自定义错误信息类
YHTHttpRequest	|SDK自定义请求类


  [1]: http://sdk.yunhetong.com/sdk/open/userApp/appManageView
