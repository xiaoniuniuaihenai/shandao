//
//  NSDecimalNumber+Calculate.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/11/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "NSDecimalNumber+Calculate.h"

@implementation NSDecimalNumber (Calculate)
/**
 @param scale   取几位小数
 @param originalString  需要转化的值
 */
+ (NSString *)stringWithScale:(short)scale roundModel:(NSRoundingMode)roundModel originalString:(NSString *)originalString{
    if (kStringIsEmpty(originalString)) {
        originalString = @"0";
    }
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       decimalNumberHandlerWithRoundingMode:roundModel
                                       scale:scale
                                       raiseOnExactness:NO
                                       raiseOnOverflow:NO
                                       raiseOnUnderflow:NO
                                       raiseOnDivideByZero:YES];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:originalString];
    NSDecimalNumber *resultDecNumber = [decNumber decimalNumberByRoundingAccordingToBehavior:roundUp];
    return [resultDecNumber stringValue];
}

/**
 @param scale   取几位小数
 @param originalDouble  需要转化的double类型值
 */
+ (NSString *)stringWithScale:(short)scale roundModel:(NSRoundingMode)roundModel originalDouble:(double)originalDouble{
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       decimalNumberHandlerWithRoundingMode:roundModel
                                       scale:scale
                                       raiseOnExactness:NO
                                       raiseOnOverflow:NO
                                       raiseOnUnderflow:NO
                                       raiseOnDivideByZero:YES];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithFloatValue:originalDouble];
    NSDecimalNumber *resultDecNumber = [decNumber decimalNumberByRoundingAccordingToBehavior:roundUp];
    return [resultDecNumber stringValue];
}

#pragma mark - 比较两个数
/**
 @param leftString   左边的NSString值
 @param rightString  右边的NSString值
 */
+ (NSComparisonResult)compareStringWithleftString:(NSString *)leftString
                                      rightString:(NSString *)rightString{
    NSDecimalNumber *leftDecNumber = [NSDecimalNumber decimalNumberWithString:leftString];
    NSDecimalNumber *rightDecNumber = [NSDecimalNumber decimalNumberWithString:rightString];
    NSComparisonResult restult = [leftDecNumber compare:rightDecNumber];
    return restult;
}

/**
 @param leftFloat   左边的float值
 @param rightFloat  右边的float值
 */
+ (NSComparisonResult)compareStringWithleftFloat:(CGFloat)leftFloat
                                      rightFloat:(CGFloat)rightFloat{
    NSDecimalNumber *leftDecNumber = [NSDecimalNumber decimalNumberWithFloatValue:leftFloat];
    NSDecimalNumber *rightDecNumber = [NSDecimalNumber decimalNumberWithFloatValue:rightFloat];
    NSComparisonResult restult = [leftDecNumber compare:rightDecNumber];
    return restult;
}



#pragma mark - 对另一个值的操作
/**
 @param opration    操作(+,-,*,/,^)
 @param oprationFloat   操作 加减乘除 的float值
 */
- (NSString *)calculateReturnStringWithOpration:(NSString *)opration
                                  oprationFloat:(CGFloat)oprationFloat{
    NSDecimalNumber *decNumber = [self calculateReturnDecimalNumberWithOpration:opration oprationFloat:oprationFloat];
    return [decNumber stringValue];
}

/**
 @param opration    操作(+,-,*,/,^)
 @param oprationString   操作 加减乘除 的string值
 */
- (NSString *)calculateReturnStringWithOpration:(NSString *)opration
                                 oprationString:(NSString *)oprationString{
    if (kStringIsEmpty(oprationString)) {
        oprationString = @"0";
    }
    NSDecimalNumber *decNumber = [self calculateReturnDecimalNumberWithOpration:opration oprationString:oprationString];
    return [decNumber stringValue];
}

/**
 @param opration    操作(+,-,*,/,^)
 @param oprationNumber   操作 加减乘除 的NSDecimalNumber值
 */
- (NSString *)calculateReturnStringWithOpration:(NSString *)opration
                                 oprationNumber:(NSDecimalNumber *)oprationNumber{
    if (!oprationNumber) {
        oprationNumber = [NSDecimalNumber decimalNumberWithString:@"1"];
    }
    NSDecimalNumber *decNumber = [self calculateReturnDecimalNumberWithOpration:opration oprationNumber:oprationNumber];
    return [decNumber stringValue];
}

/**
 @param opration    操作(+,-,*,/,^)
 @param oprationFloat   操作 加减乘除 的float值
 */
- (NSDecimalNumber *)calculateReturnDecimalNumberWithOpration:(NSString *)opration
                                                oprationFloat:(CGFloat)oprationFloat
{
    NSDecimalNumber *oprationNumber = [NSDecimalNumber decimalNumberWithFloatValue:oprationFloat];
    return [NSDecimalNumber calculateReturnDecimalNumberWithOpration:opration leftNumber:self rightNumber:oprationNumber];
}

/**
 @param opration    操作(+,-,*,/,^)
 @param oprationString   操作 加减乘除 的string值
 */
- (NSDecimalNumber *)calculateReturnDecimalNumberWithOpration:(NSString *)opration
                                               oprationString:(NSString *)oprationString{
    if (kStringIsEmpty(oprationString)) {
        oprationString = @"0";
    }
    NSDecimalNumber *oprationNumber = [NSDecimalNumber decimalNumberWithString:oprationString];
    return [NSDecimalNumber calculateReturnDecimalNumberWithOpration:opration leftNumber:self rightNumber:oprationNumber];
}

/**
 @param opration    操作(+,-,*,/,^)
 @param oprationNumber   操作 加减乘除 的NSDecimalNumber值
 */
