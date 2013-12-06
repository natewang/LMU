//
//  User.h
//  LMU
//
//  Created by wangxu on 13-12-5.
//  Copyright (c) 2013年 wangxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Event;

@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * api_user_id;
@property (nonatomic, retain) NSString * city_tags;
@property (nonatomic, retain) NSNumber * role_id;
@property (nonatomic, retain) NSNumber * user_age;
@property (nonatomic, retain) NSString * user_birthday;
@property (nonatomic, retain) NSString * user_fromcountry;
@property (nonatomic, retain) NSNumber * user_fromcountry_id;
@property (nonatomic, retain) NSString * user_img;
@property (nonatomic, retain) NSString * user_livecity;
@property (nonatomic, retain) NSNumber * user_livecity_id;
@property (nonatomic, retain) NSString * user_livecountry;
@property (nonatomic, retain) NSString * user_nickname;
@property (nonatomic, retain) NSString * user_sig;
@property (nonatomic, retain) Event *event;

@end
