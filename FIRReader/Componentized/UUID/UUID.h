//
//  UUID.h
//  IntegralWall
//
//  Created by Paul on 2018/7/9.
//  Copyright © 2018 QingHu. All rights reserved.
//

/**
 * 获取UDID，配合KeyChainStore存储在系统钥匙链中，实现UUID的功能（唯一标示一部手机）
 **/

#import <Foundation/Foundation.h>

@interface UUID : NSObject

+(NSString*)getUUID;

@end
