//
//  GeneralTool.h
//  IntegralWall
//
//  Created by QingHu on 2018/6/25.
//  Copyright © 2018 QingHu. All rights reserved.
//

/**
 * 通用工具类，提供常用工具方法
 * 使用单例模式创建实例，全局可访问
 **/

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "AFHTTPSessionManager.h"

typedef void(^NetworkReachabilityNoNetworkBlock)(void);
typedef void(^NetworkReachabilityNetworkBlock)(AFNetworkReachabilityStatus status);

@interface GeneralTool : NSObject

@property (nonatomic, copy) NSString *updateVersionUrl;

GD_SINGLETON(GeneralTool)

/**
 快速创建UINavigationController

 @param viewController 跟视图控制器
 @param title 标题
 @param imageName 未选中图片名字
 @param selectedImageName 选中图片名字
 @param normalTitlColor 未选中标题颜色
 @param selectedTitleColor 选中标题颜色
 @param fontSize 字体大小
 @return UINavigationController
 */
-(UINavigationController *)createRootTabBarItemWithController:(UIViewController *)viewController
                                                        title:(NSString *)title
                                                    imageName:(NSString *)imageName
                                            selectedImageName:(NSString *)selectedImageName
                                              normalTitlColor:(UIColor *)normalTitlColor
                                           selectedTitleColor:(UIColor *)selectedTitleColor
                                                    titleFont:(NSUInteger)fontSize;

/**
 判断是否是合法的手机号

 @param phoneNum 手机号
 @return 是否合法，YES-合法，NO-不合法
 */
- (BOOL)isPhoneNum:(NSString *)phoneNum;

/**
 根据颜色，创建纯色图片

 @param aColor 颜色值
 @return 纯色图片
 */
-(UIImage *)imageWithColor:(UIColor *)aColor;

/**
 读取本地json文件

 @param name 文件名
 @return 文件内容
 */
- (NSDictionary *)readLocalFileWithName:(NSString *)name;

/**
 取消第一响应者，隐藏键盘
 */
-(void)resignFirstResponder;

/**
 SessionManager单例，防止多次创建占用CPU

 @return AFHTTPSessionManager
 */
-(AFHTTPSessionManager *)sharedAFManager;

//把数字转换成带百千万汉字的,例如500->5百,200000->20万
-(NSString *)transportNumberToUnit:(NSInteger)num;

//是否是合法手机号
- (BOOL)isPhoneNo:(NSString *)phoneNum;

//检查版本更新
- (void)updateApp;

/**
 对字典(Key-Value)排序 区分大小写
 
 @param dict 要排序的字典
 */
- (NSArray *)sortedDictionary:(NSDictionary *)dict;

/**
 根据颜色，生成纯色图片

 @param aColor 颜色值
 @return 纯色图片
 */
-(UIImage *)imageWithColor:(UIColor *)aColor size:(CGSize)size;

/**
 获取广告标识符

 @return 广告标识符
 */
-(NSString *)IDFA;

/**
 获取启屏页图片
 
 @return 启屏页图片
 */
-(UIImage *)getLaunchImage;

/**
 创建UINavigationController

 @param viewController UINavigationController 根控制器
 @return UINavigationController
 */
-(UINavigationController *)generateNavViewController:(UIViewController *)viewController;

/**
 判断当前网络是否添加了代理

 @return YES-添加了代理， NO-没有代理
 */
- (BOOL)getProxyStatus;

/**
 获取字符串高度

 @param string 字符串
 @param fontSize 字体大小
 @param width 固定宽度
 @return 所需高度
 */
- (CGFloat)getHeightWithString:(NSString *)string fontSize:(CGFloat)fontSize width:(CGFloat)width;

/**
 获取字符串所需宽度

 @param string 字符串
 @param fontSize 字体大小
 @return 所需宽度
 */
- (CGFloat)getWidthWithString:(NSString *)string fontSize:(CGFloat)fontSize;

/**
 获取MAC地址
 
 @return MAC地址
 */
- (NSString *)getMacAddress;

/**
 获取设备具体型号
 
 @return 设备具体型号
 */
- (NSString*)deviceModelName;

/**
 获取当前网络状态
 
 @return 当前网络状态
 */
- (NSString *)getNetconnType;


/**
 监听网络状态

 @param networkBlock 有网回调
 @param noNetworkBlock 没有网络回调
 */
-(void)AFNReachabilitynetworkBlock:(NetworkReachabilityNetworkBlock)networkBlock noNetworkBlock:(NetworkReachabilityNoNetworkBlock)noNetworkBlock;

/**
 判断是否越狱
 
 @return YES-已经越狱，NO-未越狱
 */
- (BOOL)isJailBreak;

/**
 获取时间戳
 
 @return 时间戳
 */
- (NSString *)getTimeWithTimeIntervalString;

/**
 将时间戳转成时间字符串
 
 @param formatStr 时间格式
 @param interval 时间戳
 @return 时间字符串
 */
-(NSString *)convertToTimeFormat:(NSString *)formatStr interval:(NSString *)interval;

/**
 将秒转换成时分秒格式"00:00:00"
 
 @param second 秒
 @return 时间
 */
-(NSString *)convertSecond:(NSInteger)second;

@end
