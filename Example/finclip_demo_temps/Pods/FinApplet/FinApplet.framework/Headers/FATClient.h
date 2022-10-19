//
//  FATClient.h
//  FinApplet
//
//  Created by Haley on 2019/3/27.
//  Copyright © 2019 finogeeks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FATConfig.h"
#import "FATUIConfig.h"
#import "FATConstant.h"
#import "FATAppletInfo.h"
#import "FATAppletDelegate.h"
#import "IFATNativeViewManager.h"
#import "IFATXLogManager.h"
#import "FATAppletRequest.h"
#import "FATSearchAppletRequest.h"
#import "FATError.h"
#import "FATAppletConfig.h"
#import "FATAppletButtonOpenTypeDelegate.h"
#import "FATAppletLifeCycleDelegate.h"
#import "FATAppletMoreMenuDelegate.h"
#import "FATLocalAppletDelegate.h"
#import "FATAppletConfigurationDelegate.h"
#import "FATAppletWaterMaskAndScreenCaptureDelegate.h"

@interface FATClient : NSObject

@property (nonatomic, strong, readonly) FATConfig *config;

/// UI控件的样式配置
@property (nonatomic, strong, readonly) FATUIConfig *uiConfig;

@property (nonatomic, copy, readonly) NSString *version;

@property (nonatomic, assign, readonly) BOOL inited;

/// 日志记录快捷开关（未配置记录等级时，默认等级为FATLogLevelDebug）
@property (nonatomic, assign, getter=isEnableLog) BOOL enableLog;

@property (nonatomic, weak) id<FATAppletDelegate> delegate __attribute__((deprecated("该属性(自2.37.13起)废弃，请使用buttonOpenTypeDelegate，lifeCycleDelegate，moreMenuDelegate，localAppletDelegate，configurationDelegate，waterMaskAndScreenCaptureDelegate等属性的能力")));

/**
 button的open-type能力相关的代理事件
 */
@property (nonatomic, weak) id<FATAppletButtonOpenTypeDelegate> buttonOpenTypeDelegate;

/**
 小程序生命周期相关的代理事件
 */
@property (nonatomic, weak) id<FATAppletLifeCycleDelegate> lifeCycleDelegate;

/**
 右上角胶囊和更多按钮中自定义的菜单相关的代理事件
 */
@property (nonatomic, weak) id<FATAppletMoreMenuDelegate> moreMenuDelegate;

/**
 本地小程序相关的代理事件
 */
@property (nonatomic, weak) id<FATLocalAppletDelegate> localAppletDelegate;

/**
 小程序设置配置项,灰度扩展,H5 hook的代理事件
 */
@property (nonatomic, weak) id<FATAppletConfigurationDelegate> configurationDelegate;

/**
 小程序自定义添加水印和截屏，录屏的代理事件
 */
@property (nonatomic, weak) id<FATAppletWaterMaskAndScreenCaptureDelegate> waterMaskAndScreenCaptureDelegate;

/** nativeView 控制器*/
@property (nonatomic, strong) id<IFATNativeViewManager> nativeViewManager;
/** 日志管理器*/
@property (nonatomic, strong) id<IFATXLogManager> logManager;

+ (instancetype)sharedClient;

/// 初始化SDK
/// @param config 配置对象
/// @param error 初始化失败时返回的error
- (BOOL)initWithConfig:(FATConfig *)config error:(NSError **)error;

/// 初始化SDK
/// @param config 配置对象
/// @param uiConfig UI配置对象
/// @param error 初始化失败时返回的error
- (BOOL)initWithConfig:(FATConfig *)config uiConfig:(FATUIConfig *)uiConfig error:(NSError **)error;

/**
 清空内存中缓存的小程序
 */
- (void)clearMemoryCache;

/**
清除内存中的某个小程序
*/
- (void)clearMemeryApplet:(NSString *)appletId;

/**
删除本地的所有小程序
*/
- (void)clearLocalApplets;

/**
 从本地删除小程序
 
 @param appletId 小程序id
 @return BOOL 结果
 */
- (BOOL)removeAppletFromLocalCache:(NSString *)appletId;

