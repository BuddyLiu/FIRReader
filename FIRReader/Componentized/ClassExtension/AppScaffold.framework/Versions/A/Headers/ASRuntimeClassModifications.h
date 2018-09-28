//
//  ASRuntimeClassModifications.h
//
//  Created by apple on 13-12-9.
//  Copyright (c) 2013年 square. All rights reserved.
//

#import <Foundation/Foundation.h>

#if defined __cplusplus
extern "C" {
#endif

/**
 * For modifying class implementations at runtime.
 *
 * @ingroup ASCore
 * @defgroup Runtime-Class-Modifications Runtime Class Modifications
 * @{
 *
 * @attention Please use caution when modifying class implementations at runtime.
 *                 Apple is prone to rejecting apps for gratuitous use of method swapping.
 *                 In particular, avoid swapping any NSObject methods such as dealloc, init,
 *                 and retain/release on UIKit classes.
 *
 * See example: @link ExampleRuntimeDebugging.m Runtime Debugging with Method Swizzling@endlink
 */

/**
 * Swap two class instance method implementations.
 *
 * Use this method when you would like to replace an existing method implementation in a class
 * with your own implementation at runtime. In practice this is often used to replace the
 * implementations of UIKit classes where subclassing isn't an adequate solution.
 *
 * This will only work for methods declared with a -.
 *
 * After calling this method, any calls to originalSel will actually call newSel and vice versa.
 *
 * Uses method_exchangeImplementations to accomplish this.
 */
void ASSwapInstanceMethods(Class cls, SEL originalSel, SEL newSel);

/**
 * Swap two class method implementations.
 *
 * Use this method when you would like to replace an existing method implementation in a class
 * with your own implementation at runtime. In practice this is often used to replace the
 * implementations of UIKit classes where subclassing isn't an adequate solution.
 *
 * This will only work for methods declared with a +.
 *
 * After calling this method, any calls to originalSel will actually call newSel and vice versa.
 *
 * Uses method_exchangeImplementations to accomplish this.
 */
void ASSwapClassMethods(Class cls, SEL originalSel, SEL newSel);

#if defined __cplusplus
};
#endif

/**@}*/// End of Runtime Class Modifications //////////////////////////////////////////////////////
