//
//  FATExt_getUserProfile.m
//  FinAppletWXExt
//
//  Created by 王兆耀 on 2022/8/18.
//

#import "FATExt_getUserProfile.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "FATWXApiManager.h"
#import "FATWXUtils.h"

@implementation FATExt_getUserProfile

- (void)setupApiWithSuccess:(void (^)(NSDictionary<NSString *, id> *successResult))success
                    failure:(void (^)(NSDictionary *failResult))failure
                     cancel:(void (^)(NSDictionary *cancelResult))cancel {
    [[FATClient sharedClient] fat_requestAppletAuthorize:FATAuthorizationTypeUserProfile appletId:self.appletInfo.appId complete:^(NSInteger status) {
        if (status != 0) {
            if (failure) {
                failure(@{@"errMsg":@"auth deny"});
            }
            return;
        }
        
        
        FATAppletInfo *appInfo = [[FATClient sharedClient] currentApplet];
        NSDictionary *info = appInfo.wechatLoginInfo;
        NSString *pathString = info[@"profileUrl"];
        if ([FATWXUtils fat_isEmptyWithString:pathString]) {
            if (failure) {
                failure(@{@"errMsg":@"path not exist"});
            }
            return;
        }
        WXLaunchMiniProgramReq *launchMiniProgramReq = [WXLaunchMiniProgramReq object];
        launchMiniProgramReq.userName = info[@"wechatOriginId"];  //拉起的小程序的username
        launchMiniProgramReq.path = pathString;    //拉起小程序页面的可带参路径，不填默认拉起小程序首页，对于小游戏，可以只传入 query 部分，来实现传参效果，如：传入 "?foo=bar"。
        if (appInfo.appletVersionType == FATAppletVersionTypeRelease) {
            launchMiniProgramReq.miniProgramType = WXMiniProgramTypeRelease; //正式版
        } else if (appInfo.appletVersionType == FATAppletVersionTypeTrial) {
            launchMiniProgramReq.miniProgramType = WXMiniProgramTypePreview; //体验版
        } else {
            launchMiniProgramReq.miniProgramType = WXMiniProgramTypeTest; //开发版
        }
        [WXApi sendReq:launchMiniProgramReq completion:^(BOOL success) {
            
        }];
        
        [FATWXApiManager sharedManager].wxResponse = ^(WXLaunchMiniProgramResp *resp) {
            NSDictionary *dic = [FATWXUtils dictionaryWithJsonString:resp.extMsg];
            
            BOOL result = [dic[@"errMsg"] containsString:@"fail"] ? NO : YES;
            if (result) {
                if (success) {
                    success(dic);
                }
            } else {
                if (failure) {
                    failure(dic);
                }
            }};
        
    }];
}

@end
