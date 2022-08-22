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
    if ([resp isKindOfClass: [WXLaunchMiniProgramResp class]]) {
        WXLaunchMiniProgramResp *loginResp = (WXLaunchMiniProgramResp*)resp;
        if (self.wxResponse) {
            self.wxResponse(loginResp);
        }
        return;
    }
}
@end
