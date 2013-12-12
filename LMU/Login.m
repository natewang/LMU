//
//  Login.m
//  livemeetup_9
//
//  Created by wordoor on 13-9-2.
//  Copyright (c) 2013年 wordoor. All rights reserved.
//

#import "Login.h"
#import "MyMD5.h"
#import "SVProgressHUD/SVProgressHUD.h"
#import "LMUUserMange.h"
#import "AFNetworking/AFNetworking.h"

@interface  Login () <UIGestureRecognizerDelegate,loginDelegate>

@end

@implementation Login

// 用户ID 密码 用户名
NSString *myID;
UITextField *textPassword;
UITextField *textUsername;


- (void) viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    textUsername = [[UITextField alloc]initWithFrame:CGRectMake(50, 100, 200, 30)];
    [textUsername setBorderStyle:UITextBorderStyleRoundedRect];
    textUsername.returnKeyType = UIReturnKeyNext;
    textUsername.placeholder = @"username";
    
    
    textPassword = [[UITextField alloc]initWithFrame:CGRectMake(50, 150, 200, 30)];
    [textPassword setBorderStyle:UITextBorderStyleRoundedRect];
    textPassword.returnKeyType = UIReturnKeyGo;
    textPassword.secureTextEntry = YES;
    textPassword.placeholder = @"password";
    
    
    textUsername.delegate = self;
    textPassword.delegate =self;
    [self.view addSubview:textPassword];
    [self.view addSubview:textUsername];

    
//    手势
    UISwipeGestureRecognizer *recognizer;
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [[self view] addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [[self view] addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [[self view] addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [[self view] addGestureRecognizer:recognizer];
    

    
}




-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionDown) {
        
        NSLog(@"swipe down");
        
        [self dismissViewControllerAnimated:YES completion:nil];
        //执行程序
    }
    if(recognizer.direction==UISwipeGestureRecognizerDirectionUp) {
        
        NSLog(@"swipe up");
        //执行程序
    }
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        
        NSLog(@"swipe left");
        //执行程序
    }
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        
        NSLog(@"swipe right");
        //执行程序
    }
    
}



- (void) login
{
    NSString *name = textUsername.text;
    NSString *pwd = [MyMD5 md5:textPassword.text];
    
    NSString *stringForLoginUrl = [[NSString alloc]initWithFormat:@"http://www.livemeetup.com/_ashx/Login.ashx?appkey=b1a16d4bf979bcaf8453e3e57f70d762&uemail=%@&upass=%@",name,pwd];
    
    
    NSData *dataLogin = [NSData dataWithContentsOfURL:[NSURL URLWithString:stringForLoginUrl]];
    
    if (dataLogin== nil) {
        [SVProgressHUD showErrorWithStatus:@"no network"];
        return;
    }
    
    NSDictionary *dicResponse = [NSJSONSerialization JSONObjectWithData:dataLogin options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"dicResponse-->%@",dicResponse);
    
//获取用户id 和 token 以便以后使用
    
    
    myID = [dicResponse objectForKey:@"uid"];
    NSString *token = [NSString stringWithFormat:@"%@",[dicResponse objectForKey:@"token"]];

    if ([myID intValue]) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            //获取应用程序沙盒的Documents目录
            NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
            NSString *plistPath1 = [paths objectAtIndex:0];
            
            //得到完整的文件名
            NSString *filename=[plistPath1 stringByAppendingPathComponent:@"UserInfoList.plist"];
            
            NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
            //        NSLog(@"%@", data);
            
            //添加两项内容 用户ID  一个完整的token md5(appkey+md5(token))
            
            NSMutableString *stringToken = [[NSMutableString alloc] initWithFormat:@"20130716%@",[MyMD5 md5:token]];
            
            NSString *myToken = [[NSString alloc] initWithFormat:@"%@",[MyMD5 md5:stringToken]];
            
            //        存储需要的两个数据
            [data setValue:myToken forKey:@"myToken"];
            
            NSLog(@"myToken--%@",myToken);
            
            [data setValue:myID forKey:@"UserID"];
            
            
            NSLog(@"data-->%@",data);
            
            
            //输入写入
            [data writeToFile:filename atomically:YES];

        });
        
//        跳转到活动页
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    else [SVProgressHUD showErrorWithStatus:@"login failed"];
}

- (void) loginAction
{
    [[LMUUserMange sharedInstace] loginWith:textUsername.text password:textPassword.text methodName:@"login"];
    [LMUUserMange sharedInstace].delegate = self;
    
    
    
    
}

//logindelegate的代理方法
- (void) loginSuccess:(BOOL)isSuccessed
{
//    判断是否登陆成功
    if (isSuccessed) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }

    
}

- (BOOL) textFieldShouldReturn:(UITextField *) textField
{
    if (textField == textUsername) {
        [textUsername resignFirstResponder];
        [textPassword becomeFirstResponder];
    }

    else if (textField == textPassword)
    {
//       登陆操作
        [textPassword resignFirstResponder];
//        获取网络数据
        
        [self loginAction];
        
    }
    return YES;
}


@end
