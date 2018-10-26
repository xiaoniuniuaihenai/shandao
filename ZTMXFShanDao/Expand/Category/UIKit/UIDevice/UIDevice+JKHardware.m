//
//  UIDevice+Hardware.m
//  TestTable
//
//  Created by Inder Kumar Rathore on 19/01/13.
//  Copyright (c) 2013 Rathore. All rights reserved.
//  https://github.com/fahrulazmi/UIDeviceHardware/blob/master/UIDeviceHardware.m

#import "UIDevice+JKHardware.h"
#include <sys/types.h>
#include <sys/sysctl.h>

#import <sys/socket.h>
#import <sys/param.h>
#import <sys/mount.h>
#import <sys/stat.h>
#import <sys/utsname.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <mach/mach.h>
#import <mach/mach_host.h>
#import <mach/processor_info.h>

@implementation UIDevice (JKHardware)
+ (NSString *)jk_platform{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

+ (NSString *)jk_platformString{
    NSString *platform = [self jk_platform];
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone4(GSM)";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone4(CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone5(GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone5(CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone5s";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone5s";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone6Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone6";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone6s";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone6sPlus";
    if ([platform isEqualToString:@"iPhone8,4"])    return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone9,1"])    return @"iPhone7";
    if ([platform isEqualToString:@"iPhone9,2"])    return @"iPhone7Plus";
    if ([platform isEqualToString:@"iPhone9,3"])    return @"iPhone7";
    if ([platform isEqualToString:@"iPhone9,4"])    return @"iPhone7Plus";
    
    if ([platform isEqualToString:@"iPhone10,1"])   return @"iPhone8";
    if ([platform isEqualToString:@"iPhone10,4"])   return @"iPhone8";
    if ([platform isEqualToString:@"iPhone10,2"])   return @"iPhone8Plus";
    if ([platform isEqualToString:@"iPhone10,5"])   return @"iPhone8Plus";
    if ([platform isEqualToString:@"iPhone10,3"])   return @"iPhoneX";
    if ([platform isEqualToString:@"iPhone10,6"])   return @"iPhoneX";
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPodTouch1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPodTouch2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPodTouch3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPodTouch4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPodTouch5G";
    if ([platform isEqualToString:@"iPod7,1"])      return @"iPodTouch6G";
    
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad2(WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad2(GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad2(CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad2(WiFi)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPadMini(WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPadMini(GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPadMini(CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad3(WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad3(CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad3(GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad4(WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad4(GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad4(CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPadAir(WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPadAir(GSM)";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPadAir(CDMA)";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPadMiniRetina (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPadMiniRetina (Cellular)";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPadMini3(WiFi)";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPadMini3(Cellular)";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPadMini3(Cellular)";
    if ([platform isEqualToString:@"iPad5,1"])      return @"iPadMini4(WiFi)";
    if ([platform isEqualToString:@"iPad5,2"])      return @"iPadMini4(Cellular)";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPadAir2(WiFi)";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPadAir2(Cellular)";
    if ([platform isEqualToString:@"iPad6,3"])      return @"iPadPro9.7-inch(WiFi)";
    if ([platform isEqualToString:@"iPad6,4"])      return @"iPadPro9.7-inch(Cellular)";
    if ([platform isEqualToString:@"iPad6,7"])      return @"iPadPro12.9-inch(WiFi)";
    if ([platform isEqualToString:@"iPad6,8"])      return @"iPadPro12.9-inch(Cellular)";
    
    if ([platform isEqualToString:@"i386"])         return [UIDevice currentDevice].model;
    if ([platform isEqualToString:@"x86_64"])       return [UIDevice currentDevice].model;
    
    return platform;
}


+ (NSString *)jk_macAddress {
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if(sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. Rrror!\n");
        return NULL;
    }
    
    if(sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

+ (NSString *)jk_systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}
+ (BOOL)jk_hasCamera
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
#pragma mark - sysctl utils

+ (NSUInteger)jk_getSysInfo:(uint)typeSpecifier
{
    size_t size = sizeof(int);
    int result;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &result, &size, NULL, 0);
    return (NSUInteger)result;
}

#pragma mark - memory information
+ (NSUInteger)jk_cpuFrequency {
    return [self jk_getSysInfo:HW_CPU_FREQ];
}

+ (NSUInteger)jk_busFrequency {
    return [self jk_getSysInfo:HW_BUS_FREQ];
}

+ (NSUInteger)jk_ramSize {
    return [self jk_getSysInfo:HW_MEMSIZE];
}

+ (NSUInteger)jk_cpuNumber {
    return [self jk_getSysInfo:HW_NCPU];
}


+ (NSUInteger)jk_totalMemoryBytes
{
    return [self jk_getSysInfo:HW_PHYSMEM];
}

+ (NSUInteger)jk_freeMemoryBytes
{
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t pagesize;
    vm_statistics_data_t vm_stat;
    
    host_page_size(host_port, &pagesize);
    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) {
        return 0;
    }
    unsigned long mem_free = vm_stat.free_count * pagesize;
    return mem_free;
}

#pragma mark - disk information

+ (long long)jk_freeDiskSpaceBytes
{
    struct statfs buf;
    long long freespace;
    freespace = 0;
    if ( statfs("/private/var", &buf) >= 0 ) {
        freespace = (long long)buf.f_bsize * buf.f_bfree;
    }
    return freespace;
}

+ (long long)jk_totalDiskSpaceBytes
{
    struct statfs buf;
    long long totalspace;
    totalspace = 0;
    if ( statfs("/private/var", &buf) >= 0 ) {
        totalspace = (long long)buf.f_bsize * buf.f_blocks;
    }
    return totalspace;
}
@end
