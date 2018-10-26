//
//  NSString+Additions.m
//  MobileProject
//
//  Created by wujunyang on 16/7/28.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "NSString+Additions.h"
#import "NSString+Base64.h"
#import "NSData+Base64.h"
@implementation NSString (Additions)

/** 计算字体size */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+ (float)heightForString:(NSString*)valueStr andFont:(UIFont*)font  andWidth:(float)width
{
    //    计算文本的大小
    CGSize sizeToFit = [valueStr boundingRectWithSize:CGSizeMake(width , MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return sizeToFit.height;
}

- (CGSize)sizeWithConstrainedToWidth:(float)width fromFont:(UIFont *)font1 lineSpace:(float)lineSpace{
    return [self sizeWithConstrainedToSize:CGSizeMake(width, CGFLOAT_MAX) fromFont:font1 lineSpace:lineSpace];
}

- (CGSize)sizeWithConstrainedToSize:(CGSize)size fromFont:(UIFont *)font1 lineSpace:(float)lineSpace{
    CGFloat minimumLineHeight = font1.pointSize,maximumLineHeight = minimumLineHeight, linespace = lineSpace;
    CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)font1.fontName,font1.pointSize,NULL);
    CTLineBreakMode lineBreakMode = kCTLineBreakByWordWrapping;
    //Apply paragraph settings
    CTTextAlignment alignment = kCTLeftTextAlignment;
    CTParagraphStyleRef style = CTParagraphStyleCreate((CTParagraphStyleSetting[6]){
        {kCTParagraphStyleSpecifierAlignment, sizeof(alignment), &alignment},
        {kCTParagraphStyleSpecifierMinimumLineHeight,sizeof(minimumLineHeight),&minimumLineHeight},
        {kCTParagraphStyleSpecifierMaximumLineHeight,sizeof(maximumLineHeight),&maximumLineHeight},
        {kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(linespace), &linespace},
        {kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(linespace), &linespace},
        {kCTParagraphStyleSpecifierLineBreakMode,sizeof(CTLineBreakMode),&lineBreakMode}
    },6);
    NSDictionary* attributes = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)font,(NSString*)kCTFontAttributeName,(__bridge id)style,(NSString*)kCTParagraphStyleAttributeName,nil];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self attributes:attributes];
    //    [self clearEmoji:string start:0 font:font1];
    CFAttributedStringRef attributedString = (__bridge CFAttributedStringRef)string;
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedString);
    CGSize result = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, [string length]), NULL, size, NULL);
    CFRelease(framesetter);
    CFRelease(font);
    CFRelease(style);
    string = nil;
    attributes = nil;
    return result;
}

