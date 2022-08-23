//
//  FATWXApiManager.m
//  FinAppletWXExt
//
//  Created by 王兆耀 on 2022/8/20.
//

#import "FATWXApiManager.h"

@implementation FATWXApiManager

+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static FATWXApiManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[FATWXApiManager alloc] init];
    });
    return instance;
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    NSLog(@"test3 class = %@", resp.class);
    NSLog(@"test3 resp = %@ resp.type=%@ resp.errCode=%@ resp.errStr=%@", resp, resp.type, resp.errCode, resp.errStr);
    if ([resp isKindOfClass: [WXLaunchMiniProgramResp class]]) {
        NSLog(@"test4");
        WXLaunchMiniProgramResp *loginResp = (WXLaunchMiniProgramResp*)resp;
        if (self.wxResponse) {
            self.wxResponse(loginResp);
            NSLog(@"test5");
        }
        return;
    } else {
        NSLog(@"不支持的类型，返回");
    }
}

- (void)onLog:(NSString*)log logLevel:(WXLogLevel)level {
    NSLog(@"%@", log);
}

@end
