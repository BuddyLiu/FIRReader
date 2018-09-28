//
//  ASNetworkActivity.h
//
//  Created by square on 15/5/25.
//  Copyright (c) 2015年 square. All rights reserved.
//

#import <Foundation/Foundation.h>

#if defined __cplusplus
extern "C" {
#endif

/**
 * For showing network activity in the device's status bar.
 *
 * @ingroup ASCore
 * @defgroup Network-Activity Network Activity
 * @{
 *
 * Two methods for keeping track of all active network tasks. These methods are threadsafe
 * and act as a simple counter. When the counter is positive, the network activity indicator
 * is displayed.
 */

/**
 * Increment the number of active network tasks.
 *
 * The status bar activity indicator will be spinning while there are active tasks.
 *
 * This method is threadsafe.
 */
void ASNetworkActivityTaskDidStart(void);

/**
 * Decrement the number of active network tasks.
 *
 * The status bar activity indicator will be spinning while there are active tasks.
 *
 * This method is threadsafe.
 */
void ASNetworkActivityTaskDidFinish(void);

/**
 * @name For Debugging Only
 * @{
 *
 * Methods that will only do anything interesting if the DEBUG preprocessor macro is defined.
 */

/**
 * Enable network activity debugging.
 *
 * @attention This won't do anything unless the DEBUG preprocessor macro is defined.
 *
 * The AppScaffold network activity methods will only work correctly if they are the only methods to
 * touch networkActivityIndicatorVisible. If you are using another library that touches
 * networkActivityIndicatorVisible then the network activity indicator might not accurately
 * represent its state.
 *
 * When enabled, the networkActivityIndicatorVisible method on UIApplication will be swizzled
 * with a debugging method that checks the global network task count and verifies that state
 * is maintained correctly. If it is found that networkActivityIndicatorVisible is being accessed
 * directly, then an assertion will be fired.
 *
 * If debugging was previously enabled, this does nothing.
 */
void ASEnableNetworkActivityDebugging(void);

/**
 * Disable network activity debugging.
 *
 * @attention This won't do anything unless the DEBUG preprocessor macro is defined.
 *
 * When disabled, the networkActivityIndicatorVisible will be restored if this was previously
 * enabled, otherwise this method does nothing.
 *
 * If debugging wasn't previously enabled, this does nothing.
 */
void ASDisableNetworkActivityDebugging(void);

/**@}*/// End of For Debugging Only

#if defined __cplusplus
};
#endif

/**@}*/// End of Network Activity /////////////////////////////////////////////////////////////////
