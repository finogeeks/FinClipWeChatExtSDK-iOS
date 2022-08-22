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

- (void)setupApiWithCallback:(FATExtensionApiCallback)callback {
    
    FATAppletInfo *appInfo = [[FATClient sharedClient] currentApplet];
    NSDictionary *info = appInfo.wechatLoginInfo;
    WXLaunchMiniProgramReq *launchMiniProgramReq = [WXLaunchMiniProgramReq object];
    launchMiniProgramReq.userName = info[@"wechatOriginId"];  //拉起的小程序的username
    launchMiniProgramReq.path = info[@"profileUrl"];    //拉起小程序页面的可带参路径，不填默认拉起小程序首页，对于小游戏，可以只传入 query 部分，来实现传参效果，如：传入 "?foo=bar"。
    if (appInfo.appletVersionType == FATAppletVersionTypeRelease) {
        launchMiniProgramReq.miniProgramType = WXMiniProgramTypeRelease; //正式版
    } else if (appInfo.appletVersionType == FATAppletVersionTypeTrial) {
        launchMiniProgramReq.miniProgramType = WXMiniProgramTypePreview; //开发版
    } else {
        launchMiniProgramReq.miniProgramType = WXMiniProgramTypePreview; //体验版
    }
    [WXApi sendReq:launchMiniProgramReq completion:^(BOOL success) {
        
    }];
    
    [FATWXApiManager sharedManager].wxResponse = ^(WXLaunchMiniProgramResp *resp) {
        NSDictionary *dic = [FATWXUtils dictionaryWithJsonString:resp.extMsg];
        if (callback) {
            callback([dic[@"errMsg"] containsString:@"fail"] ? FATExtensionCodeFailure : FATExtensionCodeSuccess, dic);
        }
    };
}

@end
