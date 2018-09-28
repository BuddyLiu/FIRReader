//
//  AESCipher.h
//  GH_ToolBarFrame
//
//  Created by 青弧 on 2017/8/16.
//  Copyright © 2018年 QingHu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AESCipher : NSObject

NSString * aesEncryptString(NSString *content, NSString *key);
NSString * aesDecryptString(NSString *content, NSString *key);

NSData * aesEncryptData(NSData *data, NSData *key);
NSData * aesDecryptData(NSData *data, NSData *key);

@end
