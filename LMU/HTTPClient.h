//
//  HTTPClient.h
//  MyLibrary
//
//  Created by Eli Ganem on 8/7/13.
//  Copyright (c) 2013 Eli Ganem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking/AFNetworking.h"

@protocol HTTPClientDelegate;

@interface HTTPClient : NSObject

@property (nonatomic ,strong) id<HTTPClientDelegate> delegate;


+ (HTTPClient *) sharedInstance;
- (id)getRequest:(NSString*)url;
- (id)postRequest:(NSString*)url body:(NSString*)body;
- (UIImage*)downloadImage:(NSString*)url;

-  (void)startAsynchronousDownloadWith:(NSString *)url withMethodName:(NSString *)methodName;


@end

@protocol HTTPClientDelegate <NSObject>

- (void) passInfo: (NSData *) passInfo withMethodName: (NSString *) methodName;

@end