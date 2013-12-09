//
//  MainCell.h
//  live
//
//  Created by wangxu on 13-11-6.
//  Copyright (c) 2013年 wangxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventView.h"
#import "Event.h"
@interface MainCell : UITableViewCell
{
    EventView *eventView;
}
@property (nonatomic, strong) EventView *eventView;

    


@end
