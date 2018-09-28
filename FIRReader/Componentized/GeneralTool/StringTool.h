//
//  StringTool.h
//  IntegralWall
//
//  Created by QingHu on 2018/6/25.
//  Copyright © 2018 QingHu. All rights reserved.
//

/**
 * 字符串处理工具
 **/

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface StringTool : NSObject

GD_SINGLETON(StringTool)

/**
 字符串中插入图片
 
 @param string 字符串
 @param textColor 字符串颜色
 @param textFont 字符串字体大小
 @param imageName 图片名字
 @param imageRect 图片尺寸
 @param insertIndex 插入的位置
 @return NSMutableAttributedString插入图片后的字符串
 */
-(NSMutableAttributedString *)attrTextWithString:(NSString *)string
                                       textColor:(UIColor *)textColor
                                        textFont:(UIFont *)textFont
                                       imageName:(NSString *)imageName
                                       imageRect:(CGRect)imageRect
                                imageInsertIndex:(NSInteger)insertIndex;
/**
 获取字符串展示需要的高度
 
 @param string 字符串
 @param fontSize 字体大小
 @param width 限定宽度
 @return 所需高度
 */
- (CGFloat)getHeightWithString:(NSString *)string
                      fontSize:(CGFloat)fontSize
                         width:(CGFloat)width;

/**
 获取字符串所占的宽度
 
 @param string 字符串
 @param fontSize 字体大小
 @return 所占宽度
 */
- (CGFloat)getWidthWithString:(NSString *)string
                     fontSize:(CGFloat)fontSize;

/**
 判断是否是数字
 
 @param str 字符串
 @return 是否是数字 YES-是，NO-否
 */
- (BOOL)isNumber:(NSString *)str;

/**
 将字符串转为数字
 
 @param numStr 数字字符串
 @return 数字
 */
-(CGFloat)translateToFloat:(NSString *)numStr;

/**
 json字符串转字典

 @param JSONString 字符串
 @return 字典
 */
-(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString;

/**
 字典转json字符串

 @param dic 字典
 @return 字符串
 */
-(NSString *)parseNSDictionaryToJSONString:(NSDictionary *)dic;

/**
 将NSString转换成十六进制的字符串则可使用如下方式
 
 @param str 数字字符串
 @return 十六进制字符串
 */
- (NSString *)convertStringToHexStr:(NSString *)str;

@end
