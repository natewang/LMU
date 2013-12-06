//
//  LMUEvent.h
//  LMU
//
//  Created by wangxu on 13-12-4.
//  Copyright (c) 2013年 wangxu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMUEvent : NSObject

@property (nonatomic,readonly) NSString *eventInfoURL;

- (id) initWithEventInfoURL: (NSString *) eventInfoURL;


@end
