//
//  RequestHelper.h
//  ComponentizedFramework
//
//  Created by Paul on 2018/8/24.
//  Copyright © 2018年 Paul. All rights reserved.
//

/**
 * 请求管理器，用于普通请求（GET， POST，UPLOAD，DOWNLOAD）
 **/

#import <Foundation/Foundation.h>

typedef void (^RHProcessBlock)(NSProgress *process);
typedef void (^RHCompletionBlock)(id responseObject);
typedef void (^RHFailBlock)(NSError *error);

@interface RequestHelper : NSObject

/**
 get请求，不带进度回调
 
 @param manager 请求管理器
 @param requestKey 关键字
 @param parameter 参数字典
 @param completionBlock 完成回调
 @param failureBlock 失败回调
 @return 请求管理类
 */
- (AFHTTPSessionManager *)requestWithManager:(AFHTTPSessionManager *)manager
                                         key:(NSString *)requestKey
                                   parameter:(NSDictionary *)parameter
                                  completion:(RHCompletionBlock)completionBlock
                                     failure:(RHFailBlock)failureBlock;
/*
 get请求，带进度回调
 
 @param manager 请求管理器
 @param requestKey 关键字
 @param parameter 参数字典
 @param processBlock 进度回调
 @param completionBlock 完成回调
 @param failureBlock 失败回调
 @return 请求管理类
 */
- (AFHTTPSessionManager *)requestWithManager:(AFHTTPSessionManager *)manager
                                         key:(NSString *)requestKey
                                   parameter:(NSDictionary *)parameter
                                     process:(RHProcessBlock)processBlock
                                  completion:(RHCompletionBlock)completionBlock
                                     failure:(RHFailBlock)failureBlock;


/**
 get请求，全路径，带进度回调

 @param manager 请求管理器
 @param url 请求地址
 @param parameter 参数字典
 @param processBlock 进度回调
 @param completionBlock 完成回调
 @param failureBlock 失败回调
 @return 请求管理类
 */
- (AFHTTPSessionManager *)requestWithManager:(AFHTTPSessionManager *)manager
                                         url:(NSString *)url
                                   parameter:(NSDictionary *)parameter
                                     process:(RHProcessBlock)processBlock
                                  completion:(RHCompletionBlock)completionBlock
                                     failure:(RHFailBlock)failureBlock;

/**
 post请求，不带进度回调
 
 @param manager 请求管理器
 @param requestKey 关键字
 @param parameter 参数字典
 @param completionBlock 完成回调
 @param failureBlock 失败回调
 @return 请求管理类
 */
- (AFHTTPSessionManager *)postWithManager:(AFHTTPSessionManager *)manager
                                      key:(NSString *)requestKey
                                parameter:(NSDictionary *)parameter
                               completion:(RHCompletionBlock)completionBlock
                                  failure:(RHFailBlock)failureBlock;

/**
 post请求，带进度回调
 
 @param manager 请求管理器
 @param requestKey 关键字
 @param parameter 参数字典
 @param processBlock 进度
 @param completionBlock 完成回调
 @param failureBlock 失败回调
 @return 请求管理类
 */
- (AFHTTPSessionManager *)postWithManager:(AFHTTPSessionManager *)manager
                                      key:(NSString *)requestKey
                                parameter:(NSDictionary *)parameter
                                  process:(RHProcessBlock)processBlock
                               completion:(RHCompletionBlock)completionBlock
                                  failure:(RHFailBlock)failureBlock;


/**
 post请求，全路径带进度回调
 
 @param manager 请求管理器
 @param url 请求地址
 @param parameter 参数字典
 @param processBlock 进度
 @param completionBlock 完成回调
 @param failureBlock 失败回调
 @return 请求管理类
 */
- (AFHTTPSessionManager *)postWithManager:(AFHTTPSessionManager *)manager
                                      url:(NSString *)url
                                parameter:(NSDictionary *)parameter
                                  process:(RHProcessBlock)processBlock
                               completion:(RHCompletionBlock)completionBlock
                                  failure:(RHFailBlock)failureBlock;

/**
 put请求，带进度回调
 
 @param manager 请求管理器
 @param requestKey 关键字
 @param parameter 参数字典
 @param completionBlock 完成回调
 @param failureBlock 失败回调
 @return 请求管理类
 */
- (AFHTTPSessionManager *)putWithManager:(AFHTTPSessionManager *)manager
                                     key:(NSString *)requestKey
                               parameter:(NSDictionary *)parameter
                              completion:(RHCompletionBlock)completionBlock
                                 failure:(RHFailBlock)failureBlock;


/**
 put请求，全路径带进度回调
 
 @param manager 请求管理器
 @param url 请求地址
 @param parameter 参数字典
 @param completionBlock 完成回调
 @param failureBlock 失败回调
 @return 请求管理类
 */
- (AFHTTPSessionManager *)putWithManager:(AFHTTPSessionManager *)manager
                                     url:(NSString *)url
                               parameter:(NSDictionary *)parameter
                              completion:(RHCompletionBlock)completionBlock
                                 failure:(RHFailBlock)failureBlock;

/**
 上传文件
 
 @param manager 请求管理器
 @param requestKey 关键字
 @param parameter 参数字典
 @param data 要上传的数据
 @param processBlock 上传进度
 @param completionBlock 完成回调
 @param failureBlock 失败回调
 @return 请求管理类
 */
-(AFHTTPSessionManager *)uploadFileWithManager:(AFHTTPSessionManager *)manager
                                           key:(NSString *)requestKey
                                     parameter:(NSDictionary *)parameter
                                          data:(NSData *)data
                                       process:(RHProcessBlock)processBlock
                                    completion:(RHCompletionBlock)completionBlock
                                       failure:(RHFailBlock)failureBlock;
/**
 上传文件，全路径
 
 @param manager 请求管理器
 @param url 请求地址
 @param parameter 参数字典
 @param data 要上传的数据
 @param processBlock 上传进度
 @param completionBlock 完成回调
 @param failureBlock 失败回调
 @return 请求管理类
 */
-(AFHTTPSessionManager *)uploadFileWithManager:(AFHTTPSessionManager *)manager
                                           url:(NSString *)url
                                     parameter:(NSDictionary *)parameter
                                          data:(NSData *)data
                                       process:(RHProcessBlock)processBlock
                                    completion:(RHCompletionBlock)completionBlock
                                       failure:(RHFailBlock)failureBlock;

/**
 下载文件
 
 @param requestKey 关键字
 @param parameter 参数字典
 @param processBlock 上传进度
 @param completionBlock 完成回调
 @param failureBlock 失败回调
 */
-(void)downloadFileWithRequestKey:(NSString *)requestKey
                        parameter:(NSDictionary *)parameter
                          process:(RHProcessBlock)processBlock
                       completion:(RHCompletionBlock)completionBlock
                          failure:(RHFailBlock)failureBlock;

/**
 下载文件, 全路径
 
 @param url 下载地址
 @param parameter 参数字典
 @param processBlock 上传进度
 @param completionBlock 完成回调
 @param failureBlock 失败回调
 */
-(void)downloadFileWithRequestUrl:(NSString *)url
                        parameter:(NSDictionary *)parameter
                          process:(RHProcessBlock)processBlock
                       completion:(RHCompletionBlock)completionBlock
                          failure:(RHFailBlock)failureBlock;
@end