- (void)drawInContext:(CGContextRef)context withPosition:(CGPoint)p andFont:(UIFont *)font andTextColor:(UIColor *)color andHeight:(float)height andWidth:(float)width{
    CGSize size = CGSizeMake(width, font.pointSize+10);
    CGContextSetTextMatrix(context,CGAffineTransformIdentity);
    CGContextTranslateCTM(context,0,height);
    CGContextScaleCTM(context,1.0,-1.0);
    
    //Determine default text color
    UIColor* textColor = color;
    //Set line height, font, color and break mode
    CTFontRef font1 = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize,NULL);
    //Apply paragraph settings
    CGFloat minimumLineHeight = font.pointSize,maximumLineHeight = minimumLineHeight+10, linespace = 5;
    CTLineBreakMode lineBreakMode = kCTLineBreakByTruncatingTail;
    CTTextAlignment alignment = kCTLeftTextAlignment;
    //Apply paragraph settings
    CTParagraphStyleRef style = CTParagraphStyleCreate((CTParagraphStyleSetting[6]){
        {kCTParagraphStyleSpecifierAlignment, sizeof(alignment), &alignment},
        {kCTParagraphStyleSpecifierMinimumLineHeight,sizeof(minimumLineHeight),&minimumLineHeight},
        {kCTParagraphStyleSpecifierMaximumLineHeight,sizeof(maximumLineHeight),&maximumLineHeight},
        {kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(linespace), &linespace},
        {kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(linespace), &linespace},
        {kCTParagraphStyleSpecifierLineBreakMode,sizeof(CTLineBreakMode),&lineBreakMode}
    },6);
    
    NSDictionary* attributes = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)font1,(NSString*)kCTFontAttributeName,
                                textColor.CGColor,kCTForegroundColorAttributeName,
                                style,kCTParagraphStyleAttributeName,
                                nil];
    //Create path to work with a frame with applied margins
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path,NULL,CGRectMake(p.x, height-p.y-size.height,(size.width),(size.height)));
    
    //Create attributed string, with applied syntax highlighting
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self attributes:attributes];
    CFAttributedStringRef attributedString = (__bridge CFAttributedStringRef)attributedStr;
    
    //Draw the frame
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedString);
    CTFrameRef ctframe = CTFramesetterCreateFrame(framesetter, CFRangeMake(0,CFAttributedStringGetLength(attributedString)),path,NULL);
    CTFrameDraw(ctframe,context);
    CGPathRelease(path);
    CFRelease(font1);
    CFRelease(framesetter);
    CFRelease(ctframe);
    [[attributedStr mutableString] setString:@""];
    CGContextSetTextMatrix(context,CGAffineTransformIdentity);
    CGContextTranslateCTM(context,0, height);
    CGContextScaleCTM(context,1.0,-1.0);
}

- (void)drawInContext:(CGContextRef)context withPosition:(CGPoint)p andFont:(UIFont *)font andTextColor:(UIColor *)color andHeight:(float)height{
    [self drawInContext:context withPosition:p andFont:font andTextColor:color andHeight:height andWidth:CGFLOAT_MAX];
}

/** 过滤 : & , */
+ (NSString *)filterSymbol:(NSString *)filterStr{
    NSString *resultStr = [filterStr stringByReplacingOccurrencesOfString:@"," withString:@""];
    resultStr = [resultStr stringByReplacingOccurrencesOfString:@":" withString:@""];
    resultStr = [resultStr stringByReplacingOccurrencesOfString:@"&" withString:@""];
    return resultStr;
}

/**
 *  返回重复字符的location
 *
 *  @param text     初始化的字符串
 *  @param findText 查找的字符
 *
 *  @return 返回重复字符的location
 */
+ (NSMutableArray *)getRangeStrFrom:(NSString *)text findText:(NSString *)findText
{
    NSMutableArray *arrayRanges = [NSMutableArray arrayWithCapacity:20];
    if (findText == nil && [findText isEqualToString:@""]) {
        return nil;
    }
    NSRange rang = [text rangeOfString:findText];
    if (rang.location != NSNotFound && rang.length != 0) {
        [arrayRanges addObject:[NSNumber numberWithInteger:rang.location]];
        NSRange rang1 = {0,0};
        NSInteger location = 0;
        NSInteger length = 0;
        for (int i = 0;; i++)
        {
            if (0 == i) {
                location = rang.location + rang.length;
                length = text.length - rang.location - rang.length;
                rang1 = NSMakeRange(location, length);
            }else
            {
                location = rang1.location + rang1.length;
                length = text.length - rang1.location - rang1.length;
                rang1 = NSMakeRange(location, length);
            }
            rang1 = [text rangeOfString:findText options:NSCaseInsensitiveSearch range:rang1];
            if (rang1.location == NSNotFound && rang1.length == 0) {
                break;
            }else
                [arrayRanges addObject:[NSNumber numberWithInteger:rang1.location]];
        }
        return arrayRanges;
    }
    return nil;
}
/** JSON 解析 金额精度缺失问题*/
+(NSString *)decimalNumberWithAmountStr:(double)amount{
    NSString *doubleString        = [NSString stringWithFormat:@"%f", amount];
    NSDecimalNumber *decNumber    = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}
