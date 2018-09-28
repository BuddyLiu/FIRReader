//
//  RequestHelper.m
//  ComponentizedFramework
//
//  Created by Paul on 2018/8/24.
//  Copyright © 2018年 Paul. All rights reserved.
//

#import "RequestHelper.h"
#import "RequestDownloader.h"

@implementation RequestHelper

/*
 * GET, WITHOUT PROCESS
 */
- (AFHTTPSessionManager *)requestWithManager:(AFHTTPSessionManager *)manager
                                         key:(NSString *)requestKey
                                   parameter:(NSDictionary *)parameter
                                  completion:(RHCompletionBlock)completionBlock
                                     failure:(RHFailBlock)failureBlock
{
    return [self requestWithManager:manager
                                key:requestKey
                          parameter:parameter
                            process:nil
                         completion:completionBlock
                            failure:failureBlock];
}

/*
 * GET, WITH PROCESS
 */
- (AFHTTPSessionManager *)requestWithManager:(AFHTTPSessionManager *)manager
                                         key:(NSString *)requestKey
                                   parameter:(NSDictionary *)parameter
                                     process:(RHProcessBlock)processBlock
                                  completion:(RHCompletionBlock)completionBlock
                                     failure:(RHFailBlock)failureBlock
{
    ASNetworkActivityTaskDidStart();
    NSString *url = [NSString stringWithFormat:@"%@%@", BaseUrl, requestKey];
    [self requestWithManager:manager url:url parameter:parameter process:processBlock completion:completionBlock failure:failureBlock];
    return manager;
}

/*
 * GET, FULL PATH, WITH PROCESS
 */
