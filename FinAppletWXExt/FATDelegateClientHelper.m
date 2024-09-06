//
//  FATDelegateClientHelper.m
//  FinAppletWXExt
//
//  Created by 王兆耀 on 2022/8/21.
//

#import "FATDelegateClientHelper.h"
#import "FATWXApiManager.h"
#import "FATWXUtils.h"

#import <WechatOpenSDK/WXApi.h>
#import <WechatOpenSDK/WXApiObject.h>

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

- (BOOL)getPhoneNumberWithAppletInfo:(FATAppletInfo *)appletInfo bindGetPhoneNumber:(void (^)(NSDictionary *result))bindGetPhoneNumber {
    if ([[FATDelegateClientHelper sharedHelper].buttonOpenTypeDelegate respondsToSelector:@selector(getPhoneNumberWithAppletInfo:bindGetPhoneNumber:)]) {
        [[FATDelegateClientHelper sharedHelper].buttonOpenTypeDelegate getPhoneNumberWithAppletInfo:appletInfo bindGetPhoneNumber:bindGetPhoneNumber];
    } else {
        NSDictionary *info = appletInfo.wechatLoginInfo;
        NSString *wechatOriginIdString = info[@"wechatOriginId"];
        if ([FATWXUtils fat_isEmptyWithString:wechatOriginIdString]) {
            NSDictionary *resultData = [FATWXUtils checkDataCode:@{@"errMsg":@"wechatOriginId not exist"}];
            if (bindGetPhoneNumber) {
                bindGetPhoneNumber(resultData);
            }
            return YES;
        }
        
        NSString *pathString = info[@"phoneUrl"];
        if ([FATWXUtils fat_isEmptyWithString:pathString]) {
            NSDictionary *resultData = [FATWXUtils checkDataCode:@{@"errMsg":@"path not exist"}];
            if (bindGetPhoneNumber) {
                bindGetPhoneNumber(resultData);
            }
            return YES;
        }
        WXLaunchMiniProgramReq *launchMiniProgramReq = [WXLaunchMiniProgramReq object];
        launchMiniProgramReq.userName = info[@"wechatOriginId"];
        launchMiniProgramReq.path = pathString;
        if (appletInfo.appletVersionType == FATAppletVersionTypeRelease) {
            launchMiniProgramReq.miniProgramType = WXMiniProgramTypeRelease;
        } else if (appletInfo.appletVersionType == FATAppletVersionTypeTrial) {
            launchMiniProgramReq.miniProgramType = WXMiniProgramTypePreview;
        } else {
            launchMiniProgramReq.miniProgramType = WXMiniProgramTypeTest;
        }
        [WXApi sendReq:launchMiniProgramReq completion:^(BOOL success) {
            
        }];
        
        [FATWXApiManager sharedManager].wxResponse = ^(WXLaunchMiniProgramResp *resp) {
            NSDictionary *dic = [FATWXUtils dictionaryWithJsonString:resp.extMsg];
            dic = [FATWXUtils checkDataCode:dic];
            if (bindGetPhoneNumber) {
                bindGetPhoneNumber(dic);
            }
        };
        return YES;
    }
    return NO;
}

- (BOOL)chooseAvatarWithAppletInfo:(nonnull FATAppletInfo *)appletInfo bindChooseAvatar:(nonnull void (^)(NSDictionary * _Nonnull))bindChooseAvatar {
    if ([[FATDelegateClientHelper sharedHelper].buttonOpenTypeDelegate respondsToSelector:@selector(chooseAvatarWithAppletInfo:bindChooseAvatar:)]) {
        return [[FATDelegateClientHelper sharedHelper].buttonOpenTypeDelegate chooseAvatarWithAppletInfo:appletInfo bindChooseAvatar:bindChooseAvatar];
    }
    return NO;
}

- (BOOL)contactWithAppletInfo:(nonnull FATAppletInfo *)appletInfo sessionFrom:(nonnull NSString *)sessionFrom sendMessageTitle:(nonnull NSString *)sendMessageTitle sendMessagePath:(nonnull NSString *)sendMessagePath sendMessageImg:(nonnull NSString *)sendMessageImg showMessageCard:(BOOL)showMessageCard {
    if ([[FATDelegateClientHelper sharedHelper].buttonOpenTypeDelegate respondsToSelector:@selector(contactWithAppletInfo:sessionFrom:sendMessageTitle:sendMessagePath:sendMessageImg:showMessageCard:)]) {
        return [[FATDelegateClientHelper sharedHelper].buttonOpenTypeDelegate contactWithAppletInfo:appletInfo sessionFrom:sessionFrom sendMessageTitle:sendMessageTitle sendMessagePath:sendMessagePath sendMessageImg:sendMessageImg showMessageCard:showMessageCard];
    }
    return NO;
}

