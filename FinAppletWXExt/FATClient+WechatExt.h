//
//  FATClient+WechatExt.h
//  FinAppletWXExt
//
//  Created by 滔 on 2022/10/26.
//

#import <FinApplet/FinApplet.h>

NS_ASSUME_NONNULL_BEGIN

@interface FATClient (WechatExt)

/// 获取小程序的权限
/// @param authType  权限类型，0:相册 1:相机 2:麦克风 3:位置 4:蓝牙 5:5:相册(Additions) 6:通讯录 7:用户信息(userprofile)  8:手机号(phoneNumber)
/// @param appletId  小程序id
/// @param complete 结果回调 status: 0 允许 1:用户拒绝 2: sdk拒绝
- (void)fat_requestAppletAuthorize:(FATAuthorizationType)authType appletId:(NSString *)appletId complete:(void (^)(NSInteger status))complete;
@end

NS_ASSUME_NONNULL_END
