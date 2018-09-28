//
//  BaseJOSNModel.h
//  CreditCardHousekeeper
//
//  Created by QingHu on 2017/11/16.
//  Copyright © 2018年 QingHu. All rights reserved.
//

/**
 * 基础模型
 * 此模型定义了每个请求返回的JSON数据相同的外部字段，可以通过继承此类来简化模型的建立
 **/

#import <JSONModel/JSONModel.h>

@interface BaseJOSNModel : JSONModel

@property (nonatomic, copy) NSString<Optional> *Result; //是否成功
@property (nonatomic, copy) NSString<Optional> *Status; //状态
@property (nonatomic, copy) NSString<Optional> *Message; //返回信息
@property (nonatomic, copy) NSString<Optional> *ResultCode; //状态码

@end
