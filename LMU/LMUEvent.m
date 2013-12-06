//
//  LMUEvent.m
//  LMU
//
//  Created by wangxu on 13-12-4.
//  Copyright (c) 2013年 wangxu. All rights reserved.
//

#import "LMUEvent.h"

@implementation LMUEvent

- (id) initWithEventInfoURL:(NSString *)eventInfoURL
{
    self = [super init];
    if (self) {
        _eventInfoURL = eventInfoURL;
    }
    return self;
}


@end
