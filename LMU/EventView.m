//
//  EventView.m
//  live
//
//  Created by wangxu on 13-10-29.
//  Copyright (c) 2013年 wangxu. All rights reserved.
//

#import "EventView.h"
#import "SDWebImage/UIImageView+WebCache.h"




@implementation EventView
@synthesize imageView;
@synthesize labelEventTime;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 0, 200, 282)];
        
        labelEventTime = [[UILabel alloc]initWithFrame:CGRectMake(10, 285, 280, 15)];
        
        imageView.backgroundColor = [UIColor greenColor];
        
        [self addSubview:imageView];
        [self addSubview:labelEventTime];

    }
    return self;
}

//初始化大小和照片URL地址

- (id) initWithFrame:(CGRect)frame eventInfo:(Event *)eventInfo
{
//    cell 里的活动预览视图 展示 活动图片，活动名，活动时间
    
    self = [super initWithFrame:frame];
    
    if (self){
    self.backgroundColor = [UIColor whiteColor];
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 0, 200, 282)];
    
    labelEventTime = [[UILabel alloc]initWithFrame:CGRectMake(10, 285, 280, 15)];
        
    
    
    NSString *urlstring = [eventInfo valueForKey:@"event_img_thumb"];
    NSURL *imageURL = [NSURL URLWithString:urlstring];
        
    
        [imageView setImageWithURL:imageURL
                                 placeholderImage:[UIImage imageNamed:@"userBG.png"]
         ];

    
    
    
    [self addSubview:imageView];
    [self addSubview:labelEventTime];
        
    
        
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
