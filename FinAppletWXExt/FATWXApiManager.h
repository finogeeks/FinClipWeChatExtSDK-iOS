//
//  FATWXApiManager.h
//  FinAppletWXExt
//
//  Created by 王兆耀 on 2022/8/20.
//

#import <Foundation/Foundation.h>
#import <WXApi.h>

typedef void (^FATWXResponse)(WXLaunchMiniProgramResp *resp);

@interface FATWXApiManager : NSObject<WXApiDelegate>

+ (instancetype)sharedManager;

@property (nonatomic, copy) FATWXResponse wxResponse;

@end
