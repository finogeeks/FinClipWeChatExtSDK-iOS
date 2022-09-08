//
//  FATWXExtBaseApi.h
//  FinAppletWXExt
//
//  Created by 王兆耀 on 2022/8/18.
//

#import <Foundation/Foundation.h>
#import <FinApplet/FinApplet.h>

NS_ASSUME_NONNULL_BEGIN

@interface FATWXExtBaseApi : NSObject

@property (nonatomic, strong, readonly) NSDictionary *param;

+ (FATWXExtBaseApi *)apiWithCommand:(NSString *)command param:(NSDictionary *)param;

- (void)setupApiWithCallback:(FATExtensionApiCallback)callback;

@end

NS_ASSUME_NONNULL_END
