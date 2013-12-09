//
//  LMUHomeViewController.h 主界面
//  LMU
//
//  Created by wangxu on 13-12-3.
//  Copyright (c) 2013年 wangxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMUHomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@end
