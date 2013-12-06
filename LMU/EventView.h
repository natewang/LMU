//
//  EventView.h
//  live
//
//  Created by wangxu on 13-10-29.
//  Copyright (c) 2013年 wangxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventView : UIView

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *labelEventTime;

- (id) initWithFrame:(CGRect)frame eventImg: (NSString *) eventImgURl;



@end
