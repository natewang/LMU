//
//  Event.h
//  LMU
//
//  Created by wangxu on 13-12-5.
//  Copyright (c) 2013年 wangxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Event : NSManagedObject

@property (nonatomic, retain) NSString * event_address;
@property (nonatomic, retain) NSString * event_country;
@property (nonatomic, retain) NSString * event_field;
@property (nonatomic, retain) NSString * event_id;
@property (nonatomic, retain) NSString * event_img;
@property (nonatomic, retain) NSString * event_img_thumb;
@property (nonatomic, retain) NSString * event_name;
@property (nonatomic, retain) NSNumber * event_state;
@property (nonatomic, retain) NSString * event_user;
@property (nonatomic, retain) NSString * org_city;
@property (nonatomic, retain) NSString * org_country;
@property (nonatomic, retain) NSNumber * org_id;
@property (nonatomic, retain) NSString * org_img;
@property (nonatomic, retain) NSString * org_name;
@property (nonatomic, retain) NSString * event_datetime;
@property (nonatomic, retain) NSString * event_price;
@property (nonatomic, retain) User *user;

@end
