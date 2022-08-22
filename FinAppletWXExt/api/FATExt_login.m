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

@interface FATExt_login ()

@property (nonatomic, copy) FATExtensionApiCallback callBack;

@end

@implementation FATExt_login

- (void)setupApiWithCallback:(FATExtensionApiCallback)callback {
    
    FATAppletInfo *appInfo = [[FATClient sharedClient] currentApplet];
    NSDictionary *info = appInfo.wechatLoginInfo;    
    WXLaunchMiniProgramReq *launchMiniProgramReq = [WXLaunchMiniProgramReq object];
    launchMiniProgramReq.userName = info[@"wechatOriginId"];
    launchMiniProgramReq.path = info[@"profileUrl"];
    if (appInfo.appletVersionType == FATAppletVersionTypeRelease) {
        launchMiniProgramReq.miniProgramType = WXMiniProgramTypeRelease; //正式版
    } else if (appInfo.appletVersionType == FATAppletVersionTypeTrial) {
        launchMiniProgramReq.miniProgramType = WXMiniProgramTypePreview; //开发版
    } else {
        launchMiniProgramReq.miniProgramType = WXMiniProgramTypePreview; //体验版
    }
    [WXApi sendReq:launchMiniProgramReq completion:^(BOOL success) {
        
    }];
    NSLog(@"test1");

    [FATWXApiManager sharedManager].wxResponse = ^(WXLaunchMiniProgramResp *resp) {
        NSDictionary *dic = [FATWXUtils dictionaryWithJsonString:resp.extMsg];
        if (callback) {
            NSLog(@"test2");
            callback([dic[@"errMsg"] containsString:@"fail"] ? FATExtensionCodeFailure : FATExtensionCodeSuccess, dic);
        }
    };
}



@end
