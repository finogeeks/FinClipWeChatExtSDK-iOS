//
//  FINWXButtonDelegate.m
//  demo
//
//  Created by 王兆耀 on 2022/9/5.
//  Copyright © 2022 finogeeks. All rights reserved.
//

#import "FINWXButtonDelegate.h"

static FINWXButtonDelegate *instance = nil;

@implementation FINWXButtonDelegate

+ (instancetype)sharedHelper {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}


#pragma mark - button open-type

- (BOOL)forwardAppletWithInfo:(NSDictionary *)contentInfo completion:(void (^)(FATExtensionCode code, NSDictionary *result))completion {
    NSLog(@"小程序信息:%@", contentInfo);
    return YES;
}

- (BOOL)getUserInfoWithAppletInfo:(FATAppletInfo *)appletInfo bindGetUserInfo:(void (^)(NSDictionary *result))bindGetUserInfo {
    return YES;
}


- (BOOL)contactWithAppletInfo:(FATAppletInfo *)appletInfo sessionFrom:(NSString *)sessionFrom sendMessageTitle:(NSString *)sendMessageTitle sendMessagePath:(NSString *)sendMessagePath sendMessageImg:(NSString *)sendMessageImg showMessageCard:(BOOL)showMessageCard {
    NSLog(@"小程序信息:%@", appletInfo);
    return YES;
}

//- (void)getPhoneNumberWithAppletInfo:(FATAppletInfo *)appletInfo bindGetPhoneNumber:(void (^)(NSDictionary *result))bindGetPhoneNumber {
//    NSLog(@"小程序信息:%@", appletInfo);
//    if (bindGetPhoneNumber) {
//        bindGetPhoneNumber(@{@"phone":@"18812345678"});
//    }
//}

- (BOOL)launchAppWithAppletInfo:(FATAppletInfo *)appletInfo appParameter:(NSString *)appParameter bindError:(void (^)(NSDictionary *result))bindError bindLaunchApp:(void (^)(NSDictionary *result))bindLaunchApp {
    NSLog(@"小程序信息:%@", appletInfo);
    if (bindLaunchApp) {
        bindLaunchApp(@{@"errMsg":@"ok"});
    }
    return YES;
}

- (BOOL)feedbackWithAppletInfo:(FATAppletInfo *)appletInfo {
    NSLog(@"小程序信息:%@", appletInfo);
    return YES;
}

- (BOOL)chooseAvatarWithAppletInfo:(FATAppletInfo *)appletInfo bindChooseAvatar:(void (^)(NSDictionary *result))bindChooseAvatar {
    NSLog(@"小程序信息:%@", appletInfo);
    if (bindChooseAvatar) {
        bindChooseAvatar(@{@"avatarUrl":@"https://mmbiz.qpic.cn/mmbiz/icTdbqWNOwNRna42FI242Lcia07jQodd2FJGIYQfG0LAJGFxM4FbnQP6yfMxBgJ0F3YRqJCJ1aPAK2dQagdusBZg/0"});
    }
    return YES;
}

@end
