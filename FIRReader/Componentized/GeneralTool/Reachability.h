//
//  Reachability.h
//  IntegralWall
//
//  Created by Paul on 2018/9/11.
//  Copyright © 2018年 QingHu. All rights reserved.
//

/**
 * 检查网络是否可达
 **/

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>


typedef enum : NSInteger {
    NotReachable = 0,
    ReachableViaWiFi,
    ReachableViaWWAN
} NetworkStatus;


extern NSString *kReachabilityChangedNotification;


@interface Reachability : NSObject

//用于检查给定主机名的可达性。
+ (instancetype)reachabilityWithHostName:(NSString *)hostName;


//用来检查一个给定的IP地址的可达性。

+ (instancetype)reachabilityWithAddress:(const struct sockaddr_in *)hostAddress;


//检查默认路由是否可用。应使用不连接到特定主机的应用程序。

+ (instancetype)reachabilityForInternetConnection;

//检查本地WiFi连接是可用的。

+ (instancetype)reachabilityForLocalWiFi;

//开始监听当前运行循环上的可达性通知。

- (BOOL)startNotifier;
- (void)stopNotifier;

- (NetworkStatus)currentReachabilityStatus;


//广域网可能是可用的，但不会主动建立连接。无线网络可能需要连接VPN的需求。

- (BOOL)connectionRequired;

@end