/*
 处理URL
 @param URL 具体的URL路由
 URL格式:${scheme}://applet/appid/${appId}?path=${path}&query=${encode过的query}&apiServer=${encode过的apiServer}
 例如：fatae55433be2f62915://applet/appid/617bb42f530fb30001509b27?path=/packages/d/index&query=key%3Dvalue%26name%3Dtable&apiServer=https%3A%2F%2Fwww.finclip.com
 其中，必须有的是scheme和appId，如：fatae55433be2f62915://applet/appid/617bb42f530fb30001509b27
 scheme的构建规则是：fat+${SDKKey的16位小写md5};如果需要在其他软件中调用本App，还需要把这个scheme新增到target->info->URL types中
 */
- (BOOL)handleOpenURL:(NSURL *)URL;

/*
 处理Universal Link
 @param URL Universal Link URL
 URL格式:${UniversalLink}?appid=${appId}&path=${path}&query=${encode过的query}&apiServer=${encode过的apiServer}
 例如:https://www.finclip.com/mop/scattered-page/#/mop-download?appid=xx&query=xxx&path=xxx
 其中，必须有的是UniversalLink和appId，如https://www.finclip.com/mop/scattered-page/#/mop-download?appid=xx
 */
- (BOOL)handleOpenUniversalLinkURL:(NSURL *)URL;

/// 打开个人信息与权限管理页面
/// @param parentViewController 父控制器，打开的个人信息与权限管理页面会在父控制器上模态弹出
- (void)openPrivacyManage:(UIViewController *)parentViewController;

/// 当前正在使用的小程序
- (FATAppletInfo *)currentApplet;

#pragma mark - close applet

/**
关闭当前的小程序
@param animated 是否显示动画
@param completion 关闭完成的回调
*/
- (void)closeCurrentApplet:(BOOL)animated completion:(dispatch_block_t)completion;

/**
关闭打开的指定小程序
@param animated 是否显示动画
@param completion 关闭完成的回调
*/
- (void)closeApplet:(NSString *)appletId animated:(BOOL)animated completion:(dispatch_block_t)completion;

/**
关闭当前打开的所有小程序
@param completion 关闭完成的回调
*/
- (void)closeAllAppletsWithCompletion:(dispatch_block_t)completion;

#pragma mark - update & download applets api
/**
 @brief 批量更新小程序
 @param appIds 小程序id数组
 @param apiServer 服务器地址
 @param complete 批量更新小程序回调
 */
- (void)downloadApplets:(NSArray *)appIds apiServer:(NSString *)apiServer complete:(void (^)(NSArray *results, FATError *error))complete;

#pragma mark - recent used applet api
/**
 获取本地的小程序
 
 @return 小程序数组<FATAppletInfo>
 */
- (NSArray *)getAppletsFromLocalCache;

#pragma mark - extension api
/**
 注册扩展Api
 
 @param extApiName 扩展的api名称
 @param handler 回调
 @return 返回注册结果
 */
- (BOOL)registerExtensionApi:(NSString *)extApiName handler:(void (^)(FATAppletInfo *appletInfo, id param, FATExtensionApiCallback callback))handler;

/**
 注册同步扩展Api
 @param syncExtApiName 扩展的api名称
 @param handler 回调
 @return 返回注册结果
 */
- (BOOL)registerSyncExtensionApi:(NSString *)syncExtApiName handler:(NSDictionary * (^)(FATAppletInfo *appletInfo, id param))handler;

/**
 为HTML 注册要调用的原生 api
 @param webApiName 原生api名字
 @param handler 回调
 */
- (BOOL)fat_registerWebApi:(NSString *)webApiName handler:(void (^)(FATAppletInfo *appletInfo, id param, FATExtensionApiCallback callback))handler;

/**
 原生调用HTML中的JS函数（前台运行的小程序）
 @param eventName 函数名
 @param paramString 函数的参数字典转成的json
 @param pageId webView ID，可不传，默认调用最顶层页面里H5的函数
 @param handler 调用结果回调：error code为FATErrorCodeAppletNotFound，未找到前台运行的小程序
 */
