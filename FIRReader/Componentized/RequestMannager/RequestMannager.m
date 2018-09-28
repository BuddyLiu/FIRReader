//
//  RequestMannager.m
//  ComponentizedFramework
//
//  Created by Paul on 2018/8/24.
//  Copyright © 2018年 Paul. All rights reserved.
//

#import "RequestMannager.h"
#import "RequestHelper.h"
#import "ShowMessageView.h"

@interface RequestMannager()

@property (nonatomic, strong) ShowMessageView *showMessageView;

@end

#define FIRURLFor(sub__) [NSString stringWithFormat:@"http://api.fir.im/%@", sub__]

@implementation RequestMannager

DEF_SINGLETON(RequestMannager);

//获取应用列表
-(AFHTTPSessionManager *)getAppListRequestWithCompletionBlock:(RMQueryCompletionBlock)completionBlock
                                                    failBlock:(RMQueryFailBlock)failBlock
{
    RequestHelper *requestHelper = [[RequestHelper alloc] init];
    AFHTTPSessionManager *manager = [[GeneralTool sharedInstance] sharedAFManager];
    NSDictionary *param = @{@"api_token":[USERDEFAULTS objectForKey:@"FirAppTokenStr"]};
    manager = [self createManagerHeader:manager];
    [requestHelper requestWithManager:manager url:FIRURLFor(@"apps") parameter:param process:nil completion:^(id responseObject) {
        if(completionBlock && responseObject)
        {
            completionBlock(responseObject);
        }
    } failure:^(NSError *error) {
        if(failBlock)
        {
            failBlock(error);
        }
    }];
    return manager;
}

//获取应用详情
-(AFHTTPSessionManager *)getAppDetailRequestWithAppId:(NSString *)appId
                                      completionBlock:(RMQueryCompletionBlock)completionBlock
                                            failBlock:(RMQueryFailBlock)failBlock
{
    RequestHelper *requestHelper = [[RequestHelper alloc] init];
    AFHTTPSessionManager *manager = [[GeneralTool sharedInstance] sharedAFManager];
    NSDictionary *param = @{@"api_token":[USERDEFAULTS objectForKey:@"FirAppTokenStr"]};
    manager = [self createManagerHeader:manager];
    [requestHelper requestWithManager:manager url:[NSString stringWithFormat:@"http://api.fir.im/apps/%@", appId] parameter:param process:nil completion:^(id responseObject) {
        if(completionBlock && responseObject)
        {
            completionBlock(responseObject);
        }
    } failure:^(NSError *error) {
        if(failBlock)
        {
            failBlock(error);
        }
    }];
    return manager;
}

//获取应用下载安装token
-(AFHTTPSessionManager *)getAppInstallTokenRequestWithAppId:(NSString *)appId
                                            completionBlock:(RMQueryCompletionBlock)completionBlock
                                                  failBlock:(RMQueryFailBlock)failBlock
{
    RequestHelper *requestHelper = [[RequestHelper alloc] init];
    AFHTTPSessionManager *manager = [[GeneralTool sharedInstance] sharedAFManager];
    NSDictionary *param = @{@"api_token":[USERDEFAULTS objectForKey:@"FirAppTokenStr"]};
    manager = [self createManagerHeader:manager];
    [requestHelper requestWithManager:manager url:[NSString stringWithFormat:@"http://api.fir.im/apps/%@/download_token", appId] parameter:param process:nil completion:^(id responseObject) {
        if(completionBlock && responseObject)
        {
            completionBlock(responseObject);
        }
    } failure:^(NSError *error) {
        if(failBlock)
        {
            failBlock(error);
        }
    }];
    return manager;
}

