//
//  KeyChainStore.h
//  IntegralWall
//
//  Created by Paul on 2018/7/9.
//  Copyright © 2018 QingHu. All rights reserved.
//

/**
 * 将数据存入钥匙串
 **/

#import <Foundation/Foundation.h>

@interface KeyChainStore : NSObject

+ (void)save:(NSString*)service data:(id)data;

+ (id)load:(NSString*)service;

+ (void)deleteKeyData:(NSString*)service;

@end
