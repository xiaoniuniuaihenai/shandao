//
//  NSString+Additions.h
//  MobileProject 用法可参照https://github.com/johnil/VVeboTableViewDemo
//
//  Created by wujunyang on 16/7/28.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@interface NSString (Additions)

/** 计算字体size */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
+ (float)heightForString:(NSString*)valueStr andFont:(UIFont*)font  andWidth:(float)width;


//计算大小带间距
- (CGSize)sizeWithConstrainedToWidth:(float)width fromFont:(UIFont *)font1 lineSpace:(float)lineSpace;
- (CGSize)sizeWithConstrainedToSize:(CGSize)size fromFont:(UIFont *)font1 lineSpace:(float)lineSpace;

//绘画文字
- (void)drawInContext:(CGContextRef)context withPosition:(CGPoint)p andFont:(UIFont *)font andTextColor:(UIColor *)color andHeight:(float)height andWidth:(float)width;

- (void)drawInContext:(CGContextRef)context withPosition:(CGPoint)p andFont:(UIFont *)font andTextColor:(UIColor *)color andHeight:(float)height;
/** 过滤 : & , */
+ (NSString *)filterSymbol:(NSString *)filterStr;
/**
 *  返回重复字符的location
 *
 *  @param text     初始化的字符串
 *  @param findText 查找的字符
 *
 *  @return 返回重复字符的location
 */
+ (NSMutableArray *)getRangeStrFrom:(NSString *)text findText:(NSString *)findText;
/** JSON 解析 金额精度缺失问题*/
+(NSString *)decimalNumberWithAmountStr:(double)amount;
//当不管url中的中文是否已经utf-8转码了，都可以解决将中文字符转为utf-8的问题，且不是二次转码
- (NSString *)encodingStringUsingURLEscape;

/** 删除金额后面的0 */
+ (NSString *)moneyDeleteMoreZeroWithAmountStr:(double)amount;

/** 在显示的字符串Str中设置colorStr的字体颜色 */
+ (NSMutableAttributedString *)changeStringFromStr:(NSString *)str colorStr:(NSString *)colorStr withColor:(UIColor *)color;
/** 在显示的字符串Str数组中设置colorStr的字体颜色 */
+ (NSMutableAttributedString *)changeStringFromStr:(NSString *)str colorStrArray:(NSArray *)strArray withColor:(UIColor *)color;


/** 设置指定字符字体大小 */
+ (NSMutableAttributedString *)changeStringWithStr:(NSString *)originStr fontStr:(NSString *)fontStr withFont:(UIFont *)font;


#pragma mark -- 时间
#pragma mark - 消息通知 时间显示
+(NSString *)timeNotMsgTimeString:(NSTimeInterval)time;

// 消息显示规则 V2.0.1
+(NSString *)timeNowNotMsgTimeString:(NSTimeInterval)time;
/** 服务器返回时间戳  返回格式 yyyy-mm-dd*/
+(NSString *)formatStrTimer:(NSString *)timerStr;

//  将剩余支付秒数转化成 时:分:秒 这种格式字符串
+ (NSString *)translationSecondsToColonString:(long long)leftSeconds;
/** url safe base64编码 */
#pragma - 将saveBase64编码中的"-","_"字符串转换成"+","/",字符串长度余4倍的位补"=" 解码
+(NSData*)safeUrlBase64Decode:(NSString*)safeUrlbase64Str;
#pragma - 因为Base64编码中包含有+,/,=这些不安全的URL字符串,所以要进行换字符  加密
+(NSString*)safeUrlBase64Encode:(NSData*)data;


@end