//修改应用信息
-(AFHTTPSessionManager *)changeAppInfoRequestWithAppId:(NSString *)appId
                                                  name:(NSString *)name
                                                  desc:(NSString *)desc
                                                 shortStr:(NSString *)shortStr
                                       completionBlock:(RMQueryCompletionBlock)completionBlock
                                             failBlock:(RMQueryFailBlock)failBlock
{
    RequestHelper *requestHelper = [[RequestHelper alloc] init];
    AFHTTPSessionManager *manager = [[GeneralTool sharedInstance] sharedAFManager];
    NSDictionary *param = @{@"id":appId,
                            @"api_token":[USERDEFAULTS objectForKey:@"FirAppTokenStr"],
                            @"name":name,
                            @"desc":desc,
                            @"short":shortStr};
    manager = [self createManagerHeader:manager];
    [requestHelper putWithManager:manager url:[NSString stringWithFormat:@"http://api.fir.im/apps/%@", appId] parameter:param completion:^(id responseObject) {
        if(completionBlock && responseObject)
        {
            completionBlock(responseObject);
        }
    } failure:^(NSError *error) {
        if(failBlock)
        {
            failBlock(error);
        }
    }];
    return manager;
}


-(AFHTTPSessionManager *)checkUpDateVersion
{
    RequestHelper *requestHelper = [[RequestHelper alloc] init];
    AFHTTPSessionManager *manager = [[GeneralTool sharedInstance] sharedAFManager];
    NSDictionary *param = @{};
    param = [self addDefaultRequestParam:param];
    manager = [self createManagerHeader:manager];
    WEAKSELF
    [requestHelper requestWithManager:manager
                                  key:RequestKey_checkUpdate
                            parameter:@{@"t":@"ios", @"P":AppBundleIdentifier, @"V":AppVersion}
                           completion:^(id responseObject) {
                               weakSelf.showMessageView = [[ShowMessageView alloc] initShowMessageViewWithMessage:@"检测到新版本，请下载更新后使用" titleStr:@"版本更新" delegate:^{
                                   
                               }];
                               [weakSelf.showMessageView show];
                           } failure:^(NSError *error) {
                               
                           }];
    return manager;
}

/**
 * 统一设置请求头
 */
-(AFHTTPSessionManager *)createManagerHeader:(AFHTTPSessionManager *)manager
{
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"AppTerminalType"];
    [manager.requestSerializer setValue:AppVersion forHTTPHeaderField:@"AppVersion"];
    [manager.requestSerializer setValue:@"appstore" forHTTPHeaderField:@"AppChannel"];
    [manager.requestSerializer setValue:AppBundleIdentifier forHTTPHeaderField:@"AppPackageName"];
    [manager.requestSerializer setValue:AppName forHTTPHeaderField:@"AppName"];
    
    NSString *aesStr = aesEncryptString([[GeneralTool sharedInstance] IDFA], [NSString stringWithFormat:@"%@%@", CHWEUIHWIE, IHDOHWODHW]);
    [manager.requestSerializer setValue:[[StringTool sharedInstance] convertStringToHexStr:aesStr] forHTTPHeaderField:@"UniqueId"];
    
    return manager;
}

/**
 * 统一设置请求参数
 */
-(NSDictionary *)addDefaultRequestParam:(NSDictionary *)parameter
{
    int y = 100000 +  (arc4random() % 999999);
    NSDictionary *inDic = @{@"TS":[NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970] * 1000],
                            @"UD":[UUID getUUID],
                            @"RN":[NSString stringWithFormat:@"%d", y]};
    NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:inDic];
    NSArray *paraArr = [[GeneralTool sharedInstance] sortedDictionary:inDic];
    NSMutableString *mStr = [NSMutableString new];
    for (int i = 0; i < paraArr.count; i++)
    {
        [mStr appendString:paraArr[i]];
    }
    mStr = [[mStr lowercaseString] copy];
    NSString *sign = [NSString stringWithFormat:@"%@p=%@%@%@", mStr, SIDCNAUIFLUIEBFO, IDSFHBUISDHFIUT, WNFEIUNWIEUFTR];
    NSString *md5One = [MD5Encrypt MD5ForLower32Bate:sign];
    NSString *md5Two = [MD5Encrypt MD5ForLower32Bate:md5One];
    [mDic setObject:md5Two forKey:@"Sign"];
    for (int i = 0; i < [parameter allKeys].count; i++)
    {
        [mDic setValue:[parameter allValues][i] forKey:[parameter allKeys][i]];
    }
    return [mDic copy];
}

@end
