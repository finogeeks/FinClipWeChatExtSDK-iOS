# FinClipWeChatExtSDK-iOS

<p align="center">
    <a href="https://www.finclip.com?from=github">
    <img width="auto" src="https://www.finclip.com/mop/document/images/logo.png">
    </a>
</p>

<p align="center"> 
    <strong>FinClip Android DEMO</strong></br>
<p>
<p align="center"> 
        本项目提供在 Android 环境中接入凡泰定制的用于提供小程序部分微信SDK能力的示例
<p>

<p align="center"> 
	👉 <a href="https://www.finclip.com?from=github">https://www.finclip.com/</a> 👈
</p>

<div align="center">

<a href="#"><img src="https://img.shields.io/badge/%E4%B8%93%E5%B1%9E%E5%BC%80%E5%8F%91%E8%80%85-20000%2B-brightgreen"></a>
<a href="#"><img src="https://img.shields.io/badge/%E5%B7%B2%E4%B8%8A%E6%9E%B6%E5%B0%8F%E7%A8%8B%E5%BA%8F-6000%2B-blue"></a>
<a href="#"><img src="https://img.shields.io/badge/%E5%B7%B2%E9%9B%86%E6%88%90%E5%B0%8F%E7%A8%8B%E5%BA%8F%E5%BA%94%E7%94%A8-75%2B-yellow"></a>
<a href="#"><img src="https://img.shields.io/badge/%E5%AE%9E%E9%99%85%E8%A6%86%E7%9B%96%E7%94%A8%E6%88%B7-2500%20%E4%B8%87%2B-orange"></a>

<a href="https://www.zhihu.com/org/finchat"><img src="https://img.shields.io/badge/FinClip--lightgrey?logo=zhihu&style=social"></a>
<a href="https://www.finclip.com/blog/"><img src="https://img.shields.io/badge/FinClip%20Blog--lightgrey?logo=ghost&style=social"></a>



</div>

<p align="center">

<div align="center">

