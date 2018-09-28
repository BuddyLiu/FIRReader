//
//  RequestDownloader.h
//  ComponentizedFramework
//
//  Created by Paul on 2018/8/24.
//  Copyright © 2018年 Paul. All rights reserved.
//

/**
 * 请求管理器，用于下载文件
 **/

#import <Foundation/Foundation.h>

typedef void (^RDProcessBlock)(NSProgress *process);
typedef void (^RDCompletionBlock)(NSURLResponse *response, id responseObject);
typedef void (^RDFailBlock)(NSURLResponse *response, NSError *error);

@interface RequestDownloader : NSObject

- (void)downloadTaskWithUrl:(NSString *)urlStr
              progressBlock:(RDProcessBlock)downloadProcessBlock
            completionBlock:(RDCompletionBlock)downloadCompletionBlock
                  failBlock:(RDFailBlock)failBlock;
@end
