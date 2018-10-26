//
//  LSBindCardSetPayPawApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface LSBindCardSetPayPawApi : BaseRequestSerivce

/**

 @param idNumber base64  加密过得身份证号
 @param payPaw 支付密码 md5
 */
-(instancetype)initWithIdNumber:(NSString*)idNumber andPaw:(NSString*)payPaw;
@end
