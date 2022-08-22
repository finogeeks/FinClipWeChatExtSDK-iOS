//
//  FATWXExtComponent.m
//  FinAppletWXExt
//
//  Created by 王兆耀 on 2022/8/18.
//

#import "FATWXExtComponent.h"
#import <FinApplet/FinApplet.h>
#import "FATWXExtBaseApi.h"
#import "FATDelegateClientHelper.h"

@implementation FATWXExtComponent


+ (BOOL)registerComponent:(NSString *)appld universalLink:(NSString *)universalLink {
    
    //向微信注册
    BOOL isSuccess = [WXApi registerApp:appld universalLink:universalLink];
    
    [FATClient sharedClient].delegate = [FATDelegateClientHelper sharedHelper];

    [[FATClient sharedClient] registerExtensionApi:@"login" handler:^(FATAppletInfo *appletInfo, id param, FATExtensionApiCallback callback) {
        FATWXExtBaseApi *extBaseApi = [FATWXExtBaseApi apiWithCommand:@"login" param:param];
        [extBaseApi setupApiWithCallback:callback];
    }];

    [[FATClient sharedClient] registerExtensionApi:@"getUserProfile" handler:^(FATAppletInfo *appletInfo, id param, FATExtensionApiCallback callback) {
        FATWXExtBaseApi *extBaseApi = [FATWXExtBaseApi apiWithCommand:@"getUserProfile" param:param];
        [extBaseApi setupApiWithCallback:callback];
    }];
    
    [[FATClient sharedClient] registerExtensionApi:@"requestPayment" handler:^(FATAppletInfo *appletInfo, id param, FATExtensionApiCallback callback) {
        FATWXExtBaseApi *extBaseApi = [FATWXExtBaseApi apiWithCommand:@"requestPayment" param:param];
        [extBaseApi setupApiWithCallback:callback];
    }];
    
    return isSuccess;
}


@end
