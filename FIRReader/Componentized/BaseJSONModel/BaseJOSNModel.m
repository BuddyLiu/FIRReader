//
//  BaseJOSNModel.m
//  CreditCardHousekeeper
//
//  Created by QingHu on 2017/11/16.
//  Copyright © 2018年 QingHu. All rights reserved.
//

#import "BaseJOSNModel.h"

@implementation BaseJOSNModel

//与系统命名冲突的字段，可在此处将其改为自定义的名字，解析时，系统会将其一一对应
+(JSONKeyMapper *)keyMapper
{
  return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{}];
}

//设置某属性的值是否可选
+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
  return YES;
}

@end