- (BOOL)feedbackWithAppletInfo:(nonnull FATAppletInfo *)appletInfo {
    if ([[FATDelegateClientHelper sharedHelper].buttonOpenTypeDelegate respondsToSelector:@selector(feedbackWithAppletInfo:)]) {
        return [[FATDelegateClientHelper sharedHelper].buttonOpenTypeDelegate feedbackWithAppletInfo:appletInfo];
    }
    return NO;
}

- (BOOL)forwardAppletWithInfo:(nonnull NSDictionary *)contentInfo completion:(nonnull void (^)(FATExtensionCode, NSDictionary * _Nonnull))completion {
    if ([[FATDelegateClientHelper sharedHelper].buttonOpenTypeDelegate respondsToSelector:@selector(forwardAppletWithInfo:completion:)]) {
        return [[FATDelegateClientHelper sharedHelper].buttonOpenTypeDelegate forwardAppletWithInfo:contentInfo completion:completion];
    }
    return NO;
}

- (BOOL)getUserProfileWithAppletInfo:(FATAppletInfo *)appletInfo bindGetUserProfile:(void (^)(NSDictionary *result))bindGetUserProfile {
    if ([[FATDelegateClientHelper sharedHelper].buttonOpenTypeDelegate respondsToSelector:@selector(getUserProfileWithAppletInfo:bindGetUserProfile:)]) {
        return [[FATDelegateClientHelper sharedHelper].buttonOpenTypeDelegate getUserProfileWithAppletInfo:appletInfo bindGetUserProfile:bindGetUserProfile];;
    } else {
        FATAppletInfo *appInfo = [[FATClient sharedClient] currentApplet];
        NSDictionary *info = appInfo.wechatLoginInfo;
        NSString *wechatOriginIdString = info[@"wechatOriginId"];
        if ([FATWXUtils fat_isEmptyWithString:wechatOriginIdString]) {
            NSDictionary *resultData = [FATWXUtils checkDataCode:@{@"errMsg":@"wechatOriginId not exist"}];
            if (bindGetUserProfile) {
                bindGetUserProfile(resultData);
            }
            return YES;
        }
        NSString *pathString = info[@"profileUrl"];
        if ([FATWXUtils fat_isEmptyWithString:pathString]) {
            NSDictionary *resultData = [FATWXUtils checkDataCode:@{@"errMsg":@"path not exist"}];
            if (bindGetUserProfile) {
                bindGetUserProfile(resultData);
            }
            return YES;
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
            dic = [FATWXUtils checkDataCode:dic];
            if (bindGetUserProfile) {
                bindGetUserProfile(dic);
            }
        };
        return YES;
    }
    return NO;
}


- (BOOL)getUserInfoWithAppletInfo:(FATAppletInfo *)appletInfo bindGetUserInfo:(void (^)(NSDictionary *result))bindGetUserInfo {
    if ([[FATDelegateClientHelper sharedHelper].buttonOpenTypeDelegate respondsToSelector:@selector(getUserInfoWithAppletInfo:bindGetUserInfo:)]) {
        return [[FATDelegateClientHelper sharedHelper].buttonOpenTypeDelegate getUserInfoWithAppletInfo:appletInfo bindGetUserInfo:bindGetUserInfo];;
    }
    return NO;
}

- (BOOL)launchAppWithAppletInfo:(nonnull FATAppletInfo *)appletInfo appParameter:(nonnull NSString *)appParameter bindError:(nonnull void (^)(NSDictionary * _Nonnull))bindError bindLaunchApp:(nonnull void (^)(NSDictionary * _Nonnull))bindLaunchApp {
    if ([[FATDelegateClientHelper sharedHelper].buttonOpenTypeDelegate respondsToSelector:@selector(launchAppWithAppletInfo:appParameter:bindError:bindLaunchApp:)]) {
        return [[FATDelegateClientHelper sharedHelper].buttonOpenTypeDelegate launchAppWithAppletInfo:appletInfo appParameter:appParameter bindError:bindError bindLaunchApp:bindLaunchApp];
    }
    return NO;
}

@end
