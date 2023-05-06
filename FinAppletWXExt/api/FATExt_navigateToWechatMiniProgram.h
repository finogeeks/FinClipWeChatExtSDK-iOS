//
//  FATExt_navigateToWechatMiniProgram.h
//  FinAppletWXExt
//
//  Created by 王兆耀 on 2023/4/24.
//

#import "FATWXExtBaseApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface FATExt_navigateToWechatMiniProgram : FATWXExtBaseApi

@property (nonatomic,copy) NSString *originId;
@property (nonatomic,copy) NSString *path;
@property (nonatomic,copy) NSString *envVersion;

@end

NS_ASSUME_NONNULL_END
