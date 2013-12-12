//
//  LMUUserMange.m
//  LMU
//
//  Created by wangxu on 13-12-10.
//  Copyright (c) 2013年 wangxu. All rights reserved.
//

#import "LMUUserMange.h"
#import "HTTPClient.h"
#import "MyMD5.h"
#import "PersistencyManager.h"
@interface LMUUserMange ()<HTTPClientDelegate>

@end

@implementation LMUUserMange
@synthesize delegate = _delegate;

+ (LMUUserMange *) sharedInstace
{
    static LMUUserMange *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        
        _sharedInstance = [[LMUUserMange alloc]init];
        
        
    });
    return _sharedInstance;
    
}

//登陆
- (void) loginWith:(NSString *)username password:(NSString *)password methodName:(NSString *)methodName
{
//    合成登陆连接
    NSString *stringForLoginUrl = [[NSString alloc]initWithFormat:@"http://www.livemeetup.com/_ashx/Login.ashx?appkey=b1a16d4bf979bcaf8453e3e57f70d762&uemail=%@&upass=%@",username,[MyMD5 md5:password]];
    
//    使用httpclient 获取网络连接，并代理模式返回数据
    [[HTTPClient sharedInstance] startAsynchronousDownloadWith:stringForLoginUrl withMethodName:methodName];
    [HTTPClient sharedInstance].delegate =self;
}

//httpclient的代理方法
- (void) passInfo:(NSData *)passInfo withMethodName:(NSString *)methodName
{
    
    if (passInfo != nil && [methodName isEqualToString:@"login"]) {
        
        NSDictionary *dicResponse = [NSJSONSerialization JSONObjectWithData:passInfo options:NSJSONReadingMutableLeaves error:nil];
        NSString *userID = [dicResponse objectForKey:@"uid"];
        NSString *token = [NSString stringWithFormat:@"%@",[dicResponse objectForKey:@"token"]];

        if ([userID integerValue]) {
            
//            保存数据
            [[PersistencyManager sharedInstance] saveUserKey:userID token:token];
            
            [_delegate loginSuccess:YES];

        }
        else [_delegate loginSuccess:NO];
        
        
        
        
    }
    else
        [_delegate loginSuccess:NO];
    
}



@end