//当不管url中的中文是否已经utf-8转码了，都可以解决将中文字符转为utf-8的问题，且不是二次转码
- (NSString *)encodingStringUsingURLEscape
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)self,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",NULL,                                                 kCFStringEncodingUTF8));
    
    return encodedString;
    // 此方法有错
    //    CFStringRef originStringRef = (__bridge_retained CFStringRef)self;
    //    CFStringRef escapedStringRef = CFURLCreateStringByAddingPercentEscapes(NULL,
    //                                                                           originStringRef,
    //                                                                           NULL,
    //                                                                           (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
    //                                                                           kCFStringEncodingUTF8);
    //    NSString *escapedString = (__bridge_transfer NSString *)escapedStringRef;
    //    CFRelease(originStringRef);
    //    return escapedString;
}
#pragma mark - 清楚多余的零
+ (NSString *)moneyDeleteMoreZeroWithAmountStr:(double)amount{
    
    NSString * amountStr = [NSString decimalNumberWithAmountStr:amount];
    NSArray * arrComp =  [amountStr componentsSeparatedByString:@"."];
    NSString * twoStr = @"";
    if (arrComp.count==2) {
        NSMutableString * lastStr = [NSMutableString stringWithFormat:@"%@", arrComp.lastObject];
        for (NSInteger i = [lastStr length]-1; i>=0; i--) {
            NSString * subStr = [lastStr substringFromIndex:i];
            if ([subStr isEqualToString:@"0"]) {
                [lastStr deleteCharactersInRange:NSMakeRange(i, 1)];
            }else{
                break;
            }
        }
        if ([lastStr length]>0) {
            twoStr = [NSString stringWithFormat:@".%@",lastStr];
        }
    }
    return [arrComp.firstObject stringByAppendingString:twoStr];
}


/** 在显示的字符串Str中设置colorStr的字体颜色 */
+ (NSMutableAttributedString *)changeStringFromStr:(NSString *)str colorStr:(NSString *)colorStr withColor:(UIColor *)color{
    
    if (!str || !colorStr) {
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:@""];
        return attStr;
    }
    
    if ([str rangeOfString:colorStr].location == NSNotFound) {
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:@""];
        return attStr;
    }
    
    NSRange range = [str rangeOfString:colorStr];
    if (range.length > 0) {
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attStr addAttribute:NSForegroundColorAttributeName value:color range:range];
        return attStr;
    } else {
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:@""];
        return attStr;
    }
}

/** 在显示的字符串Str数组中设置colorStr的字体颜色 */
+ (NSMutableAttributedString *)changeStringFromStr:(NSString *)str colorStrArray:(NSArray *)strArray withColor:(UIColor *)color{
    if (kStringIsEmpty(str) || kArrayIsEmpty(strArray)) {
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:@""];
        return attStr;
    }
    
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:@""];
    for (int i = 0; i < strArray.count; i ++) {
        if (!kStringIsEmpty(strArray[i])) {
            NSString *strString = strArray[i];
            if ([strString isKindOfClass:[NSString class]]) {
                NSRange range = [str rangeOfString:strArray[i]];
                if (range.length > 0) {
                    [attStr addAttribute:NSForegroundColorAttributeName value:color range:range];
                }
            }
        }
    }
    return attStr;
}


/** 设置指定字符字体大小 */
+ (NSMutableAttributedString *)changeStringWithStr:(NSString *)originStr fontStr:(NSString *)fontStr withFont:(UIFont *)font{
    if (!originStr || !fontStr) {
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:@""];
        return attStr;
    }
    
    if ([originStr rangeOfString:fontStr].location ==NSNotFound) {
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:@""];
        return attStr;
    }
    
    NSRange range = [originStr rangeOfString:fontStr];
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:originStr];
//    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
    if (font) {
        [attStr addAttribute:NSFontAttributeName value:font range:range];
    } else {
        [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:range];
    }
    return attStr;

}

