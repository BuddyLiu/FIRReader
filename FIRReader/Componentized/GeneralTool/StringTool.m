//
//  StringTool.m
//  IntegralWall
//
//  Created by QingHu on 2018/6/25.
//  Copyright © 2018 QingHu. All rights reserved.
//

#import "StringTool.h"

@implementation StringTool

DEF_SINGLETON(StringTool)

-(NSMutableAttributedString *)attrTextWithString:(NSString *)string
                                       textColor:(UIColor *)textColor
                                        textFont:(UIFont *)textFont
                                       imageName:(NSString *)imageName
                                       imageRect:(CGRect)imageRect
                                imageInsertIndex:(NSInteger)insertIndex
{
    NSString *content = [NSString stringWithFormat:@"%@", string];
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[content dataUsingEncoding:NSUnicodeStringEncoding]
                                                                                  options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSForegroundColorAttributeName:textColor}
                                                                       documentAttributes:nil
                                                                                    error:nil];
    NSRange range = NSMakeRange(0, attrStr.length);
    [attrStr addAttribute:NSFontAttributeName value:textFont range:range];
    [attrStr addAttribute:NSForegroundColorAttributeName value:textColor range:range];
    
    NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
    // 表情图片
    attchImage.image = [UIImage imageNamed:imageName];
    // 设置图片大小
    attchImage.bounds = imageRect;
    NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];
    [attrStr insertAttributedString:stringImage atIndex:insertIndex];
    return attrStr;
}

- (CGFloat)getHeightWithString:(NSString *)string fontSize:(CGFloat)fontSize width:(CGFloat)width
{
    if (!string.length)
    {
        return CGSizeZero.height;
    }
    
    CGSize size;
    size = [string sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    size.width += 20;
    
    return size.height;
}

- (CGFloat)getWidthWithString:(NSString *)string fontSize:(CGFloat)fontSize
{
    if (!string.length)
    {
        return CGSizeZero.height;
    }
    
    CGSize size;
    size = [string sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    size.width += 10;
    
    return size.width;
}

- (BOOL)isNumber:(NSString *)str
{
    if (str.length == 0)
    {
        return NO;
    }
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str])
    {
        return YES;
    }
    return NO;
}

-(CGFloat)translateToFloat:(NSString *)numStr
{
    CGFloat returnNum = 0.0;
    NSString *str = [numStr copy];
    if ([str rangeOfString:@"."].length > 0)
    {
        returnNum = [str floatValue];
    }
    else
    {
        if([self isNumber:str])
        {
            str = [NSString stringWithFormat:@"%@.00", str];
            returnNum = [str floatValue];
        }
        else
        {
            returnNum = 0.0;
        }
    }
    return returnNum;
}

-(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString
{
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}

-(NSString *)parseNSDictionaryToJSONString:(NSDictionary *)dic
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (NSString *)convertStringToHexStr:(NSString *)str
{
    if (!str || [str length] == 0) {
        return @"";
    }
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}

@end
