//
//  NSDecimalNumber+Calculate.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/11/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDecimalNumber (Calculate)

#pragma mark - 取多少位小数, 四舍五入类型
/**
 @param scale   取几位小数
 @param originalString  需要转化的NSString类型值
 */
+ (NSString *)stringWithScale:(short)scale roundModel:(NSRoundingMode)roundModel originalString:(NSString *)originalString;

/**
 @param scale   取几位小数
 @param originalDouble  需要转化的double类型值
 */
+ (NSString *)stringWithScale:(short)scale roundModel:(NSRoundingMode)roundModel originalDouble:(double)originalDouble;

#pragma mark - 比较两个数
/**
 @param leftString   左边的NSString值
 @param rightString  右边的NSString值
 */
+ (NSComparisonResult)compareStringWithleftString:(NSString *)leftString
                                      rightString:(NSString *)rightString;

/**
 @param leftFloat   左边的float值
 @param rightFloat  右边的float值
 */
+ (NSComparisonResult)compareStringWithleftFloat:(CGFloat)leftFloat
                                      rightFloat:(CGFloat)rightFloat;



#pragma mark - 对另一个值的操作
/**
 @param opration    操作(+,-,*,/,^)
 @param oprationFloat   操作 加减乘除 的float值
 */
- (NSString *)calculateReturnStringWithOpration:(NSString *)opration
                                  oprationFloat:(CGFloat)oprationFloat;

/**
 @param opration    操作(+,-,*,/,^)
 @param oprationString   操作 加减乘除 的string值
 */
- (NSString *)calculateReturnStringWithOpration:(NSString *)opration
                                 oprationString:(NSString *)oprationString;
/**
 @param opration    操作(+,-,*,/,^)
 @param oprationNumber   操作 加减乘除 的NSDecimalNumber值
 */
- (NSString *)calculateReturnStringWithOpration:(NSString *)opration
                                 oprationNumber:(NSDecimalNumber *)oprationNumber;
/**
 @param opration    操作(+,-,*,/,^)
 @param oprationFloat   操作 加减乘除 的float值
 */
- (NSDecimalNumber *)calculateReturnDecimalNumberWithOpration:(NSString *)opration
                                                oprationFloat:(CGFloat)oprationFloat;
/**
 @param opration    操作(+,-,*,/,^)
 @param oprationString   操作 加减乘除 的string值
 */
- (NSDecimalNumber *)calculateReturnDecimalNumberWithOpration:(NSString *)opration
                                                oprationString:(NSString *)oprationString;
/**
 @param opration    操作(+,-,*,/,^)
 @param oprationNumber   操作 加减乘除 的NSDecimalNumber值
 */
- (NSDecimalNumber *)calculateReturnDecimalNumberWithOpration:(NSString *)opration
                                               oprationNumber:(NSDecimalNumber *)oprationNumber;





#pragma mark - 两个值相互的操作
/**
 @param opration    操作(+,-,*,/,^)
 @param leftFloat   左边的float值
 @param rightFloat  右边的float值
 */
+ (NSString *)calculateReturnStringWithOpration:(NSString *)opration
                                      leftFloat:(CGFloat)leftFloat
                                     rightFloat:(CGFloat)rightFloat;


/**
 @param opration    操作(+,-,*,/,^)
 @param leftString   左边的NSString值
 @param rightString  右边的NSString值
 */
+ (NSString *)calculateReturnStringWithOpration:(NSString *)opration
                                      leftString:(NSString *)leftString
                                     rightString:(NSString *)rightString;

/**
 @param opration    操作(+,-,*,/,^)
 @param leftFloat   左边的float值
 @param rightFloat  右边的float值
 */
+ (NSDecimalNumber *)calculateReturnDecimalNumberWithOpration:(NSString *)opration
                                                    leftFloat:(CGFloat)leftFloat
                                                   rightFloat:(CGFloat)rightFloat;
/**
 @param opration    操作(+,-,*,/,^)
 @param leftString   左边的string值
 @param rightString  右边的string值
 */
+ (NSDecimalNumber *)calculateReturnDecimalNumberWithOpration:(NSString *)opration
                                                    leftString:(NSString *)leftString
                                                   rightString:(NSString *)rightString;
/**
 @param opration    操作(+,-,*,/,^)
 @param leftNumber   左边的NSDecimalNumber值
 @param rightNumber  右边的NSDecimalNumber值
 */
+ (NSDecimalNumber *)calculateReturnDecimalNumberWithOpration:(NSString *)opration
                                                    leftNumber:(NSDecimalNumber *)leftNumber
                                                   rightNumber:(NSDecimalNumber *)rightNumber;




#pragma mark - float 类型转化
/** double 类型转化成字符串 */
+ (NSString *)stringWithFloatValue:(double)floatValue;

/** double 转化成NSDecimalNumber  如果是float 只有6位精度, 如果小数点后面比较多的话会有精度丢失*/
+ (NSDecimalNumber *)decimalNumberWithFloatValue:(double)floatValue;


@end
