//
//  AppListModel.m
//  FIRReader
//
//  Created by Paul on 2018/9/27.
//  Copyright © 2018年 Liu Bo. All rights reserved.
//

#import "AppListModel.h"

@implementation AppListModel_Master_Release

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end

@implementation AppListModel_Items

+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"appId":@"id", @"shortStr":@"short"}];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end

@implementation AppListModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end
