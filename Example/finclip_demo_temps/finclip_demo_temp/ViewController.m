//
//  ViewController.m
//
//
//  Created by finogeeks.com on 2022/3/21.
//

#import "ViewController.h"

#import <FinApplet/FinApplet.h>

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self performSelectorOnMainThread:@selector(startApplet) withObject:nil waitUntilDone:NO];
}

- (void)startApplet {
    
    NSString *appletId = self.appletInfo[@"appletId"];
    NSString *apiServer = self.appletInfo[@"apiServer"];
    NSString *offlineFrameworkZipPath = [[NSBundle mainBundle] pathForResource:@"offlineFramework" ofType:@"zip"];
    NSString *offlineMiniprogramZipPath = [[NSBundle mainBundle] pathForResource:@"offlineMiniprogram" ofType:@"zip"];

    FATAppletRequest *request = [[FATAppletRequest alloc] init];
    request.appletId = appletId;
    request.apiServer = apiServer;
    request.transitionStyle = FATTranstionStyleUp;
    request.animated = NO;
    if ([offlineFrameworkZipPath length]) {
        request.offlineFrameworkZipPath = offlineFrameworkZipPath;
    }
    if ([offlineMiniprogramZipPath length]) {
        request.offlineMiniprogramZipPath = offlineMiniprogramZipPath;
    }

    [[FATClient sharedClient] startAppletWithRequest:request InParentViewController:self completion:^(BOOL result, FATError *error) {
        if (error) {
            NSLog(@"打开小程序失败:%@", error);
        } else {
            NSLog(@"打开小程序成功");
        }
    } closeCompletion:^{
//        exit(0);
    }];
}

@end
