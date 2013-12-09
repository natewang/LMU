//
//  LMUEventDetailViewController.m
//  LMU
//
//  Created by wangxu on 13-12-9.
//  Copyright (c) 2013年 wangxu. All rights reserved.
//

#import "LMUEventDetailViewController.h"

@interface LMUEventDetailViewController ()

@end

@implementation LMUEventDetailViewController
@synthesize eventInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    测试效果
    NSLog(@"eventInfo-->%@",eventInfo);
    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    label.text = @"EventDeta!";
    label.center = self.view.center;
    [self.view addSubview:label];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
