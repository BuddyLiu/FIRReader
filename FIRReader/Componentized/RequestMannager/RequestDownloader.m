//
//  RequestDownloader.m
//  ComponentizedFramework
//
//  Created by Paul on 2018/8/24.
//  Copyright © 2018年 Paul. All rights reserved.
//

#import "RequestDownloader.h"

@implementation RequestDownloader

/**
 * downloadTask的懒加载
 */
- (void)downloadTaskWithUrl:(NSString *)urlStr
              progressBlock:(RDProcessBlock)downloadProcessBlock
            completionBlock:(RDCompletionBlock)downloadCompletionBlock
                  failBlock:(RDFailBlock)failBlock
{
    /* 创建网络下载对象 */
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];

    /* 下载地址 */
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    /* 下载路径 */
    NSString *path = NSHomeDirectory();
    NSString *filePath = [path stringByAppendingPathComponent:url.lastPathComponent];

    /* 开始请求下载 */
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"下载进度：%.0f％", downloadProgress.fractionCompleted * 100);
        if(downloadProcessBlock)
        {
            downloadProcessBlock(downloadProgress);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //如果需要进行UI操作，需要获取主线程进行操作
        });
        /* 设定下载到的位置 */
        return [NSURL fileURLWithPath:filePath];

    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"下载完成");
        if(error)
        {
            if(failBlock)
            {
                failBlock(response, error);
            }
        }
        else
        {
            if(downloadCompletionBlock)
            {
                NSString *filePathStr = [[NSBundle mainBundle] pathForResource:filePath.lastPathComponent ofType:@""];
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:filePathStr]];
                downloadCompletionBlock(response, data);
            }
        }
    }];
    [downloadTask resume];
}

@end
