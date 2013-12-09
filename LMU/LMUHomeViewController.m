//
//  LMUHomeViewController.m
//  LMU
//
//  Created by wangxu on 13-12-3.
//  Copyright (c) 2013年 wangxu. All rights reserved.
//

#import "LMUHomeViewController.h"
#import "MainCell.h"
#import "Event.h"
#import "LMUAppDelegate.h"
#import "LibraryAPI.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "UIColor+Crayola.h"
#import "EventView.h"
#import "LMUEventDetailViewController.h"

#define EVENTURL @"http://www.livemeetup.com/_ashx/GetIndexEvents.ashx?s=1&p=1"

@interface LMUHomeViewController ()
{
    NSArray *events;
    
}


@end

@implementation LMUHomeViewController
@synthesize tableView;


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
    self.view.backgroundColor = [UIColor crayolaPeriwinkleColor];
    tableView.backgroundColor = [UIColor crayolaPeriwinkleColor];
    self.title = @"Events";
    
//    显示活动的tableView
    tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    events = [[LibraryAPI sharedInstance] getEvents];
    
    
//    刷新按钮
    UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    
    self.navigationItem.rightBarButtonItem = button;
    
    
//    注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNewEvents:) name:@"getNewEvents" object:nil];
    
    
    
    
    
    
    
    /* coredata 测试数据
    
//    联网获取数据
//    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:EVENTURL]];
//    NSMutableArray *dicListInfo = [[NSMutableArray alloc]initWithCapacity:10];
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:EVENTURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:3];
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:nil];
    
//    解析返回的json
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSEnumerator *enumerator = [dic objectEnumerator];
    id key;
    
    LMUAppDelegate *delegate = (LMUAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    while (key = [enumerator nextObject]) {
        NSLog(@"key--> %@",key);
//        写入
        Event *event = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:context];
        event.event_id = [key objectForKey:@"event_id"];
        event.event_name = [key objectForKey:@"event_name"];
        event.event_img = [NSString stringWithFormat:@"http://www.livemeetup.com%@",[key objectForKey:@"event_img"]];
        event.event_img_thumb = [NSString stringWithFormat:@"http://www.livemeetup.com%@",[key objectForKey:@"event_img_thumb"]];
        event.event_user = [key objectForKey:@"event_user"];
    }
    
//    输出测试

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:nil];
    for (Event *event in fetchedObjects)
    {
        NSLog(@"id -->%@,name-->%@",event.event_id,event.event_name);
    
    }
    
     */
    
}
//接收通知
- (void) getNewEvents: (NSNotification *) notification
{
    events = [notification object];
    
    NSLog(@"evnets-->%@",events);
    
    [tableView reloadData];
}


- (void) refresh: (id) sender
{
   [[LibraryAPI sharedInstance] getNewEvents];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRow = 0;
    
    if ([events count]) {
        return [events count];
    }
    else
    
    return numberOfRow;
}

- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainCell *cell = [atableView dequeueReusableCellWithIdentifier:@"MainCell"];
     tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    Event *eventInfo = events[indexPath.row];
    
    
    

    if (!cell) {
        
        cell = [[MainCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MainCell"];
        
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor crayolaPeriwinkleColor];

    
    NSString *urlstring = [eventInfo valueForKey:@"event_img_thumb"];
    NSURL *imageURL = [NSURL URLWithString:urlstring];
    [cell.eventView.imageView setImageWithURL:imageURL
              placeholderImage:[UIImage imageNamed:@"userBG.png"]
     ];

    
    
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Event *eventInfo = events[indexPath.row];
    LMUEventDetailViewController *vcEventDetail = [[LMUEventDetailViewController alloc]init];
    vcEventDetail.eventInfo = eventInfo;
    [self.navigationController pushViewController:vcEventDetail animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
