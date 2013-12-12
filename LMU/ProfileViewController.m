//
//  ProfileViewController.m
//  live
//
//  Created by wangxu on 13-11-6.
//  Copyright (c) 2013年 wangxu. All rights reserved.
//

#import "ProfileViewController.h"
#import "QuartzCore/QuartzCore.h"
#import "Login.h"
#import "LibraryAPI.h"
@interface ProfileViewController ()
{
    UIImageView *imageHead;
    UILabel *labelName;
}

@end

@implementation ProfileViewController

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
    
    self.navigationItem.title = @"Profile";
//    beijing
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"userBG.png"]];
//    圆角 阴影头像
    imageHead = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, 50.0f, 50.0f)];
    imageHead.center = CGPointMake(160, 150);
    labelName = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,320, 50)];
    labelName.center = CGPointMake(160, 200);
    labelName.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelName];
    
    UIView *view = [[UIView alloc]initWithFrame:imageHead.frame];
    view.backgroundColor = [UIColor redColor];
    view.layer.shadowOffset = CGSizeMake(0, 6);
    view.layer.cornerRadius = 6.0f;
    view.layer.shadowRadius = 6;
    view.layer.shadowOpacity = 1.0f;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    [self.view addSubview:view];
    
    
    imageHead.image = [UIImage imageNamed:@"userBG.png"];

//   获取用户信息
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSDictionary *dicUserInfo = [[LibraryAPI sharedInstance] getUserKey];
        NSString *userID = [dicUserInfo objectForKey:@"UserID"];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.livemeetup.com/_ashx/GetUserInfo.ashx?uid=%@",userID]];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:url] options:NSJSONReadingMutableLeaves error:nil];
        NSURL *urlImage = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.livemeetup.com/%@",[dic objectForKey:@"user_img"]]];
                           
                           UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:urlImage]];
                           
        if (image)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
            
                imageHead.image = image;
                labelName.text = [dic objectForKey:@"user_nickname"];
            
            });
        }
    });
    
    
    
    
    
    imageHead.layer.cornerRadius = 6.0f;
    imageHead.layer.masksToBounds = YES;
//    imageHead.layer.borderWidth = 1.0f;
    imageHead.layer.borderColor = [UIColor blackColor].CGColor;
    
    
    
//    imageHead.layer.shadowColor = [UIColor colorWithRed:163.0/255 green:163.0/255 blue:163.0/255 alpha:1].CGColor;
//    imageHead.layer.shadowOffset = CGSizeMake(3.0f, 3.0f);
//    imageHead.layer.shadowRadius = 0.6f;
//    imageHead.layer.shadowOpacity = 1.0f;
    
    [self.view addSubview:imageHead];
    
//  贴上button ，点击进入登陆
    UIButton *buttonHead = [[UIButton alloc]initWithFrame:imageHead.frame];
    [buttonHead addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonHead];
    
    
}

- (void) login: (id) sender
{
    imageHead.transform = CGAffineTransformIdentity;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5f];
    imageHead.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
//    [UIView commitAnimations];
    
//    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.0f];
    imageHead.transform = CGAffineTransformIdentity;
    [UIView commitAnimations];
    
    Login *loginVC = [[Login alloc]init];
    [self presentViewController:loginVC animated:YES completion:nil];
}


- (void) drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    CGContextRef currentContext = ctx;
    CGContextSetStrokeColorWithColor(currentContext, [[UIColor brownColor] CGColor]);
    CGContextSetLineWidth(currentContext, 5.0f);
    CGContextMoveToPoint(currentContext, 50.0f, 10.0f);
    CGContextAddLineToPoint(currentContext, 100.0f, 200.0f);
    CGContextStrokePath(currentContext);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
