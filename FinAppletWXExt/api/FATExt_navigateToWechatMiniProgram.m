//
//  FATExt_navigateToWechatMiniProgram.m
//  FinAppletWXExt
//
//  Created by 王兆耀 on 2023/4/24.
//

#import "FATExt_navigateToWechatMiniProgram.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "FATWXApiManager.h"
#import "FATWXUtils.h"

@implementation FATExt_navigateToWechatMiniProgram

- (void)setupApiWithSuccess:(void (^)(NSDictionary<NSString *, id> *successResult))success
                    failure:(void (^)(NSDictionary *failResult))failure
                     cancel:(void (^)(NSDictionary *cancelResult))cancel {
    WXLaunchMiniProgramReq *launchMiniProgramReq = [WXLaunchMiniProgramReq object];
    launchMiniProgramReq.userName = self.originId;
    launchMiniProgramReq.path = self.path;
    if ([self.envVersion isEqualToString:@"develop"]) {
        launchMiniProgramReq.miniProgramType = WXMiniProgramTypeTest;
    } else if ([self.envVersion isEqualToString:@"trial"]) {
        launchMiniProgramReq.miniProgramType = WXMiniProgramTypePreview;
    } else {
        launchMiniProgramReq.miniProgramType = WXMiniProgramTypeRelease;
    }
    [WXApi sendReq:launchMiniProgramReq completion:^(BOOL success) {
        if (!success) {
            failure(@{});
        }
    }];
    
    [FATWXApiManager sharedManager].wxResponse = ^(WXLaunchMiniProgramResp *resp) {
        NSDictionary *dic = [FATWXUtils dictionaryWithJsonString:resp.extMsg];
        
        BOOL result = [dic[@"errMsg"] containsString:@"fail"];
        if (!result) {
            if (success) {
                success(dic);
            }
        } else {
            if (failure) {
                failure(dic);
            }
        }
    };
}

@end