- (void)fat_callWebApi:(NSString *)eventName paramString:(NSString *)paramString pageId:(NSNumber *)pageId handler:(void (^)(id result, NSError *error))handler;

/**
 原生调用HTML中的JS函数（appletId指定的小程序）
 @param eventName 函数名
 @param appletId 小程序id，指定调用的小程序
 @param paramString 函数的参数字典转成的json
 @param pageId webView ID，可不传，默认调用最顶层页面里H5的函数
 @param handler 调用结果回调：error code为FATErrorCodeForegroundAppletNotFound，未找到appletId指定小程序
*/
- (void)fat_callWebApi:(NSString *)eventName applet:(NSString *)appletId paramString:(NSString *)paramString pageId:(NSNumber *)pageId handler:(void (^)(id result, NSError *error))handler;

#pragma mark - tool api

/**
 保存文件到小程序的缓存路径
 
 @param fileData 文件的二进制数据
 @param fileName 文件名，需要保证文件名唯一，否则可能会覆盖
 @return 文件的本地路径，例如:finfile://tmp_b118e2e5e2618d4d8bbbb7b0a3ad806a.jpg
 */
- (NSString *)saveFile:(NSData *)fileData fileName:(NSString *)fileName;

/**
将文件路径转为绝对路径
如果是 网络文件路径，则直接返回。
如果是小程序中的路径，比如finfile://tmp_b118e2e5e2618d4d8bbbb7b0a3ad806a.jpg ，则会转为本地绝对路径
如果是小程序包中的文件路径，比如image/xxx.jpg，也会转为绝对路径
其他情况则返回传入的路径

@param path  文件路径
@return 文件的绝对路径
*/
- (NSString *)fat_absolutePathWithPath:(NSString *)path;

/**
 获取小程序内文件的完整路径，或临时文件的完整路径
 
 @param fileName 文件名
 @return 文件的完整路径
 */
- (NSString *)getFileAddressWithfileName:(NSString *)fileName;

/**
 生成当前页面截图
 宽高比是5:4
 */
- (UIImage *)getCurrentAppletImage;

/**
 获取当前加载H5的URL
 如果小程序当前页面加载的不是H5，则返回nil
 */
- (NSURL *)getCurrentWebViewURL;

/**
 获取小程序页面的userAgent
 */
- (void)getCurrentWebViewUserAgentWithCompletion:(void (^)(NSString *userAgent, NSError *error))completionHandler;

/**
 国密SM3加密
 
 @param plainText  加密明文
 @return 加密密文
 */
- (NSString *)getSM3String:(NSString *)plainText;

/**
 通过appletId获取小程序信息
 
 @param appletId 小程序id
 @return 小程序信息
 */
- (FATAppletInfo *)getAppletInfo:(NSString *)appletId;

#pragma mark - new apis

/// 启动小程序
/// @param request 启动的request
/// @param parentVC 父页面
/// @param completion 完成回调
/// @param closeCompletion 关闭小程序时的回调
- (void)startAppletWithRequest:(FATAppletRequest *)request
        InParentViewController:(UIViewController *)parentVC
                    completion:(void (^)(BOOL result, FATError *error))completion
               closeCompletion:(dispatch_block_t)closeCompletion;

/// 解密信息，并启动小程序
/// @param request 加密信息的request
/// @param parentVC 父页面
/// @param completion 完成回调
/// @param closeCompletion 关闭小程序时的回调
- (void)startAppletWithDecryptRequest:(FATAppletDecryptRequest *)request
               InParentViewController:(UIViewController *)parentVC
                           completion:(void (^)(BOOL result, FATError *error))completion
                      closeCompletion:(dispatch_block_t)closeCompletion;

/// 二维码信息启动小程序
/// @param request 请求对象
/// @param parentVC 父页面
/// @param requestBlock 校验二维码的请求完成的回调
/// @param completion 完成的回调
/// @param closeCompletion 关闭小程序时的回调
- (void)startAppletWithQrCodeRequest:(FATAppletQrCodeRequest *)request
              inParentViewController:(UIViewController *)parentVC
                        requestBlock:(void (^)(BOOL result, FATError *error))requestBlock
                          completion:(void (^)(BOOL result, FATError *error))completion
                     closeCompletion:(dispatch_block_t)closeCompletion;