- (NSDecimalNumber *)calculateReturnDecimalNumberWithOpration:(NSString *)opration
                                               oprationNumber:(NSDecimalNumber *)oprationNumber{
    if (!oprationNumber) {
        oprationNumber = [NSDecimalNumber decimalNumberWithString:@"1"];
    }
    return [NSDecimalNumber calculateReturnDecimalNumberWithOpration:opration leftNumber:self rightNumber:oprationNumber];
}


#pragma mark - 两个值相互的操作
/**
 @param opration    操作(+,-,*,/,^)
 @param leftFloat   左边的float值
 @param rightFloat  右边的float值
 */
+ (NSString *)calculateReturnStringWithOpration:(NSString *)opration
                                      leftFloat:(CGFloat)leftFloat
                                     rightFloat:(CGFloat)rightFloat
{
    NSDecimalNumber *decNumber = [NSDecimalNumber calculateReturnDecimalNumberWithOpration:opration leftFloat:leftFloat rightFloat:rightFloat];
    return [decNumber stringValue];
}

/**
 @param opration    操作(+,-,*,/,^)
 @param leftString   左边的NSString值
 @param rightString  右边的NSString值
 */
+ (NSString *)calculateReturnStringWithOpration:(NSString *)opration
                                     leftString:(NSString *)leftString
                                    rightString:(NSString *)rightString{
    if (kStringIsEmpty(leftString)) {
        leftString = @"0";
    }
    if (kStringIsEmpty(rightString)) {
        rightString = @"0";
    }

    NSDecimalNumber *leftNumber  = [NSDecimalNumber decimalNumberWithString:leftString];
    NSDecimalNumber *rightNumber = [NSDecimalNumber decimalNumberWithString:rightString];
    NSDecimalNumber *decNumber = [NSDecimalNumber calculateReturnDecimalNumberWithOpration:opration leftNumber:leftNumber rightNumber:rightNumber];
    return [decNumber stringValue];
}

/**
 @param opration    操作(+,-,*,/,^)
 @param leftFloat   左边的float值
 @param rightFloat  右边的float值
 */
+ (NSDecimalNumber *)calculateReturnDecimalNumberWithOpration:(NSString *)opration
                                                    leftFloat:(CGFloat)leftFloat
                                                   rightFloat:(CGFloat)rightFloat;
{
    
    NSDecimalNumber *leftNumber  = [NSDecimalNumber decimalNumberWithFloatValue:leftFloat];
    NSDecimalNumber *rightNumber = [NSDecimalNumber decimalNumberWithFloatValue:rightFloat];
    return [NSDecimalNumber calculateReturnDecimalNumberWithOpration:opration leftNumber:leftNumber rightNumber:rightNumber];
}

/**
 @param opration    操作(+,-,*,/,^)
 @param leftString   左边的string值
 @param rightString  右边的string值
 */
+ (NSDecimalNumber *)calculateReturnDecimalNumberWithOpration:(NSString *)opration
                                                   leftString:(NSString *)leftString
                                                  rightString:(NSString *)rightString{
    if (kStringIsEmpty(leftString)) {
        leftString = @"0";
    }
    if (kStringIsEmpty(rightString)) {
        rightString = @"0";
    }
    NSDecimalNumber *leftNumber  = [NSDecimalNumber decimalNumberWithString:leftString];
    NSDecimalNumber *rightNumber = [NSDecimalNumber decimalNumberWithString:rightString];
    return [NSDecimalNumber calculateReturnDecimalNumberWithOpration:opration leftNumber:leftNumber rightNumber:rightNumber];
}

/**
 @param opration    操作(+,-,*,/,^)
 @param leftNumber   左边的NSDecimalNumber值
 @param rightNumber  右边的NSDecimalNumber值
 */
+ (NSDecimalNumber *)calculateReturnDecimalNumberWithOpration:(NSString *)opration
                                                   leftNumber:(NSDecimalNumber *)leftNumber
                                                  rightNumber:(NSDecimalNumber *)rightNumber{
    if (!leftNumber) {
        leftNumber = [NSDecimalNumber decimalNumberWithString:@"1"];
    }
    if (!rightNumber) {
        rightNumber = [NSDecimalNumber decimalNumberWithString:@"1"];
    }

    NSString *token;
    if ([@"+" isEqualToString:opration]) {
        token = [[leftNumber decimalNumberByAdding:rightNumber] stringValue];
        
    } else if ([@"-" isEqualToString:opration]) {
        token = [[leftNumber decimalNumberBySubtracting:rightNumber] stringValue];
        
    } else if ([@"*" isEqualToString:opration]) {
        token = [[leftNumber decimalNumberByMultiplyingBy:rightNumber] stringValue];
        
    } else if ([@"/" isEqualToString:opration]) {
        token = [[leftNumber decimalNumberByDividingBy:rightNumber] stringValue];
        
    } else if ([@"^" isEqualToString:opration]) {
        token = [[leftNumber decimalNumberByRaisingToPower:rightNumber.integerValue] stringValue];
    }
    return [NSDecimalNumber decimalNumberWithString:token];
}



#pragma mark - float 类型转化
/** double 类型转化成字符串 */
+ (NSString *)stringWithFloatValue:(double)floatValue{
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithFloatValue:floatValue];
    return [decNumber stringValue];
}

/** double 转化成NSDecimalNumber  如果是float 只有6位精度, 如果小数点后面比较多的话会有精度丢失*/
+ (NSDecimalNumber *)decimalNumberWithFloatValue:(double)floatValue{
    NSString *floatString = [NSString stringWithFormat:@"%.6f", floatValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:floatString];
    return decNumber;
}


@end
