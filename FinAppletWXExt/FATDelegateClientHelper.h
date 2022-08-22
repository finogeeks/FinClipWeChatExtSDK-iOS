//
//  FATDelegateClientHelper.h
//  FinAppletWXExt
//
//  Created by 王兆耀 on 2022/8/21.
//

#import <Foundation/Foundation.h>
#import <FinApplet/FinApplet.h>

NS_ASSUME_NONNULL_BEGIN

@interface FATDelegateClientHelper : NSObject<FATAppletDelegate>

+ (instancetype)sharedHelper;

@end

NS_ASSUME_NONNULL_END
