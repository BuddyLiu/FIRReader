//
//  ALAPIEngine.h
//  Alton
//
//  Created by square on 15/6/15.
//  Copyright (c) 2015年 square. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+ALExtension.h"

@interface ALAPIEngine : NSObject

+ (NSString *)buildSignParamsWithPath:(NSString*) path key:(NSString *)key requiredParams:(NSDictionary*)params httpMethod:(NSString *)method;

+ (NSString *)queryStringFromDictionary:(NSDictionary *)dict;

@end
