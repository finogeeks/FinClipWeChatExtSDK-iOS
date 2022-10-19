//
//  AppDelegate.m
//
//
//  Created by finogeeks.com on 2022/3/21.
//

#import "AppDelegate.h"
#import "ViewController.h"

#import <FinApplet/FinApplet.h>
#import <FinAppletWXExt/FinAppletWXExt.h>
#import "FINWXButtonDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"applet_config" ofType:@"plist"];
    NSDictionary *configInfo = [NSDictionary dictionaryWithContentsOfFile:configPath];
    
    ViewController *rootVC = [[ViewController alloc] init];
    rootVC.appletInfo = configInfo;
    self.window.rootViewController = rootVC;
    
    NSMutableArray *storeArrayM = [NSMutableArray array];
    FATStoreConfig *storeConfig = [[FATStoreConfig alloc] init];
    storeConfig.sdkKey = configInfo[@"sdkKey"];;
    storeConfig.sdkSecret = configInfo[@"sdkSecret"];
    storeConfig.apiServer = configInfo[@"apiServer"];
    storeConfig.cryptType = FATApiCryptTypeSM;
    [storeArrayM addObject:storeConfig];

    FATUIConfig *uiConfig = [[FATUIConfig alloc] init];
    uiConfig.hideTransitionCloseButton = YES;
    uiConfig.disableSlideCloseAppletGesture = YES;
    uiConfig.capsuleConfig.hideCapsuleCloseButton = YES;

    FATConfig *config = [FATConfig configWithStoreConfigs:storeArrayM];
    [[FATClient sharedClient] initWithConfig:config uiConfig:uiConfig error:nil];
    [FATWXExtComponent registerComponent:@"***" universalLink:@"***"];
    
    NSLog(@"finclip sdk verson:%@", [FATClient sharedClient].version);
    
    [FATDelegateClientHelper sharedHelper].buttonOpenTypeDelegate = [FINWXButtonDelegate sharedHelper];

    [self.window makeKeyAndVisible];

    return YES;
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    if ([WXApi handleOpenURL:url delegate:[FATWXApiManager sharedManager]]) {
        return YES;
    }
    return YES;
}



- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if ([WXApi handleOpenURL:url delegate:[FATWXApiManager sharedManager]]) {
        return YES;
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    if ([WXApi handleOpenURL:url delegate:[FATWXApiManager sharedManager]]) {
        return YES;
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
  return [WXApi handleOpenUniversalLink:userActivity delegate:[FATWXApiManager sharedManager]];
}


@end
