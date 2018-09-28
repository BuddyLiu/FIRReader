//
//  ASUIPreMacro.h
//  Alton
//
//  Created by square on 15/5/25.
//  Copyright (c) 2015年 square. All rights reserved.
//

//------------------ System -----------------------
#define iOS8  ([[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending)
#define iOS7  ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
#define iOS6  ([[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending)
#define iOS5  ([[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending)

// System Version
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//------------------ Code Helper ------------------
#define __AS_DEPRECATED_METHOD __attribute__((deprecated))

/**
 * Force a category to be loaded when an app starts up.
 *
 * Add this macro before each category implementation, so we don't have to use
 * -all_load or -force_load to load object files from static libraries that only contain
 * categories and no classes.
 * See http://developer.apple.com/library/mac/#qa/qa2006/qa1490.html for more info.
 */
#define AS_FIX_CATEGORY_BUG(name) @interface AS_FIX_CATEGORY_BUG_##name : NSObject @end \
@implementation AS_FIX_CATEGORY_BUG_##name @end

//------------------ Date -------------------------
/**
 * DateFormat
 * see: http://www.unicode.org/reports/tr35/tr35-25.html#Date_Format_Patterns
 */

#define kDateFormatOfRails @"yyyy-MM-dd'T'HH:mm:ss.SSSZ" // 2015-09-22T14:30:36.000+08:00


//------------------ UI ---------------------------

/**
 * Creates an opaque UIColor object from a byte-value color definition.
 */
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

/**
 * Creates a UIColor object from a byte-value color definition and alpha transparency.
 */
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

/**
 * Creates a UIColor from a HEX color definition.
 */
#define HEX_RGB(V)	[UIColor colorWithRed:((float)((V & 0xFF0000) >> 16))/255.0 \
green:((float)((V & 0x00FF00) >> 8))/255.0 \
blue:((float)(V & 0x0000FF))/255.0 \
alpha:1.0]

/**
 * Screen
 */
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)