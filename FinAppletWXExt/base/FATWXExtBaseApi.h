//
//  FATWXExtBaseApi.h
//  FinAppletWXExt
//
//  Created by 王兆耀 on 2022/8/18.
//

#import <Foundation/Foundation.h>
#import <FinApplet/FinApplet.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FATApiHanderContextDelegate <NSObject>
//获取当前控制器
- (UIViewController *)getCurrentViewController;

//获取当前的页面id
- (NSString *)getCurrentPageId;

/// API发送回调事件给service层或者page层
/// eventName  事件名
/// eventType 0: service层订阅事件(callSubscribeHandlerWithEvent)  1:page层订阅事件  int类型方便以后有需要再添加事件类型
/// paramDic 回调事件的参数
///  extDic 扩展参数，预留字段，方便以后扩展
- (void)sendResultEvent:(NSInteger)eventType eventName:(NSString *)eventName eventParams:(NSDictionary *)param extParams:(NSDictionary *)extDic;

@optional

- (NSString *)insertChildView:(UIView *)childView viewId:(NSString *)viewId parentViewId:(NSString *)parentViewId  isFixed:(BOOL)isFixed;

- (UIView *)getChildViewById:(NSString *)viewId;

- (BOOL)removeChildView:(NSString *)viewId;

@end

@protocol FATApiProtocol <NSObject>

@required

@property (nonatomic, strong) FATAppletInfo *appletInfo;

/**
 api名称
 */
@property (nonatomic, readonly, copy) NSString *command;

/**
 原始参数
 */
@property (nonatomic, readonly, copy) NSDictionary<NSString *, id> *param;

@property (nonatomic, weak) id<FATApiHanderContextDelegate> context;


/**
 设置API, 子类重写

 @param success 成功回调
 @param failure 失败回调
 @param cancel 取消回调
 */
- (void)setupApiWithSuccess:(void (^)(NSDictionary<NSString *, id> *successResult))success
                    failure:(void (^)(NSDictionary *failResult))failure
                     cancel:(void (^)(NSDictionary *cancelResult))cancel;

@optional
/**
 同步api，子类重写
 */
- (NSString *)setupSyncApi;

@end

@interface FATWXExtBaseApi : NSObject<FATApiProtocol>
@property (nonatomic, copy, readonly) NSDictionary *param;

@property (nonatomic, strong) FATAppletInfo *appletInfo;

/**
 api名称
 */
@property (nonatomic, readonly, copy) NSString *command;

@property (nonatomic, weak) id<FATApiHanderContextDelegate> context;

@end

NS_ASSUME_NONNULL_END
