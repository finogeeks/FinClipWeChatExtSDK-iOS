//
//  FATDelegateClientHelper.m
//  FinAppletWXExt
//
//  Created by 王兆耀 on 2022/8/21.
//

#import "FATDelegateClientHelper.h"
#import "WXApi.h"
#import "FATWXApiManager.h"
#import "FATWXUtils.h"

static FATDelegateClientHelper *instance = nil;

@implementation FATDelegateClientHelper

+ (instancetype)sharedHelper {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

- (void)getPhoneNumberWithAppletInfo:(FATAppletInfo *)appletInfo bindGetPhoneNumber:(void (^)(NSDictionary *result))bindGetPhoneNumber {
    NSDictionary *info = appletInfo.wechatLoginInfo;
    NSString *pathString = [NSString stringWithFormat:@"%@", info[@"phoneUrl"]];

    if ([FATWXUtils fat_isEmptyWithString:pathString]) {
        if (bindGetPhoneNumber) {
            bindGetPhoneNumber(@{@"errMsg":@"path not exist"});
        }
        return;
    }
    WXLaunchMiniProgramReq *launchMiniProgramReq = [WXLaunchMiniProgramReq object];
    launchMiniProgramReq.userName = info[@"wechatOriginId"];  //拉起的小程序的username
    launchMiniProgramReq.path = pathString;
    if (appletInfo.appletVersionType == FATAppletVersionTypeRelease) {
        launchMiniProgramReq.miniProgramType = WXMiniProgramTypeRelease; //正式版
    } else if (appletInfo.appletVersionType == FATAppletVersionTypeTrial) {
        launchMiniProgramReq.miniProgramType = WXMiniProgramTypePreview; //开发版
    } else {
        launchMiniProgramReq.miniProgramType = WXMiniProgramTypePreview; //体验版
    }
    [WXApi sendReq:launchMiniProgramReq completion:^(BOOL success) {
        
    }];
    
    [FATWXApiManager sharedManager].wxResponse = ^(WXLaunchMiniProgramResp *resp) {
        NSDictionary *dic = [FATWXUtils dictionaryWithJsonString:resp.extMsg];
        if (bindGetPhoneNumber) {
            bindGetPhoneNumber(dic);
        }
    };
}

@end
