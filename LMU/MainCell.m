//
//  MainCell.m
//  live
//
//  Created by wangxu on 13-11-6.
//  Copyright (c) 2013年 wangxu. All rights reserved.
//

#import "MainCell.h"
#import "EventView.h"
#import "Event.h"

@implementation MainCell
@synthesize eventView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        eventView = [[EventView alloc] initWithFrame:CGRectMake(5.0f, 0.0f, 310.0f, 290.0f)];
        [self.contentView addSubview:eventView];
//        圆角 阴影
        eventView.layer.cornerRadius = 6.0f;
        eventView.layer.shadowColor = [UIColor colorWithRed:163.0/255 green:163.0/255 blue:163.0/255 alpha:1].CGColor;
        eventView.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
        eventView.layer.shadowRadius = 0.6f;

    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
