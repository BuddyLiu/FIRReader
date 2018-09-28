//
//  ModelTool.h
//  IntegralWall
//
//  Created by QingHu on 2018/6/25.
//  Copyright © 2018 QingHu. All rights reserved.
//

/**
 * 通用模型处理工具
 **/

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ModelTool : NSObject

GD_SINGLETON(ModelTool)

/**
 将模型存储到单例，但是此方法是将模型每个属性单独存储的，所以只适应单层模型

 @param obj 模型对象
 */
-(void)saveModel:(NSObject *)obj;
-(void)saveModel:(NSObject *)obj
     needArchive:(BOOL)needArchive;

/**
 根据键获取值

 @param key 键
 @return 值
 */
-(NSObject *)getObjectWithKey:(NSString *)key;
-(NSObject *)getObjectWithKey:(NSString *)key
                needUnarchive:(BOOL)needUnarchive;

/**
 将键值对数组存储到系统单例

 @param values 值数组
 @param keys 键数组
 @param identifier 标识符
 */
-(void)saveValues:(NSArray *)values
             keys:(NSArray *)keys
       identifier:(NSString *)identifier;
-(void)saveValues:(NSArray *)values
             keys:(NSArray *)keys
       identifier:(NSString *)identifier
      needArchive:(BOOL)needArchive;
/**
 保存字典到系统单例

 @param dic 字典
 @param identifier 唯一标示
 */
-(void)saveDict:(NSDictionary *)dic
     identifier:(NSString *)identifier;
-(void)saveDict:(NSDictionary *)dic
     identifier:(NSString *)identifier
    needArchive:(BOOL)needArchive;

/**
 根据唯一标示获取字典

 @param identifier 唯一标示
 @return 返回包含所有带此标识的键值对字典
 */
-(NSDictionary *)getDicWithIdentifier:(NSString *)identifier;
-(NSDictionary *)getDicWithIdentifier:(NSString *)identifier
                        needUnarchive:(BOOL)needUnarchive;

/**
 根据唯一标示和键获取对象

 @param key 键
 @param identifier 唯一标示
 @return 对象
 */
-(NSObject *)getObjectWithKey:(NSString *)key
                   identifier:(NSString *)identifier;
-(NSObject *)getObjectWithKey:(NSString *)key
                   identifier:(NSString *)identifier
                needUnarchive:(BOOL)needUnarchive;
@end
