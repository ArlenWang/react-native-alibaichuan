
#import "RNAlibcSdk.h"
#import "AlibcSdkBridge.h"

#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import <AlibabaAuthSDK/ALBBSDK.h>
#import <React/RCTLog.h>


#define NOT_LOGIN (@"not login")

@implementation RNAlibcSdk {
    bool hasListeners;
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
+ (BOOL) requiresMainQueueSetup {
    return YES;
}
RCT_EXPORT_MODULE()
// Will be called when this module's first listener is added.
-(void)startObserving {
    hasListeners = YES;
    // Set up any upstream listeners or background tasks as necessary
}

// Will be called when this module's last listener is removed, or on dealloc.
-(void)stopObserving {
    hasListeners = NO;
    // Remove upstream listeners, stop unnecessary background tasks
}
- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleOpenURL:)
                                                     name:@"RCTOpenURLNotification"
                                                   object:nil];
    }
    return self;
}

- (void)handleOpenURL:(NSNotification *)note {
    NSDictionary *userInfo = note.userInfo;
    NSString *url = userInfo[@"url"];
    NSURL *URL = [NSURL URLWithString:url];
    [[AlibcTradeSDK sharedInstance] application:nil
                                        openURL:URL
                                        options:nil];
    
    
}

RCT_EXPORT_METHOD(initTae: (RCTResponseSenderBlock)callback)
{
    [[AlibcSdkBridge sharedInstance] initTae:callback];
}

RCT_EXPORT_METHOD(showLogin: (RCTResponseSenderBlock)callback)
{
    [[AlibcSdkBridge sharedInstance] showLogin:callback];
}
RCT_EXPORT_METHOD(isLogin: (RCTResponseSenderBlock)callback)
{
    [[AlibcSdkBridge sharedInstance] isLogin:callback];
}

RCT_EXPORT_METHOD(getUserInfo: (RCTResponseSenderBlock)callback)
{
    [[AlibcSdkBridge sharedInstance] getUserInfo:callback];
}

RCT_EXPORT_METHOD(logout: (RCTResponseSenderBlock)callback)
{
    [[AlibcSdkBridge sharedInstance] logout:callback];
}

RCT_EXPORT_METHOD(show: (NSDictionary *)param callback: (RCTResponseSenderBlock)callback){
    [[AlibcSdkBridge sharedInstance] show:param callback:callback];
}


@end
  
