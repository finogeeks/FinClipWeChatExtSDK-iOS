//
//  FINWXButtonDelegate.h
//  demo
//
//  Created by 王兆耀 on 2022/9/5.
//  Copyright © 2022 finogeeks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FinAppletWXExt/FinAppletWXExt.h>

NS_ASSUME_NONNULL_BEGIN

@interface FINWXButtonDelegate : NSObject<FATWXExtButtonOpenTypeDelegate>

+ (instancetype)sharedHelper;

@end

NS_ASSUME_NONNULL_END