#pragma mark -- 时间
#pragma mark - 消息通知 时间显示
+(NSString *)timeNotMsgTimeString:(NSTimeInterval)time
{
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    NSDate *date = [dateFormatter dateFromString:dateSMS];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateSMS = [dateFormatter stringFromDate:date];
    
    
    NSDate *now = [NSDate date];
    NSString *dateNow = [dateFormatter stringFromDate:now];
    NSDate *yesTerDay = [NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]-24*60*60];
    //前天
    NSDate *dayBeforeDay = [NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]-24*60*60*2];
    NSString *dateyesTerDay = [dateFormatter stringFromDate:yesTerDay];
    NSString *dayesTerDay = [dateFormatter stringFromDate:dayBeforeDay];
    
    if ([dateSMS isEqualToString:dateNow])
    {
//        今天
        NSTimeInterval  timeInterval = [date timeIntervalSinceNow];
        timeInterval = -timeInterval;
        if (timeInterval < 1) {
            dateSMS = @"刚刚";
            
        }
        else if (1<=timeInterval&& timeInterval< 60) {
            dateSMS = [NSString stringWithFormat:@"%ld秒前",(long)timeInterval];
        }
        else if((timeInterval/60) < 60){
            dateSMS = [NSString stringWithFormat:@"%ld分钟前",(long)timeInterval/60];
        }
        else {
            dateSMS = [NSString stringWithFormat:@"%ld小时前",(long)timeInterval/3600];
        }
        
        //        [dateFormatter setDateFormat:@"HH:mm"];
        //        dateSMS = [dateFormatter stringFromDate:date];
    }
    else if([dateSMS isEqualToString:dateyesTerDay])
    {
        [dateFormatter setDateFormat:@"HH:mm"];
        NSString * hmStr = [dateFormatter stringFromDate:date];
        dateSMS = [NSString stringWithFormat:@"昨天 %@",hmStr];
    }else if([dateSMS isEqualToString:dayesTerDay]){
        [dateFormatter setDateFormat:@"HH:mm"];
        NSString * hmStr = [dateFormatter stringFromDate:date];
        dateSMS = [NSString stringWithFormat:@"前天 %@",hmStr];
    }else
    {
        [dateFormatter setDateFormat:@"YYYY"];
        NSString *dateSMS1 = [dateFormatter stringFromDate:date];
        NSDate *now1 = [NSDate date];
        NSString *dateNow1 = [dateFormatter stringFromDate:now1];
        if ([dateSMS1 isEqualToString:dateNow1])
        {
            [dateFormatter setDateFormat:@"MM/dd HH:mm"];
            dateSMS = [dateFormatter stringFromDate:date];
            
        }else{
            [dateFormatter setDateFormat:@"YYYY/MM/dd HH:mm"];
            dateSMS = [dateFormatter stringFromDate:date];
        }
        
    }
    return dateSMS;
}
/**
 现在的 消息显示规则 V2.0.1

 @param time  服务器时间
 @return 时间格式
 */
+(NSString *)timeNowNotMsgTimeString:(NSTimeInterval)time
{
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    NSDate *date = [dateFormatter dateFromString:dateSMS];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateSMS = [dateFormatter stringFromDate:date];
    
    
    NSDate *now = [NSDate date];
    NSString *dateNow = [dateFormatter stringFromDate:now];
    NSDate *yesTerDay = [NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]-24*60*60];
    NSString *dateyesTerDay = [dateFormatter stringFromDate:yesTerDay];
    
    if ([dateSMS isEqualToString:dateNow])
    {
        //        今天
        [dateFormatter setDateFormat:@"HH:mm"];
        NSString * hmStr = [dateFormatter stringFromDate:date];
        dateSMS = [NSString stringWithFormat:@"今天 %@",hmStr];
    }
    else if([dateSMS isEqualToString:dateyesTerDay])
    {
//        昨天
        [dateFormatter setDateFormat:@"HH:mm"];
        NSString * hmStr = [dateFormatter stringFromDate:date];
        dateSMS = [NSString stringWithFormat:@"昨天 %@",hmStr];
    }else
    {
//     昨天之前
        [dateFormatter setDateFormat:@"YYYY/MM/dd"];
        dateSMS = [dateFormatter stringFromDate:date];
    }
    return dateSMS;
}
/** 服务器返回时间戳  返回格式 yyyy-mm-dd*/
+(NSString *)formatStrTimer:(NSString *)timerStr{
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:([timerStr longLongValue])/1000];
    return [NSString formatTimer:date];
}
/**
 *  返回 yyyy - MM-dd
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */
+(NSString *)formatTimer:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    NSDate *date = [dateFormatter dateFromString:dateSMS];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateSMS = [dateFormatter stringFromDate:date];
    return dateSMS;
}


