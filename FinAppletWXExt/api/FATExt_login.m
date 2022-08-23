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

- (void)setupApiWithCallback:(FATExtensionApiCallback)callback {
    FATAppletInfo *appInfo = [[FATClient sharedClient] currentApplet];
    NSDictionary *info = appInfo.wechatLoginInfo;
    NSString *pathString = [NSString stringWithFormat:@"%@", info[@"profileUrl"]];
    if ([FATWXUtils fat_isEmptyWithString:pathString]) {
        if (callback) {
            callback(FATExtensionCodeFailure,@{@"errMsg":@"path not exist"});
        }
        return;
    }
    WXLaunchMiniProgramReq *launchMiniProgramReq = [WXLaunchMiniProgramReq object];
    launchMiniProgramReq.userName = info[@"wechatOriginId"];
    launchMiniProgramReq.path = pathString;
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
