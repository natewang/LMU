//
//  LMUUserMange.h
//  LMU
//
//  Created by wangxu on 13-12-10.
//  Copyright (c) 2013年 wangxu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol loginDelegate;

@interface LMUUserMange : NSObject

@property (assign,nonatomic) id<loginDelegate> delegate;

+ (LMUUserMange *) sharedInstace;

- (void) loginWith: (NSString *) username password: (NSString *) password methodName: (NSString *) methodName;

@end

@protocol loginDelegate <NSObject>

- (void) loginSuccess: (BOOL) isSuccessed;

@end