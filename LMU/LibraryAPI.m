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

- (void) downloadImage: (NSNotification *) notification
{
    UIImageView *imageView = notification.userInfo[@"imageView"];
    NSString *imgUrl = notification.userInfo[@"imgURL"];
    
    imageView.image = [persistencyManager getImage:[imgUrl lastPathComponent]];
    if (imageView.image == nil) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            UIImage *image = [httpClient downloadImage:imgUrl];
            dispatch_sync(dispatch_get_main_queue(), ^{
                imageView.image = image;
                [persistencyManager saveImage:image filename:[imgUrl lastPathComponent]];
                
            });
            
        });
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