//  将剩余支付秒数转化成 时:分:秒 这种格式字符串
+ (NSString *)translationSecondsToColonString:(long long)leftSeconds{
    NSString *leftString = [NSString string];
    if (leftSeconds > 0) {
        long hours = leftSeconds / 3600;
        NSInteger hoursOver = leftSeconds % 3600;
        NSInteger min = hoursOver / 60;
        NSInteger seconds = leftSeconds % 60;
        
        NSString *hoursStr = [NSString string];
        if (hours < 10) {
            hoursStr = [NSString stringWithFormat:@"0%ld", hours];
        } else {
            hoursStr = [NSString stringWithFormat:@"%ld", hours];
        }
        
        NSString *minuteStr = [NSString string];
        if (min < 10) {
            minuteStr = [NSString stringWithFormat:@"0%ld", min];
        } else {
            minuteStr = [NSString stringWithFormat:@"%ld", min];
        }
        
        NSString *secondStr = [NSString string];
        if (seconds < 10) {
            secondStr = [NSString stringWithFormat:@"0%ld", seconds];
        } else {
            secondStr = [NSString stringWithFormat:@"%ld", seconds];
        }
        
        if (hours > 0) {
            leftString =  [NSString stringWithFormat:@"%@:%@:%@", hoursStr, minuteStr, secondStr];
        } else {
            leftString =  [NSString stringWithFormat:@"%@:%@", minuteStr, secondStr];
        }
    }
    return leftString;
}
#pragma - 将saveBase64编码中的"-"，"_"字符串转换成"+"，"/"，字符串长度余4倍的位补"="
+(NSData*)safeUrlBase64Decode:(NSString*)safeUrlbase64Str
{
    // '-' -> '+'
    // '_' -> '/'
    // 不足4倍长度，补'='
    NSMutableString * base64Str = [[NSMutableString alloc]initWithString:safeUrlbase64Str];
    base64Str = (NSMutableString * )[base64Str stringByReplacingOccurrencesOfString:@"-" withString:@"+"];
    base64Str = (NSMutableString * )[base64Str stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    NSInteger mod4 = base64Str.length % 4;
    if(mod4 > 0)
        [base64Str appendString:[@"====" substringToIndex:(4-mod4)]];
    NSLog(@"Base64原文：%@", base64Str);
  return  [NSData dataWithBase64EncodedString:base64Str];
//    return [GTMBase64 decodeData:[base64Str dataUsingEncoding:NSUTF8StringEncoding]];
    
}

#pragma - 因为Base64编码中包含有+,/,=这些不安全的URL字符串，所以要进行换字符
+(NSString*)safeUrlBase64Encode:(NSData*)data
{
    // '+' -> '-'
    // '/' -> '_'
    // '=' -> ''
//    NSString * base64Str = [GTMBase64 stringByEncodingData:data];
    NSString * base64Str = [data base64EncodedString];

    NSMutableString * safeBase64Str = [[NSMutableString alloc]initWithString:base64Str];
    safeBase64Str = (NSMutableString * )[safeBase64Str stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    safeBase64Str = (NSMutableString * )[safeBase64Str stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    safeBase64Str = (NSMutableString * )[safeBase64Str stringByReplacingOccurrencesOfString:@"=" withString:@""];
    NSLog(@"safeBase64编码：%@", safeBase64Str);
    return safeBase64Str;
}

@end
