//
//  ClassExtensionHeaders.h
//  ComponentizedFramework
//
//  Created by Paul on 2018/8/23.
//  Copyright © 2018年 Paul. All rights reserved.
//

#ifndef ClassExtensionHeaders_h
#define ClassExtensionHeaders_h

#import <AppScaffold/ALAPIEngine.h>
#import <AppScaffold/ASKit.h>
/**
 * 包含 ASCore（包含
 * ASCommonMetrics，                状态栏相关
 * ASDebuggingTools，               调试相关
 * ASDeviceOrientation，            处理设备方向
 * ASError，                        错误类型
 * ASFoundationMethods，            Foundation framework补充
 * ASGlobalCoreLocale，             设备位置信息
 * ASInMemoryCache，                存储和访问内存中的对象
 * ASNetworkActivity，              网络监测
 * ASPaths，                        创建路径
 * ASPreMacro，                     常用宏定义
 * ASRuntimeClassModifications，    交换类的实例方法
 * ASSDKAvailability，              检查SDK功能是否可用
 * ASSnapshotRotation，             实现快照旋转的对象
 * ASViewRecycler                   滚动视图中回收视图
 * 和
 * ASUIKit                          数据异常页面
 **/

#import <AppScaffold/NSString+ALExtension.h>              // 字符串扩展
#import <AppScaffold/UIViewController+Additions.h>        // 控制器扩展
#import <AppScaffold/NSObject+ALExtension.h>              // 类扩展
#import <AppScaffold/UIView+Background.h>                 // 视图背景
#import <AppScaffold/UIView+Additions.h>                  // 视图扩展
#import <AppScaffold/UIActionSheet+Blocks.h>              // Sheet弹窗扩展
#import <AppScaffold/UIAlertView+Blocks.h>                // Alert弹窗扩展
#import <AppScaffold/UIImage+AutoStretching.h>            // 图片适应
#import <AppScaffold/UIImageView+Rotate.h>                // 图片旋转
#import <AppScaffold/UIButton+Extensions.h>               // 按钮扩展
#import <AppScaffold/UIWindow+Extensions.h>               // window扩展

#endif /* ClassExtensionHeaders_h */
