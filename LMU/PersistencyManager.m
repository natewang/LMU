//
//  PersistencyManager.m
//  LMU
//
//  Created by wangxu on 13-12-4.
//  Copyright (c) 2013年 wangxu. All rights reserved.
//

#import "PersistencyManager.h"
#import "LMUEvent.h"
#import "LMUAppDelegate.h"
#import "Event.h"

#define EVENTURL @"http://www.livemeetup.com/_ashx/GetIndexEvents.ashx?s=1&p=%d"
//_ashx/GetIndexEvents.ashx?s=1&p=1

@interface PersistencyManager ()
{
    NSMutableArray *events;
}
@end

@implementation PersistencyManager

- (id) init
{
    self = [super init];
    if (self) {
        
        events = [[NSMutableArray alloc]initWithCapacity:10];
//        提取存储的数据
        
        
        
        LMUAppDelegate *delegate = (LMUAppDelegate *)[[UIApplication sharedApplication]delegate];
        NSManagedObjectContext *context = delegate.managedObjectContext;
       /*
        Event *event = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:context];
        event.event_id = [NSString stringWithFormat:@"%d",666];
        
        NSError *error;
//        [context save:&error];
        */
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"event_id" ascending:NO];

        NSArray *arraySort= [[NSArray alloc]initWithObjects:sortDescriptor, nil];
        [fetchRequest setSortDescriptors:arraySort];

        
        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:nil];
        for (Event *event in fetchedObjects)
        {
            [events addObject:event];
        }
         
    }
    return  self;
}

-(NSArray *)getEvents
{
//   获取已经存储的数据
    return events;
}

- (void) getNewEvents
{
    
    
//    网络获取新的活动信息，并存储下
    LMUAppDelegate *delegate = (LMUAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        for (int i =1 ; i <= 10 ; i++) {
            //        获取多次活动信息
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:EVENTURL,i]]];
            if (data == nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"NoNetWork" object:nil];
                    
                });

                return;
    
            }
            
            
            NSDictionary *dicData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSEnumerator *enumerator = [dicData objectEnumerator];
            id key;
            BOOL change = YES;//判断是否需要存储

            while (key = [enumerator nextObject]) {
                
                NSString *currentEventID = [key valueForKey:@"event_id"];
//                判断下载的活动是否已经储存了
        
                NSArray *arrayExistEventID = [[NSUserDefaults standardUserDefaults]objectForKey:@"ExistEventID"];
//                对比
                for (int i = 0; i < [arrayExistEventID count]; i++) {
                    if ([arrayExistEventID[i] isEqualToString:currentEventID]) {
                        change = NO;
                        break;
                    }
                    else change = YES;
                }
                
                if (change)
                {
                    NSMutableArray *arrayTemp = [NSMutableArray arrayWithArray:arrayExistEventID];
                    
                    
                    [arrayTemp insertObject:currentEventID atIndex:0];
                    [[NSUserDefaults standardUserDefaults] setObject:arrayTemp forKey:@"ExistEventID"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
               
               

                
                Event *event = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:context];
                //            write in the file
                event.event_id = [key objectForKey:@"event_id"];
                event.event_name = [key objectForKey:@"event_name"];
                event.event_img = [NSString stringWithFormat:@"http://www.livemeetup.com%@",[key objectForKey:@"event_img"]];
                event.event_img_thumb = [NSString stringWithFormat:@"http://www.livemeetup.com%@",[key objectForKey:@"event_img_thumb"]];
                event.event_user = [key objectForKey:@"event_user"];
                event.event_state = [NSNumber numberWithInteger:[[key objectForKey:@"event_state"]integerValue]];
                event.event_datetime = [key objectForKey:@"event_datetime"];
                event.org_id = [NSNumber numberWithInteger:[[key objectForKey:@"org_id"] integerValue]];
                event.org_name = [key objectForKey:@"org_name"];
                event.org_img = [key objectForKey:@"org_img"];
                event.org_country = [key objectForKey:@"org_country"];
                event.org_city = [key objectForKey:@"org_city"];
                event.event_country = [key objectForKey:@"event_country"];
                event.event_address = [key objectForKey:@"event_address"];
                event.event_field = [key objectForKey:@"event_field"];
                event.event_price = [key objectForKey:@"event_price"];
                NSError *error;
                [context save:&error];
                
                }
                
                
            }
            if (!change) break;

         }
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
//        排训
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"event_id" ascending:NO];
        NSArray *arraySort= [[NSArray alloc]initWithObjects:sortDescriptor, nil];
        [fetchRequest setSortDescriptors:arraySort];
        
        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:nil];
        [events removeAllObjects];
        for (Event *event in fetchedObjects)
        {
            [events addObject:event];
        }
        
        if (events != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"getNewEvents" object:events];
                
            });
        }
        
    });
    
    }






- (void)saveImage:(UIImage *)image filename:(NSString *)filename
{
    filename = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",filename];
    NSData *data = [NSData dataWithContentsOfFile:filename];
    [data writeToFile:filename atomically:YES];
}

- (UIImage *) getImage:(NSString *)filename
{
    filename = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",filename];
    NSData *data = [NSData dataWithContentsOfFile:filename];
    return [UIImage imageWithData:data];
}




@end
