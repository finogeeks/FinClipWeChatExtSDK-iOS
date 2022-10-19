//
//  FATDelegateClientHelper.h
//  FinAppletWXExt
//
//  Created by 王兆耀 on 2022/8/21.
//

#import <Foundation/Foundation.h>
#import <FinApplet/FinApplet.h>
#import "FATWXExtButtonOpenTypeDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface FATDelegateClientHelper : NSObject<FATAppletButtonOpenTypeDelegate>

+ (instancetype)sharedHelper;

/**
 button的open-type能力相关的代理事件
 */
@property (nonatomic, weak) id<FATWXExtButtonOpenTypeDelegate> buttonOpenTypeDelegate;

@end

NS_ASSUME_NONNULL_END
