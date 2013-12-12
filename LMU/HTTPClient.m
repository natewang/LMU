//
//  HTTPClient.m
//  MyLibrary
//
//  Created by Eli Ganem on 8/7/13.
//  Copyright (c) 2013 Eli Ganem. All rights reserved.
//

#import "HTTPClient.h"

@implementation HTTPClient

@synthesize delegate = _delegate;

+ (HTTPClient *) sharedInstance
{
    static HTTPClient *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        
        _sharedInstance = [[HTTPClient alloc]init];
        
        
    });
    return _sharedInstance;
}

- (void) startAsynchronousDownloadWith:(NSString *)url withMethodName:(NSString *)methodName
{
//    login
    if ([methodName isEqualToString:@"login"]){
        
//        GCD
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
            NSData *passInfo = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
//       传回数据
            [_delegate passInfo:passInfo withMethodName:methodName];
            
        });
    
    }
}





- (id)getRequest:(NSString*)url
{
    return nil;
}

- (id)postRequest:(NSString*)url body:(NSString*)body
{
    return nil;
}

- (UIImage*)downloadImage:(NSString*)url
{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    return [UIImage imageWithData:data];
}

@end
