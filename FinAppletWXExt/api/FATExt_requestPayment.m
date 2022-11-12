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

- (void)setupApiWithSuccess:(void (^)(NSDictionary<NSString *, id> *successResult))success
                    failure:(void (^)(NSDictionary *failResult))failure
                     cancel:(void (^)(NSDictionary *cancelResult))cancel {
    
    NSDictionary *info = self.appletInfo.wechatLoginInfo;
    NSString *pathString = info[@"paymentUrl"];
    if ([FATWXUtils fat_isEmptyWithString:pathString]) {
        if (failure) {
            failure(@{@"errMsg":@"path not exist"});
        }
        return;
    }
    NSString *payString = [NSString stringWithFormat:@"?appId=%@&nonceStr=%@&package=%@&paySign=%@&signType=%@&timeStamp=%@&type=%@", self.appId, self.nonceStr, self.package, self.paySign, self.signType, self.timeStamp, self.type];
    WXLaunchMiniProgramReq *launchMiniProgramReq = [WXLaunchMiniProgramReq object];
    launchMiniProgramReq.userName = info[@"wechatOriginId"];
    launchMiniProgramReq.path = [NSString stringWithFormat:@"%@%@", pathString, payString];
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
        
        BOOL result = [dic[@"errMsg"] containsString:@"fail"] ? NO : YES;
        if (result) {
            if (success) {
                success(dic);
            }
        } else {
            if (failure) {
                failure(dic);
            }
        }
        
//        if (callback) {
//            callback([dic[@"errMsg"] containsString:@"fail"] ? FATExtensionCodeFailure : FATExtensionCodeSuccess, dic);
//        }
    };
}

@end