- (AFHTTPSessionManager *)requestWithManager:(AFHTTPSessionManager *)manager
                                         url:(NSString *)url
                                   parameter:(NSDictionary *)parameter
                                     process:(RHProcessBlock)processBlock
                                  completion:(RHCompletionBlock)completionBlock
                                     failure:(RHFailBlock)failureBlock
{
    ASNetworkActivityTaskDidStart();
    NSLog(@"__url:%@\n__parameter:%@\n", url, parameter);
    NSString *urlStr = [NSString stringWithFormat:@"%@", url?url:@""];
    [manager GET:urlStr parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        if(processBlock)
        {
            NSLog(@"GET进度:%.2f%@", ((downloadProgress.completedUnitCount*1.0)/(downloadProgress.totalUnitCount*1.0))*100, @"%");
            processBlock(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ASNetworkActivityTaskDidFinish();
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ASNetworkActivityTaskDidFinish();
        if (failureBlock)
        {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
            failureBlock(error);
        }
    }];
    return manager;
}

/*
 * POST, WITHOUT PROCESS
 */
- (AFHTTPSessionManager *)postWithManager:(AFHTTPSessionManager *)manager
                                      key:(NSString *)requestKey
                                parameter:(NSDictionary *)parameter
                               completion:(RHCompletionBlock)completionBlock
                                  failure:(RHFailBlock)failureBlock
{
    return [self postWithManager:manager
                             key:requestKey
                       parameter:parameter
                         process:nil
                      completion:completionBlock
                         failure:failureBlock];
}

/*
 * POST, WITH PROCESS
 */
- (AFHTTPSessionManager *)postWithManager:(AFHTTPSessionManager *)manager
                                      key:(NSString *)requestKey
                                parameter:(NSDictionary *)parameter
                                  process:(RHProcessBlock)processBlock
                               completion:(RHCompletionBlock)completionBlock
                                  failure:(RHFailBlock)failureBlock
{
    ASNetworkActivityTaskDidStart();
    NSString *url = [NSString stringWithFormat:@"%@%@", BaseUrl, requestKey];
    [self postWithManager:manager url:url parameter:parameter process:processBlock completion:completionBlock failure:failureBlock];
    return manager;
}

/*
 * POST FULL PATH
 */
- (AFHTTPSessionManager *)postWithManager:(AFHTTPSessionManager *)manager
                                      url:(NSString *)url
                                parameter:(NSDictionary *)parameter
                                  process:(RHProcessBlock)processBlock
                               completion:(RHCompletionBlock)completionBlock
                                  failure:(RHFailBlock)failureBlock
{
    ASNetworkActivityTaskDidStart();
    NSLog(@"__url:%@\n__parameter:%@\n", url, parameter);
    [manager POST:url parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        if(processBlock)
        {
            NSLog(@"__POST进度:%.2f%@", ((uploadProgress.completedUnitCount*1.0)/(uploadProgress.totalUnitCount*1.0))*100, @"%");
            processBlock(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ASNetworkActivityTaskDidFinish();
        NSLog(@"__responseObject:%@", responseObject);
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ASNetworkActivityTaskDidFinish();
        NSLog(@"__error:%@", error);
        if (failureBlock)
        {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
            failureBlock(error);
        }
    }];
    return manager;
}

/*
 * PUT
 */
- (AFHTTPSessionManager *)putWithManager:(AFHTTPSessionManager *)manager
                                     key:(NSString *)requestKey
                               parameter:(NSDictionary *)parameter
                              completion:(RHCompletionBlock)completionBlock
                                 failure:(RHFailBlock)failureBlock
{
    ASNetworkActivityTaskDidStart();
    NSString *url = [NSString stringWithFormat:@"%@%@", BaseUrl, requestKey];
    [self putWithManager:manager url:url parameter:parameter completion:completionBlock failure:failureBlock];
    return manager;
}

/*
 * PUT FULL PATH
 */
- (AFHTTPSessionManager *)putWithManager:(AFHTTPSessionManager *)manager
                                     url:(NSString *)url
                               parameter:(NSDictionary *)parameter
                              completion:(RHCompletionBlock)completionBlock
                                 failure:(RHFailBlock)failureBlock
{
    ASNetworkActivityTaskDidStart();
    NSLog(@"__url:%@\n__parameter:%@\n", url, parameter);
    [manager PUT:url parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ASNetworkActivityTaskDidFinish();
        NSLog(@"__responseObject:%@", responseObject);
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ASNetworkActivityTaskDidFinish();
        NSLog(@"__error:%@", error);
        if (failureBlock)
        {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
            failureBlock(error);
        }
    }];
    return manager;
}

/*
 * UPLOAD
 */
-(AFHTTPSessionManager *)uploadFileWithManager:(AFHTTPSessionManager *)manager
                                           key:(NSString *)requestKey
                                     parameter:(NSDictionary *)parameter
                                          data:(NSData *)data
                                       process:(RHProcessBlock)processBlock
                                    completion:(RHCompletionBlock)completionBlock
                                       failure:(RHFailBlock)failureBlock
{
    ASNetworkActivityTaskDidStart();
    NSString *url = [NSString stringWithFormat:@"%@%@", BaseUrl, requestKey];
    [self uploadFileWithManager:manager url:url parameter:parameter data:data process:processBlock completion:completionBlock failure:failureBlock];
    return manager;
}

/*
 * UPLOAD, FULL PATH
 */
-(AFHTTPSessionManager *)uploadFileWithManager:(AFHTTPSessionManager *)manager
                                           url:(NSString *)url
                                     parameter:(NSDictionary *)parameter
                                          data:(NSData *)data
                                       process:(RHProcessBlock)processBlock
                                    completion:(RHCompletionBlock)completionBlock
                                       failure:(RHFailBlock)failureBlock
{
    ASNetworkActivityTaskDidStart();
    NSLog(@"__url:%@\n__parameter:%@\n", url, parameter);
    [manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //使用日期生成图片名称
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
        [formData appendPartWithFileData:data name:@"Img" fileName:fileName mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //获取进度
        processBlock(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //上传图片成功执行回调
        ASNetworkActivityTaskDidFinish();
        NSLog(@"__responseObject:%@", responseObject);
        completionBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //上传图片失败执行回调
        ASNetworkActivityTaskDidFinish();
        NSLog(@"__error:%@", error);
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        failureBlock(error);
    }];
    return manager;
}

/*
 * DOWNLOAD
 */
-(void)downloadFileWithRequestKey:(NSString *)requestKey
                        parameter:(NSDictionary *)parameter
                          process:(RHProcessBlock)processBlock
                       completion:(RHCompletionBlock)completionBlock
                          failure:(RHFailBlock)failureBlock
{
    NSString *url = [NSString stringWithFormat:@"%@%@", BaseUrl, requestKey];
    [self downloadFileWithRequestUrl:url parameter:parameter process:processBlock completion:completionBlock failure:failureBlock];
}

/*
 * DOWNLOAD, FULL PATH
 */
-(void)downloadFileWithRequestUrl:(NSString *)url
                        parameter:(NSDictionary *)parameter
                          process:(RHProcessBlock)processBlock
                       completion:(RHCompletionBlock)completionBlock
                          failure:(RHFailBlock)failureBlock
{
    ASNetworkActivityTaskDidStart();
    NSLog(@"__url:%@\n__parameter:%@\n", url, parameter);
    RequestDownloader *downloadManager = [[RequestDownloader alloc] init];
    [downloadManager downloadTaskWithUrl:url progressBlock:^(NSProgress *process) {
        if(processBlock)
        {
            NSLog(@"__下载进度:%.2f%@", ((process.completedUnitCount*1.0)/(process.totalUnitCount*1.0))*100, @"%");
            processBlock(process);
        }
    } completionBlock:^(NSURLResponse *response, id responseObject) {
        ASNetworkActivityTaskDidFinish();
        if(completionBlock)
        {
            NSLog(@"__responseObject:%@", responseObject);
            completionBlock(responseObject);
        }
    } failBlock:^(NSURLResponse *response, NSError *error) {
        ASNetworkActivityTaskDidFinish();
        if(failureBlock)
        {
            NSLog(@"__error:%@", error);
            failureBlock(error);
        }
    }];
}

@end

