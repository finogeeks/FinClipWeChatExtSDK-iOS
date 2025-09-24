//
//  FATWXExtComponent.m
//  FinAppletWXExt
//
//  Created by 王兆耀 on 2022/8/18.
//

#import "FATWXExtComponent.h"
#import "FATWXExtBaseApi.h"
#import "FATDelegateClientHelper.h"
#import "FATWXExtPrivateContant.h"

#import <FinApplet/FinApplet.h>
#import <WXApi.h>

@implementation FATWXExtComponent

+ (NSString *)SDKVersion
{
    return FATWXExtVersionString;
}

+ (BOOL)registerComponent:(NSString *)appld universalLink:(NSString *)universalLink {
    
    //向微信注册
    BOOL isSuccess = [WXApi registerApp:appld universalLink:universalLink];
    
    [FATClient sharedClient].buttonOpenTypeDelegate = [FATDelegateClientHelper sharedHelper];
    
    return isSuccess;
}


@end
