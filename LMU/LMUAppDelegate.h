//
//  LMUAppDelegate.h
//  LMU
//
//  Created by wangxu on 13-12-2.
//  Copyright (c) 2013年 wangxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMUAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
