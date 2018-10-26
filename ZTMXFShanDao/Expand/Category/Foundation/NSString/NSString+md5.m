//
//  NSString+md5.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/20.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "NSString+md5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (md5)

#pragma mark - 计算当前字符串的 MD5值

- (NSString *) MD5 {
    // Create pointer to the string as UTF8
    const char* ptr = [self UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(ptr, (int)strlen(ptr), md5Buffer);
    
    // Convert MD5 value in the buffer to NSString of hex values
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",md5Buffer[i]];
    }
    
    return output;
}

- (NSString *)MD5Hash
{
    if(self.length == 0) {
        return nil;
    }
    
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15]];
}

//哈希256
- (NSString*) sha256
{
    //    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    //    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    NSData *data =[self dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    int lengthData = (int)data.length ;
    CC_SHA256(data.bytes, lengthData, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}


@end
