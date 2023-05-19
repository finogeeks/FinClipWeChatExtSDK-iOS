//
//  FATExt_login.m
//  FinAppletWXExt
//
//  Created by 王兆耀 on 2022/8/18.
//

#import "FATExt_login.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "FATWXApiManager.h"
#import "FATWXUtils.h"

@implementation FATExt_login

- (void)setupApiWithSuccess:(void (^)(NSDictionary<NSString *, id> *successResult))success
                    failure:(void (^)(NSDictionary *failResult))failure
                     cancel:(void (^)(NSDictionary *cancelResult))cancel {
    
    NSDictionary *info = self.appletInfo.wechatLoginInfo;
    NSString *wechatOriginIdString = info[@"wechatOriginId"];
    if ([FATWXUtils fat_isEmptyWithString:wechatOriginIdString]) {
        if (failure) {
            failure(@{@"errMsg":@"wechatOriginId not exist"});
        }
        return;
    }
    NSString *pathString = info[@"profileUrl"];
    if ([FATWXUtils fat_isEmptyWithString:pathString]) {
        if (failure) {
            failure(@{@"errMsg":@"path not exist"});
        }
        return;
    }
    WXLaunchMiniProgramReq *launchMiniProgramReq = [WXLaunchMiniProgramReq object];
    launchMiniProgramReq.userName = info[@"wechatOriginId"];
    launchMiniProgramReq.path = pathString;
    if (self.appletInfo.appletVersionType == FATAppletVersionTypeRelease) {
        launchMiniProgramReq.miniProgramType = WXMiniProgramTypeRelease; //正式版
    } else if (self.appletInfo.appletVersionType == FATAppletVersionTypeTrial) {
        launchMiniProgramReq.miniProgramType = WXMiniProgramTypePreview; //体验版
    } else {
        launchMiniProgramReq.miniProgramType = WXMiniProgramTypeTest; //开发版
    }
    [WXApi sendReq:launchMiniProgramReq completion:^(BOOL success) {
        
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
