//
//  FATWXApiManager.m
//  FinAppletWXExt
//
//  Created by 王兆耀 on 2022/8/20.
//

#import "FATWXApiManager.h"
#import <FinApplet/FinApplet.h>
#import "FATWXUtils.h"

static FATWXApiManager *instance = nil;

@implementation FATWXApiManager

+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass: [WXLaunchMiniProgramResp class]]) {
        WXLaunchMiniProgramResp *loginResp = (WXLaunchMiniProgramResp*)resp;
        if (self.wxResponse) {
            self.wxResponse(loginResp);
        }
        return;
    } else {
        NSLog(@"不支持的类型返回resp=%@", resp);
    }
}

- (void)onReq:(BaseReq *)req {
    if ([req isKindOfClass:[LaunchFromWXReq class]]) {
        LaunchFromWXReq *launchReq = (LaunchFromWXReq *) req;
        [self managerDidRecvLaunchFromWXReq:launchReq];
    }
}

- (void)managerDidRecvLaunchFromWXReq:(LaunchFromWXReq *)launchReq {
    NSString *ext = launchReq.message.messageExt;
    NSDictionary *dic = [self dictionaryWithJsonString:ext];
    NSString *appId = dic[@"appId"];
    [[FATClient sharedClient] closeAllAppletsWithCompletion:^{
        [[FATClient sharedClient] startRemoteApplet:appId startParams:@{@"path":dic[@"path"] ? dic[@"path"] : @"", @"query":dic[@"query"] ? dic[@"query"] : @""} InParentViewController:[FATWXUtils topViewController] completion:nil];
    }];
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
