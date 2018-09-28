//
//  ModelTool.m
//  IntegralWall
//
//  Created by QingHu on 2018/6/25.
//  Copyright © 2018 QingHu. All rights reserved.
//

#import "ModelTool.h"
#import <objc/runtime.h>

@implementation ModelTool

DEF_SINGLETON(ModelTool)

-(void)saveModel:(NSObject *)obj
{
    [self saveModel:obj needArchive:NO];
}

-(void)saveModel:(NSObject *)obj needArchive:(BOOL)needArchive
{
    NSArray *names = [self getAllProperties:[self properties_aps:obj]];
    NSLog(@"%@", names);
    if(names && names.count > 0)
    {
        for (int i = 0; i < names.count; i ++)
        {
            if(names[i])
            {
                if(needArchive)
                {
                    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:names[i]];
                    [USERDEFAULTS setObject:data forKey:names[i]];
                }
                else
                {
                    [USERDEFAULTS setObject:names[i] forKey:names[i]];
                }
            }
        }
    }
}

-(NSObject *)getObjectWithKey:(NSString *)key
{
    return [self getObjectWithKey:key needUnarchive:NO];
}

-(NSObject *)getObjectWithKey:(NSString *)key needUnarchive:(BOOL)needUnarchive
{
    if(needUnarchive)
    {
        return [NSKeyedUnarchiver unarchiveObjectWithData:[USERDEFAULTS objectForKey:key]];
    }
    else
    {
        return [USERDEFAULTS objectForKey:key];
    }
}

//获取对象的所有属性
- (NSArray *)getAllProperties:(NSObject *)obj
{
    u_int count;
    objc_property_t *properties  =class_copyPropertyList([obj class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++)
    {
        const char* propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return propertiesArray;
}

//Model到字典
- (NSDictionary *)properties_aps:(NSObject *)obj
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([obj class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}

//----------------------------------------------------------//

-(void)saveValues:(NSArray *)values
             keys:(NSArray *)keys
       identifier:(NSString *)identifier
{
    [self saveValues:values keys:keys identifier:identifier needArchive:NO];
}

-(void)saveValues:(NSArray *)values
             keys:(NSArray *)keys
       identifier:(NSString *)identifier
       needArchive:(BOOL)needArchive
{
    if(values.count == keys.count)
    {
        for (int i = 0; i < values.count; i++)
        {
            if(needArchive)
            {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:values[i]];
                [USERDEFAULTS setObject:data
                                 forKey:[NSString stringWithFormat:@"__%@__%@", identifier, keys[i]]];
            }
            else
            {
                [USERDEFAULTS setObject:values[i]
                                 forKey:[NSString stringWithFormat:@"__%@__%@", identifier, keys[i]]];
            }
        }
    }
}
-(void)saveDict:(NSDictionary *)dic
     identifier:(NSString *)identifier
{
    
}
-(void)saveDict:(NSDictionary *)dic
     identifier:(NSString *)identifier
     needArchive:(BOOL)needArchive
{
    if(dic)
    {
        for (int i = 0; i < [dic allKeys].count; i++)
        {
            if(needArchive)
            {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[dic allValues][i]];
                [USERDEFAULTS setObject:data
                                 forKey:[NSString stringWithFormat:@"__%@__%@", identifier, [dic allKeys][i]]];
            }
            else
            {
                [USERDEFAULTS setObject:[dic allValues][i]
                                 forKey:[NSString stringWithFormat:@"__%@__%@", identifier, [dic allKeys][i]]];
            }
        }
    }
}

-(NSDictionary *)getDicWithIdentifier:(NSString *)identifier
{
    return [self getDicWithIdentifier:identifier needUnarchive:NO];
}

-(NSDictionary *)getDicWithIdentifier:(NSString *)identifier
                        needUnarchive:(BOOL)needUnarchive
{
    NSMutableDictionary *returnDic = [NSMutableDictionary new];
    NSDictionary *dic = [USERDEFAULTS dictionaryRepresentation];
    for (id  key in dic)
    {
        NSString *keyStr = [NSString stringWithFormat:@"%@", key];
        if([keyStr rangeOfString:identifier].length > 0)
        {
            if(needUnarchive)
            {
                [returnDic setObject:[NSKeyedUnarchiver unarchiveObjectWithData:[USERDEFAULTS objectForKey:keyStr]] forKey:[[keyStr componentsSeparatedByString:[NSString stringWithFormat:@"__%@__", identifier]] lastObject]];
            }
            else
            {
                [returnDic setObject:[USERDEFAULTS objectForKey:keyStr] forKey:[keyStr componentsSeparatedByString:[NSString stringWithFormat:@"__%@__", identifier]]];
            }
        }
    }
    return [returnDic copy];
}

-(NSObject *)getObjectWithKey:(NSString *)key
                   identifier:(NSString *)identifier
{
    return [self getObjectWithKey:key identifier:identifier needUnarchive:NO];
}

-(NSObject *)getObjectWithKey:(NSString *)key
                   identifier:(NSString *)identifier
                needUnarchive:(BOOL)needUnarchive
{
    if(needUnarchive)
    {
        return [NSKeyedUnarchiver unarchiveObjectWithData:[USERDEFAULTS objectForKey:[NSString stringWithFormat:@"__%@__%@", identifier, key]]];
    }
    else
    {
        return [USERDEFAULTS objectForKey:[NSString stringWithFormat:@"__%@__%@", identifier, key]];
    }
}

@end