[官方网站](https://www.finclip.com/) | [示例小程序](https://www.finclip.com/#/market) | [开发文档](https://www.finclip.com/mop/document/) | [部署指南](https://www.finclip.com/mop/document/introduce/quickStart/cloud-server-deployment-guide.html) | [SDK 集成指南](https://www.finclip.com/mop/document/introduce/quickStart/intergration-guide.html) | [API 列表](https://www.finclip.com/mop/document/develop/api/overview.html) | [组件列表](https://www.finclip.com/mop/document/develop/component/overview.html) | [隐私承诺](https://www.finclip.com/mop/document/operate/safety.html)

</div>

-----
## 🤔 FinClip 是什么?

有没有**想过**，开发好的微信小程序能放在自己的 APP 里直接运行，只需要开发一次小程序，就能在不同的应用中打开它，是不是很不可思议？

有没有**试过**，在自己的 APP 中引入一个 SDK ，应用中不仅可以打开小程序，还能自定义小程序接口，修改小程序样式，是不是觉得更不可思议？

这就是 FinClip ，就是有这么多不可思议！

### 1.1 微信扩展SDK
微信SDK的快捷接入，提供调起微信通过微信小程序获得登录、用户信息、手机号、支付的能力。
快捷集成方式：
```objectivec
pod 'FinAppletWXExt'
```
::: tip 注意
在使用`FinAppletWXExt`时，需要按照 [微信接入指南-iOS 接入指南](https://open.weixin.qq.com/cgi-bin/showdocument?action=dir_list&t=resource/res_list&verify=1&id=1417694084&token=&lang=zh_CN) 进行配置，具体有如下内容：

1. 配置应用的`Universal Links`；
2. 打开`Associated Domains`开关，将`Universal Links`域名加到配置上；
3. 在工程的Target -> 【Info】 -> 【URL Types】，新增一个`URL Schemes`（key为weixin，value为wx+在微信申请的Appid）；
4. 在工程`info.plist`中增加应用访问白名单`LSApplicationQueriesSchemes`，对应的要填写的值为`wechat`，`weixin`，`weixinULAPI`。记得在苹果开发者中心`App ID Configuration`处勾选`Associated Domains`。
:::

进行初始化注册组件：
```objectivec
// 微信扩展SDL初始化
[FATWXExtComponent registerComponent:@"微信appid" universalLink:@"universalLink"];
```

并在`AppDelegate.m`中增加下面的代码。

```objectivec


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    /*  微信登录和分享    */
    if ([WXApi handleOpenURL:url delegate:[FATWXApiManager sharedManager]]) {
        return YES;
    }
    return YES;
}

// iOS 9.0 之前
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    /*  微信登录和分享    */
    // `WeChatHandleURLDelegate ` 为 `WXApiDelegate`代理文件
    if ([WXApi handleOpenURL:url delegate:[FATWXApiManager sharedManager]]) {
        return YES;
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    /*  微信登录和分享    */
    if ([WXApi handleOpenURL:url delegate:[FATWXApiManager sharedManager]]) {
        return YES;
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
  return [WXApi handleOpenUniversalLink:userActivity delegate:[FATWXApiManager sharedManager]];
}
```
::: tip 注意
使用微信扩展SDK必须保证核心SDK版本在`2.37.13`或以上。
:::

::: tip 注意
由于FinAppletWXExt需要覆盖buttonOpenTypeDelegate（2.37.13前的版本为FATAppletDelegate）中的open-type相关的方法，具体为chooseAvatar、contact、feedback、getPhoneNumber、launchApp、shareAppMessage六个方法。
因此若您实现了buttonOpenTypeDelegate并实现了以上六个方法，FinAppletWXExt将会接管getPhoneNumber，剩余的五个方法请按以下方式迁移，若您未实现buttonOpenTypeDelegate或没有用到以上六个方法，可以忽略此处,若是既需要集成FinAppletWXExt又需要实现open-type相关的方法，则参考下边的说明。
1.在核心SDK和微信扩展SDK初始化成功后，设置您的代理方法实现类
```
[FATDelegateClientHelper sharedHelper].buttonOpenTypeDelegate = [FINWXButtonDelegate sharedHelper];
```
2.实现buttonOpenTypeDelegate的代理方法
```
- (BOOL)forwardAppletWithInfo:(NSDictionary *)contentInfo completion:(void (^)(FATExtensionCode code, NSDictionary *result))completion {
    return YES;
}

- (BOOL)getUserInfoWithAppletInfo:(FATAppletInfo *)appletInfo bindGetUserInfo:(void (^)(NSDictionary *result))bindGetUserInfo {
    return YES;
}

- (BOOL)contactWithAppletInfo:(FATAppletInfo *)appletInfo sessionFrom:(NSString *)sessionFrom sendMessageTitle:(NSString *)sendMessageTitle sendMessagePath:(NSString *)sendMessagePath sendMessageImg:(NSString *)sendMessageImg showMessageCard:(BOOL)showMessageCard {
    return YES;
}

- (BOOL)getPhoneNumberWithAppletInfo:(FATAppletInfo *)appletInfo bindGetPhoneNumber:(void (^)(NSDictionary *result))bindGetPhoneNumber {
    NSLog(@"小程序信息:%@", appletInfo);
    return YES;
}

- (BOOL)launchAppWithAppletInfo:(FATAppletInfo *)appletInfo appParameter:(NSString *)appParameter bindError:(void (^)(NSDictionary *result))bindError bindLaunchApp:(void (^)(NSDictionary *result))bindLaunchApp {
    return YES;
}

- (BOOL)feedbackWithAppletInfo:(FATAppletInfo *)appletInfo {
    return YES;
}

- (BOOL)chooseAvatarWithAppletInfo:(FATAppletInfo *)appletInfo bindChooseAvatar:(void (^)(NSDictionary *result))bindChooseAvatar {
    return YES;
}
```
:::

