//
//  FATExt_requestPayment.h
//  FinAppletWXExt
//
//  Created by 王兆耀 on 2022/8/18.
//

#import "FATWXExtBaseApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface FATExt_requestPayment : FATWXExtBaseApi

@property (nonatomic, copy) NSString *appId;

@property (nonatomic, copy) NSString *nonceStr;

@property (nonatomic, copy) NSString *package;

@property (nonatomic, copy) NSString *paySign;

@property (nonatomic, copy) NSString *signType;

@property (nonatomic, copy) NSString *timeStamp;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *envVersion;

@end

NS_ASSUME_NONNULL_END
