//
//  RequestMannager.h
//  ComponentizedFramework
//
//  Created by Paul on 2018/8/24.
//  Copyright © 2018年 Paul. All rights reserved.
//

/**
 * 具体的请求管理器，如有新的接口需要对接，请在此类添加新的方法
 **/

#import <Foundation/Foundation.h>

#define RequestKey_login @"/1.0/accountV2/Login"
#define RequestKey_checkUpdate @"/1.0/contentsV2/CheckAppUpdate"

typedef void (^RMQueryProcessBlock)(NSProgress *process);
typedef void (^RMQueryCompletionBlock)(id responseObject);
typedef void (^RMQueryFailBlock)(NSError *error);

@interface RequestMannager : NSObject

GD_SINGLETON(RequestMannager);

/**
 获取应用列表

 @param completionBlock 完成回调
 @param failBlock 失败回调
 @return AFHTTPSessionManager
 */
-(AFHTTPSessionManager *)getAppListRequestWithCompletionBlock:(RMQueryCompletionBlock)completionBlock
                                                    failBlock:(RMQueryFailBlock)failBlock;

/**
 获取应用详情
 
 @param appId 应用id
 @param completionBlock 完成回调
 @param failBlock 失败回调
 @return AFHTTPSessionManager
 */
-(AFHTTPSessionManager *)getAppDetailRequestWithAppId:(NSString *)appId
                                      completionBlock:(RMQueryCompletionBlock)completionBlock
                                            failBlock:(RMQueryFailBlock)failBlock;

/**
 获取应用下载安装token
 
 @param appId 应用id
 @param completionBlock 完成回调
 @param failBlock 失败回调
 @return AFHTTPSessionManager
 */
-(AFHTTPSessionManager *)getAppInstallTokenRequestWithAppId:(NSString *)appId
                                            completionBlock:(RMQueryCompletionBlock)completionBlock
                                                  failBlock:(RMQueryFailBlock)failBlock;


/**
 修改应用信息

 @param appId 应用ID
 @param name 应用名称
 @param desc 应用描述
 @param shortStr 短连接
 @param completionBlock 完成回调
 @param failBlock 失败回调
 @return AFHTTPSessionManager
 */
-(AFHTTPSessionManager *)changeAppInfoRequestWithAppId:(NSString *)appId
                                                  name:(NSString *)name
                                                  desc:(NSString *)desc
                                              shortStr:(NSString *)shortStr
                                       completionBlock:(RMQueryCompletionBlock)completionBlock
                                             failBlock:(RMQueryFailBlock)failBlock;
@end
