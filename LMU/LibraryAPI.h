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



@end
