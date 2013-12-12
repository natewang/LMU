//
//  LibraryAPI.h
//  
//
//  Created by wangxu on 13-12-4.
//
//

#import <Foundation/Foundation.h>
#import "LMUEvent.h"



@interface LibraryAPI : NSObject

+ (LibraryAPI *) sharedInstance;

- (NSArray *) getEvents;
- ( void)getNewEvents;

- (void) addEvent: (LMUEvent *) event atIndex: (int) index;

- (void) startDownloadWithUrl: (NSString *) url withMethodName: (NSString *) methodName;

- (void) saveUserKey : (NSString *) userID token: (NSString *) token;
- (NSDictionary *) getUserKey;



@end
