# 云合同 SDK iOS 集成文档
---
[TOC]
>注：本文为云合同 iOS SDK 的新手使用教程，默认读者已经熟悉XCode开发工具的基本使用方法。

### 1. 集成准备
##### 1.1 获取 AppId
登录云合同 SDK 开发者平台，注册应用，获取得到 AppId。
##### 1.2 下载 SDK
下载[云合同SDK][1]并解压缩
##### 1.3 导入 SDK
a. 将SDK文件中包含的文件添加到你所建立的工程中。

b. 在工程中引入 SDK 之后，需要在编译时添加 -ObjC 编译选项。
方法：程序 Target -> Buid Settings -> Linking 下 Other Linker Flags 项添加 -ObjC。


### 2. 基本功能集成
#### 2.1 基本功能集成准备
开发者需要自己实现 ```YHTSDKDemoTokenListener``` 类，该类的主要作用是获取'token'，且在'token'失效时能自动去重新获取'token'，并将该类设置单例。

* 第三方 APP 实现获取'token'字符串的方法，```resetTokenBlock``` 中实现该操作，代码示例如下，详情见demo

```
- (void)getTokenWithCompletionHander:(ResetTokenBlock)resetTokenBlock{
	//异步获取'token'字符串并返回，TODU...
	resetTokenBlock(responseObject);
}
```

* 第三方 APP 在获取到'token'字符串后，设置'token'，在方法 ```- (void)getTokenWithCompletionHander:(ResetTokenBlock)resetTokenBlock``` 中实现该操作，代码示例如下，详情见demo

```
    [self getTokenWithCompletionHander:^(id obj) {
        self.tokenStr = obj[@"value"][@"token"];
        [YHTSdk setToken:_tokenStr];
        [httpRequest startRequest];
    }];
```

* 如果'token'超时，需要在 ```AppDelegate.m``` 中，设置'token'超时回调代理，调用下面这个方法，```+ (void)setResetTokenDelegate:(id)delegate;``` 代码示例如下，详情见demo

``` 
    [YHTSdk setResetTokenDelegate:[YHTSDKDemoTokenListener sharedManager]];
```
    
* 在 ```YHTSDKDemoTokenListener.m``` 中，实现 ```YHTResetTokenDelegate``` 中定义的协议方法 ```- (void)resetTokenWithHtttpRequest:(YHTHttpRequest *)httpRequest```，在'token'失效时能自动去重新获取'token'，代码示例如下，详情见demo

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
* 快速集成合同的**查看**、**签署**、**作废**功能，可使用 SDK 提供的 ```YHTContractContentViewController```，详情参考demo

```
    YHTContractContentViewController *vc = [YHTContractContentViewController instanceWithContractID:contract.contractID];
    [self.navigationController pushViewController:vc animated:YES];
```
* 快速集成签名的**查看**、**删除**功能，可使用 SDK 提供的 ```YHTSignViewController```，详情参考demo

```
	YHTSignViewController *vc = [YHTSignViewController instance];
	[self.navigationController pushViewController:vc animated:YES];
```

* 快速集成签名的**绘制**功能，可使用 SDK 提供的 ```YHTSignMadeViewController```，详情参考demo

```
	YHTSignMadeViewController *vc = [YHTSignMadeViewController instanceWithDelegate:self];
	[self.navigationController pushViewController:vc animated:YES];
```
##### 2.2.2 自定义集成
**云合同合同管理模块** 指用户在第三方 APP 对合同进行操作的功能。开发者只需要调用SDK提供的 ```YHTContractManager``` 类中方法，即可完成包括合同**查看**、**签署**、**作废**功能。

第三方应用可实现 YHTHttpRequestDelegate 中的两个协议方法来监听此次 HTTP 请求，方法如下：

```
/**
 *  收到一个来自云合同'HTTP'请求失败的响应
 *
 *  @param request  具体的请求对象
 *  @param error    错误信息
 */

- (void)request:(YHTHttpRequest *)request didFailWithError:(NSError *)error;

/**
 *  收到一个来自云合同'HTTP'请求的响应
 *
 *  @param request  具体的请求对象
 *  @param result   请求的返回结果
 */
- (void)request:(YHTHttpRequest *)request didFinishLoadingWithResult:(id)result;

```

* 合同查看  指在SDK客户端中点击查看合同进入合同查看页面。
	
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

* 合同签署  指云合同根据用户签名信息替换占位符完成签署或根据自动签署标识自动替用户完成签署的功能。

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
* 合同作废 指对接用户对至少有一人已签署但尚未签署完成的合同执行的作废的功能。

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

**合同管理模块示例如下，详情见demo**

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


**云合同签名管理模块** 指用户在第三方 APP 对用户的签名信息进行操作的功能。开发者只需要调用SDK提供的 ```YHTSignManager``` 类中方法，即可完成签名**查看**，**绘制**及**删除**功能。

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


**签名管理模块示例如下，详情见demo**

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
