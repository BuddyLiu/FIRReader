//
//  PrefixHeader_GenneralTool.h
//  ComponentizedFramework
//
//  Created by Paul on 2018/8/23.
//  Copyright © 2018年 Paul. All rights reserved.
//

/**
 * 常用工具宏定义
 **/

#ifndef PrefixHeader_GenneralTool_h
#define PrefixHeader_GenneralTool_h

//单例
#undef    GD_SINGLETON
#define GD_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef    DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}

//宏定义打印格式
#ifdef DEBUG
#define NSLog(...) DLog(@"\n%s方法，\n第%d行,打印内容：\n%@\n打印结束\n", __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)
#endif

//解决日志打印不全问题
#ifdef DEBUG
#define DLog( s, ... ) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(s), ##__VA_ARGS__] UTF8String] );
#else
#define DLog( s, ... )
#endif

#define APPDELEGATE                                       ((AppDelegate *)[UIApplication sharedApplication].delegate) //AppDelegate
#define USERDEFAULTS                                      [NSUserDefaults standardUserDefaults] //系统单例
#define MainStoryBoard(id)                                ([[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:[NSString stringWithFormat:@"%@", id]]) //从Main.storyboard中获取控制器，id为"Storyboard Id"
#define kKeyWindow                                        [UIApplication sharedApplication].keyWindow
#define APPDELEGATE                                       ((AppDelegate *)[UIApplication sharedApplication].delegate)  //AppDelegate
#define USERDEFAULTS                                      [NSUserDefaults standardUserDefaults]                        //系统单例
#define SETUSERDEFAULTS(val, key)                         [USERDEFAULTS setObject:val forKey:key]
#define GETUSERDEFAULTS(key)                              [NSString stringWithFormat:@"%@", [USERDEFAULTS objectForKey:key]?[USERDEFAULTS objectForKey:key]:@""]
#define ItemColorRGB(r, g, b)                             [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0] //RGB颜色设置
#define ItemColorFromRGB(rgbValue)                        [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define iOS(__v)                                          ([UIDevice currentDevice].systemVersion.floatValue >= __v)
#define kDevice_Is_iPhone4                                ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone5                                ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6                                ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6Plus                            ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define kSysFontSize(fontSize)                            kDevice_Is_iPhone6Plus ? [UIFont systemFontOfSize:fontSize+1.5]:[UIFont systemFontOfSize:fontSize]
#define kSysBoldFontSize(fontSize)                        kDevice_Is_iPhone6Plus ? [UIFont boldSystemFontOfSize:fontSize+1.5]:[UIFont boldSystemFontOfSize:fontSize]
#define MakeSureNotNil(__obj)                             ((__obj)?(__obj):@"")
#define MakeSureNotNilWithDefaultObj(__obj, __defaultObj) ((__obj)?(__obj):(__defaultObj))
#define WEAKSELF                                          __weak typeof(self) weakSelf = self;
#define STRONGSELF                                        __strong typeof(weakSelf) strongSelf = weakSelf;
#define isIPhoneX                                         ScreenHeight==812
#define iPhoneXHeightSupplement                           (isIPhoneX?40:0)
#define ImageWithUrlString(urlStr)                        [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr?urlStr:@""]]]

#endif /* PrefixHeader_GenneralTool_h */
