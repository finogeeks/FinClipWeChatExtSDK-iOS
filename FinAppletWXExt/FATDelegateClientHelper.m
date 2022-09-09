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

- (BOOL)getPhoneNumberWithAppletInfo:(FATAppletInfo *)appletInfo bindGetPhoneNumber:(void (^)(NSDictionary *result))bindGetPhoneNumber {
    if ([[FATDelegateClientHelper sharedHelper].buttonOpenTypeDelegate respondsToSelector:@selector(getPhoneNumberWithAppletInfo:bindGetPhoneNumber:)]) {
        [[FATDelegateClientHelper sharedHelper].buttonOpenTypeDelegate getPhoneNumberWithAppletInfo:appletInfo bindGetPhoneNumber:bindGetPhoneNumber];
    } else {
        NSDictionary *info = appletInfo.wechatLoginInfo;
        NSString *pathString = info[@"phoneUrl"];

        if ([FATWXUtils fat_isEmptyWithString:pathString]) {
            if (bindGetPhoneNumber) {
                bindGetPhoneNumber(@{@"errMsg":@"path not exist"});
            }
            return NO;
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