/// 启动本地离线小程序
/// @param request 请求对象
/// @param parentVC 父页面
/// @param completion 完成回调
/// @param closeCompletion 关闭小程序时的回调
- (void)startLocalAppletWithRequest:(FATLocalAppletRequest *)request
             inParentViewController:(UIViewController *)parentVC
                         completion:(void (^)(BOOL result, FATError *error))completion
                    closeCompletion:(dispatch_block_t)closeCompletion;

#pragma mark - search applet
/// 搜索小程序
/// @param request 搜索的request
/// @param completion 搜索结果
- (void)searchAppletsWithRequest:(FATSearchAppletRequest *)request
                      completion:(void (^)(NSDictionary *result, FATError *aError))completion;

///  解析微信小程序二维码，得到凡泰小程序信息
/// @param qrCode  微信二维码
/// @param apiServer  解析服务器url
/// @param completion 结果回调
- (void)parseAppletInfoFromWXQrCode:(NSString *)qrCode apiServer:(NSString *)apiServer completion:(void (^)(FATAppletSimpleInfo *appInfo, FATError *aError))completion;

#pragma mark - deprecate api

/**
 打开服务器上的小程序，默认使用FATTranstionStyleUp样式
 如果以多服务器配置初始化SDK，则默认取第一个服务器配置

 @param appletId 小程序的appId, ❗️不能为空
 @param startParams 启动小程序时的参数，可为nil。目前支持的key只有path、query、scene。
 示例:
 @{
 @"path":@"/pages/index/index",
 @"query":@"key1=value1&key2=value2",
 @"scene" : @"1001"
 };
 @param parentVC 在哪个页面的基础上弹出小程序，❗️不能为空
 @param completion 完成的回调，失败时会返回error信息
 */
- (void)startRemoteApplet:(NSString *)appletId
               startParams:(NSDictionary *)startParams
    InParentViewController:(UIViewController *)parentVC
                completion:(void (^)(BOOL result, NSError *error))completion __attribute__((deprecated("该api(自2.23.5起)废弃，请使用startAppletWithRequest:InParentViewController:completion:closeCompletioncloseCompletion")));

/**
 打开服务器上的小程序，带启动动画参数
 如果以多服务器配置初始化SDK，则默认取第一个服务器配置
 
 @param appletId 小程序的appId, 不能为空
 @param startParams 启动小程序时的参数，可为nil。目前支持的key只有path、query、scene。
 示例:
 @{
 @"path":@"/pages/index/index",
 @"query":@"key1=value1&key2=value2",
 @"scene" : @"1001"
 };
 @param parentVC 在哪个页面的基础上弹出小程序，❗️不能为空
 @param transitionStyle 弹出动画方式
 @param completion 完成的回调，失败时会返回error信息
 */
- (void)startRemoteApplet:(NSString *)appletId
               startParams:(NSDictionary *)startParams
    InParentViewController:(UIViewController *)parentVC
           transitionStyle:(FATTranstionStyle)transitionStyle
                completion:(void (^)(BOOL result, NSError *error))completion __attribute__((deprecated("该api(自2.23.5起)废弃，请使用startAppletWithRequest:InParentViewController:completion:closeCompletioncloseCompletion")));

/**
 打开服务器上的小程序，带启动动画参数、关闭回调
 如果以多服务器配置初始化SDK，则默认取第一个服务器配置

 @param appletId 小程序的appId, 不能为空
 @param startParams 启动小程序时的参数，可为nil。目前支持的key只有path、query、scene。
 示例:
 @{
 @"path":@"/pages/index/index",
 @"query":@"key1=value1&key2=value2",
 @"scene" : @"1001"
 };
 @param parentVC 在哪个页面的基础上弹出小程序，❗️不能为空
 @param transitionStyle 弹出动画方式
 @param animated 是否展示动画
 @param completion 完成的回调，失败时会返回error信息
 @param closeCompletion 关闭小程序的回调
 */
