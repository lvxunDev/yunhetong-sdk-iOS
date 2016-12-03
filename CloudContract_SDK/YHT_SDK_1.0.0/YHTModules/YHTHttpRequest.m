//
//  YHTHttpRequest.m
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/4.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import "YHTHttpRequest.h"
#import "YHTTokenManager.h"
#import "YHTSdk.h"
#import "YHTError.h"

@protocol YHTResetTokenDelegate;
@interface YHTHttpRequest()<NSURLConnectionDataDelegate>

@property (nonatomic, strong)NSMutableData *responseData;
@property (nonatomic, copy)YHTHttpRequestHandler handler;
@property (nonatomic, strong)id<YHTResetTokenDelegate> resetTokenDelegate;

@end

@implementation YHTHttpRequest

+ (YHTHttpRequest *)requestWithURL:(NSString *)url
                        httpMethod:(NSString *)httpMethod
                            params:(NSDictionary *)params
                               tag:(NSString *)tag
                          delegate:(id<YHTHttpRequestDelegate>)delegate{
    YHTHttpRequest *httpRequest = [[YHTHttpRequest alloc] init];
    httpRequest.url = url;
    httpRequest.httpMethod = httpMethod;
    httpRequest.params = params;
    httpRequest.delegate = delegate;
    httpRequest.tag = tag;
    [httpRequest startRequest];

    return httpRequest;
}

- (void)startRequest{

    if([YHTTokenManager sharedManager].isTokenValid == NO){
        self.resetTokenDelegate = [YHTSdk sharedManager].resetTokenDelegate;
        if (self.resetTokenDelegate) {
            [self.resetTokenDelegate resetTokenWithHtttpRequest:self];
        }
         return;
    }

    NSMutableURLRequest *request;

    NSString *str = @"";

    NSMutableDictionary *__params = [NSMutableDictionary dictionaryWithDictionary:_params];
    [__params setValue:[[YHTTokenManager sharedManager] token] forKey:@"token"];

    if ([self.httpMethod isEqualToString:@"POST"]) {
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_url]
                                          cachePolicy:NSURLRequestReloadIgnoringCacheData
                                      timeoutInterval:5.0f];

        request.HTTPMethod = @"POST";

        for (NSString *key in __params.allKeys) {
            str = [NSString stringWithFormat:@"%@&%@=%@",str,key,__params[key]];
        }
        str = [str substringFromIndex:1];
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        request.HTTPBody = data;

    }else{

        for (NSString *key in __params.allKeys) {
            str = [NSString stringWithFormat:@"%@&%@=%@",str,key,__params[key]];
        }
        str = [str substringFromIndex:1];
        str = [NSString stringWithFormat:@"%@?%@", _url, str];
        NSString* encodedString = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:str]
                                          cachePolicy:NSURLRequestUseProtocolCachePolicy
                                      timeoutInterval:5.0f];
    }

#ifdef DEBUG
    NSLog(@"\n\n");
    NSLog(@"#####################################################################################");
    NSLog(@"发起%@请求:%@", [self.httpMethod isEqualToString:@"POST"]? @"POST":@"GET", _url);
    NSLog(@"请求参数：%@", __params);
#endif

    [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark - NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{

    _responseData = [[NSMutableData alloc]init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [[YHTTokenManager sharedManager] reloadToken];

    id res = [NSJSONSerialization JSONObjectWithData:_responseData options:NSJSONReadingMutableLeaves error:nil];

    if ([res[@"code"] isEqualToNumber:[NSNumber numberWithInteger:YHTSDKResponseStatusCodeTokenInvalid]]) {
        if (self.resetTokenDelegate) {
            [self.resetTokenDelegate resetTokenWithHtttpRequest:self];
        }
        return;

    }else if([res[@"code"] isEqualToNumber:[NSNumber numberWithInteger:YHTSDKResponseStatusCodeSuccess]]){
        if ([res[@"subCode"] isEqualToNumber:[NSNumber numberWithInteger:YHTSDKResponseStatusCodeSuccess]]) {
            [self.delegate request:self didFinishLoadingWithResult:res];
            return;
        }else{
            [self.delegate request:self didFailWithError:[YHTError instanceWithErrorMsg:res[@"message"]]];
        }

    }else{
        [self.delegate request:self didFailWithError:[YHTError instanceWithErrorMsg:res[@"message"]]];
        NSString *str = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
        NSLog(@"str:%@",str);
    }

}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [self.delegate request:self didFailWithError:error];
}
@end