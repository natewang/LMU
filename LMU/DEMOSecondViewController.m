//
//  DEMOSecondViewController.m
//  RESideMenuExample
//
//  Created by Roman Efimov on 10/10/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOSecondViewController.h"
#import "VRGCalendarView.h"
#import "LMUEventDetailViewController.h"
@implementation DEMOSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"DATE";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    VRGCalendarView *calendar = [[VRGCalendarView alloc]init];
    [self.view addSubview:calendar];
    calendar.delegate = self;
    
}

- (void) calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated
{
    
    NSArray *dates = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],nil];

    [calendarView markDates:dates];
}

- (void) calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date
{
    
    LMUEventDetailViewController *eventDVC = [[LMUEventDetailViewController alloc]init];
    [self.navigationController pushViewController:eventDVC animated:YES];
    
}

- (void)showMenu
{
    [self.sideMenuViewController presentMenuViewController];
}

@end
