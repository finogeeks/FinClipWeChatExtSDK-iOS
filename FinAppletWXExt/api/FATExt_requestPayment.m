//
//  FATExt_requestPayment.m
//  FinAppletWXExt
//
//  Created by 王兆耀 on 2022/8/18.
//

#import "FATExt_requestPayment.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "FATWXApiManager.h"
#import "FATWXUtils.h"

@implementation FATExt_requestPayment

- (void)setupApiWithCallback:(FATExtensionApiCallback)callback {
    
    FATAppletInfo *appInfo = [[FATClient sharedClient] currentApplet];
    NSDictionary *info = appInfo.wechatLoginInfo;
    NSString *pathString = info[@"paymentUrl"];
    if ([FATWXUtils fat_isEmptyWithString:pathString]) {
        if (callback) {
            callback(FATExtensionCodeFailure,@{@"errMsg":@"path not exist"});
        }
        return;
    }
    NSString *payString = [NSString stringWithFormat:@"?appId=%@&nonceStr=%@&package=%@&paySign=%@&signType=%@&timeStamp=%@&type=%@", self.appId, self.nonceStr, self.package, self.paySign, self.signType, self.timeStamp, self.type];
    WXLaunchMiniProgramReq *launchMiniProgramReq = [WXLaunchMiniProgramReq object];
    launchMiniProgramReq.userName = info[@"wechatOriginId"];
    launchMiniProgramReq.path = [NSString stringWithFormat:@"%@%@", pathString, payString];
    if (appInfo.appletVersionType == FATAppletVersionTypeRelease) {
        launchMiniProgramReq.miniProgramType = WXMiniProgramTypeRelease;
    } else if (appInfo.appletVersionType == FATAppletVersionTypeTrial) {
        launchMiniProgramReq.miniProgramType = WXMiniProgramTypePreview;
    } else {
        launchMiniProgramReq.miniProgramType = WXMiniProgramTypeTest;
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
