//
//  LibraryAPI.m
//  
//
//  Created by wangxu on 13-12-4.
//
//

#import "LibraryAPI.h"
#import "HTTPClient.h"
#import "PersistencyManager.h"

@interface LibraryAPI ()
{
    PersistencyManager *persistencyManager;
    HTTPClient *httpClient;
    BOOL isOnline;
}

@end

@implementation LibraryAPI

- (id) init
{
    self = [super init];
    if (self) {
        persistencyManager = [[PersistencyManager alloc]init];
        httpClient = [[HTTPClient alloc]init];
        isOnline = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadImage:) name:@"DownloadImageNotification" object:nil];
    }
    return  self;
}



 + (LibraryAPI *) sharedInstance
{
    static LibraryAPI *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        
        _sharedInstance = [[LibraryAPI alloc]init];
        
        
    });
    return _sharedInstance;
}

- (NSArray *) getEvents
{
    return [persistencyManager getEvents];
}

- (void) getNewEvents
{
    [persistencyManager getNewEvents];
}

- (void) addEvent:(LMUEvent *)event atIndex:(int)index
{
//    添加后动进列表
    
}



- (void) startDownloadWithUrl:(NSString *)url withMethodName:(NSString *)methodName
{
        
}

- (void) saveUserKey:(NSString *)userID token:(NSString *)token
{
    [[PersistencyManager sharedInstance] saveUserKey:userID token:token];
    
}

- (NSDictionary *) getUserKey
{
    return [[PersistencyManager sharedInstance]getUserkKey];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
