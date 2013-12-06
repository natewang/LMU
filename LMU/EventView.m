//
//  EventView.m
//  live
//
//  Created by wangxu on 13-10-29.
//  Copyright (c) 2013年 wangxu. All rights reserved.
//

#import "EventView.h"

@implementation EventView
@synthesize imageView;
@synthesize labelEventTime;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

//初始化大小和照片URL地址

- (id) initWithFrame:(CGRect)frame eventImg:(NSString *)eventImgURl
{
    self = [super initWithFrame:frame];
    
    if (self){
    self.backgroundColor = [UIColor whiteColor];
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 0, 200, 282)];
    
    labelEventTime = [[UILabel alloc]initWithFrame:CGRectMake(10, 285, 280, 15)];
    
    imageView.backgroundColor = [UIColor greenColor];
    
    [self addSubview:imageView];
    [self addSubview:labelEventTime];
        
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DownloadImageNotification" object:self userInfo:@{@"imageView":imageView,@"imgURL":eventImgURl}];
        
    }
    return self;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
