//
//  PersistencyManager.h
//  LMU
//
//  Created by wangxu on 13-12-4.
//  Copyright (c) 2013年 wangxu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersistencyManager : NSObject

- (NSArray *) getEvents;
- (void) getNewEvents;
- (void) saveImage: (UIImage *) image filename : (NSString *)filename;

- (UIImage *) getImage: (NSString *) filename;

@end
