//
//  XLUserInfo.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#ifndef XLUserInfo_h
#define XLUserInfo_h


#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o

#define StrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak

#define USER_Default_PlaceholderImage [UIImage imageNamed:@"banner"]
/**客服电话 */
#define K_CustomerServiceNum @"400-185-8811" // 400-161-8585
/**客服电话 */
#define K_BankCustomerServiceNum @"95516"


#define k_USER_DEFAULT(str) [USER_DEFAULT objectForKey:str]?[USER_DEFAULT objectForKey:str]:@""

#define k_Integer_USER_DEFAULT(str) [USER_DEFAULT integerForKey:str]

#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

/**消息开关 */
#define k_VoiceSwitch @"voiceSwitch"

///**登录令牌 */
//#define UserInfo_UserToken @"token"
///**用户ID*/
//#define UserInfo_ID @"memberId"
///**会员身份标识 */
//#define UserInfo_identity @"identity"
///**用户名称 */
//#define UserInfo_name @"name"
///**用户手机号 */
//#define UserInfo_telephone @"telephone"
///**是否登录状态 */
//#define k_isLogin @"isLogin"







#endif /* XLUserInfo_h */