- (void)startRemoteApplet:(NSString *)appletId
               startParams:(NSDictionary *)startParams
    InParentViewController:(UIViewController *)parentVC
           transitionStyle:(FATTranstionStyle)transitionStyle
                  animated:(BOOL)animated
                completion:(void (^)(BOOL result, NSError *error))completion
           closeCompletion:(dispatch_block_t)closeCompletion __attribute__((deprecated("该api(自2.23.5起)废弃，请使用startAppletWithRequest:InParentViewController:completion:closeCompletioncloseCompletion")));

/**
 打开服务器上的小程序，带提交序列、动画参数
 如果以多服务器配置初始化SDK，则默认取第一个服务器配置

 @param appletId 小程序的appId, 不能为空
 @param sequence 提交审核的序列
 @param startParams 启动小程序时的参数，可为nil。目前支持的key只有path、query、scene。
 示例:
 @{
 @"path":@"/pages/index/index",
 @"query":@"key1=value1&key2=value2",
 @"scene" : @"1001"
 };
 @param parentVC 在哪个页面的基础上弹出小程序，❗️不能为空
 @param animated 是否展示动画
 @param completion 完成的回调，失败时会返回error信息
 */
- (void)startRemoteApplet:(NSString *)appletId
                  sequence:(NSNumber *)sequence
               startParams:(NSDictionary *)startParams
    InParentViewController:(UIViewController *)parentVC
                  animated:(BOOL)animated
                completion:(void (^)(BOOL result, NSError *error))completion __attribute__((deprecated("该api(自2.23.5起)废弃，请使用startAppletWithRequest:InParentViewController:completion:closeCompletioncloseCompletion")));

/**
 打开服务器上的小程序，带提交序列、动画参数
 如果以多服务器配置初始化SDK，则默认取第一个服务器配置

 @param appletId 小程序的appId, 不能为空
 @param sequence 提交审核的序列
 @param startParams 启动小程序时的参数，可为nil。目前支持的key只有path、query、scene。
 示例:
 @{
 @"path":@"/pages/index/index",
 @"query":@"key1=value1&key2=value2",
 @"scene" : @"1001"
 };
 @param parentVC 在哪个页面的基础上弹出小程序，❗️不能为空
 @param transitionStyle 弹出动画方式
 @param animated 是否展示动画
 @param completion 完成的回调，失败时会返回error信息
 */
- (void)startRemoteApplet:(NSString *)appletId
                  sequence:(NSNumber *)sequence
               startParams:(NSDictionary *)startParams
    InParentViewController:(UIViewController *)parentVC
           transitionStyle:(FATTranstionStyle)transitionStyle
                  animated:(BOOL)animated
                completion:(void (^)(BOOL result, NSError *error))completion __attribute__((deprecated("该api(自2.23.5起)废弃，请使用startAppletWithRequest:InParentViewController:completion:closeCompletioncloseCompletion")));

/**
关闭当前的小程序
@param animated 是否显示动画
*/
- (void)closeCurrentApplet:(BOOL)animated __attribute__((deprecated("该api(自2.27.1起)废弃，请使用closeCurrentApplet:completion:")));

/**
关闭打开的指定小程序
@param animated 是否显示动画
*/
- (void)closeApplet:(NSString *)appletId animated:(BOOL)animated __attribute__((deprecated("该api(自2.27.1起)废弃，请使用closeApplet:animated:completion:")));

/**
关闭当前打开的所有小程序
*/
- (void)closeAllApplets __attribute__((deprecated("该api(自2.27.1起)废弃，请使用closeAllApplets:completion:")));

- (BOOL)registerExtensionApi:(NSString *)extApiName handle:(void (^)(id param, FATExtensionApiCallback callback))handler __attribute__((deprecated("该api(自2.36.7起)废弃，请使用 -registerExtensionApi:handler:")));

- (BOOL)fat_registerWebApi:(NSString *)webApiName handle:(void (^)(id param, FATExtensionApiCallback callback))handler __attribute__((deprecated("该api(自2.36.7起)废弃，请使用 -fat_registerWebApi:handler:")));

@end
