//
//  PrefixHeader_CommonInfo.h
//  ComponentizedFramework
//
//  Created by Paul on 2018/8/23.
//  Copyright © 2018年 Paul. All rights reserved.
//

/**
 * 常用应用信息宏定义
 **/

#ifndef PrefixHeader_CommonInfo_h
#define PrefixHeader_CommonInfo_h

#define AppName                                           [[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"]
#define AppVersion                                        [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define AppBundleIdentifier                               [NSBundle mainBundle].bundleIdentifier
#define AppIconImage                                      [UIImage imageNamed:[[[[NSBundle mainBundle] infoDictionary] valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject]]
#define StateBarHeight                                    [[UIApplication sharedApplication] statusBarFrame].size.height
#define NavBarHeight                                      [UINavigationController new].navigationBar.height
#define ToolbarHeight                                     [UITabBarController new].tabBar.frame.size.height
#define ScreenHeight                                      [UIScreen mainScreen].bounds.size.height
#define ScreenWidth                                       [UIScreen mainScreen].bounds.size.width

#endif /* PrefixHeader_CommonInfo_h */
