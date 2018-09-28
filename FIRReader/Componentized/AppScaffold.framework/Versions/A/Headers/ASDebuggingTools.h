//
//  ASDebuggingTools.h
//
//  Created by square on 15/5/25.
//  Copyright (c) 2015年 square. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * For inspecting code and writing to logs in debug builds.
 *
 * Nearly all of the following macros will only do anything if the DEBUG macro is defined.
 * The recommended way to enable the debug tools is to specify DEBUG in the "Preprocessor Macros"
 * field in your application's Debug target settings. Be careful not to set this for your release
 * or app store builds because this will enable code that may cause your app to be rejected.
 *
 *
 * <h2>Debug Assertions</h2>
 *
 * Debug assertions are a lightweight "sanity check". They won't crash the app, nor will they
 * be included in release builds. They <i>will</i> halt the app's execution when debugging so
 * that you can inspect the values that caused the failure.
 *
 * @code
 *  ASDASSERT(statement);
 * @endcode
 *
 * If <i>statement</i> is false, the statement will be written to the log and if a debugger is
 * attached, the app will break on the assertion line.
 *
 *
 * <h2>Debug Logging</h2>
 *
 * @code
 *  ASDPRINT(@"formatted log text %d", param1);
 * @endcode
 *
 * Print the given formatted text to the log.
 *
 * @code
 *  ASDPRINTMETHODNAME();
 * @endcode
 *
 * Print the current method name to the log.
 *
 * @code
 *  ASDCONDITIONLOG(statement, @"formatted log text %d", param1);
 * @endcode
 *
 * If statement is true, then the formatted text will be written to the log.
 *
 * @code
 *  ASDINFO/ASDWARASNG/ASDERROR(@"formatted log text %d", param1);
 * @endcode
 *
 * Will only write the formatted text to the log if ASMaxLogLevel is greater than the respective
 * ASD* method's log level. See below for log levels.
 *
 * The default maximum log level is ASLOGLEVEL_WARNING.
 *
 * <h3>Turning up the log level while the app is running</h3>
 *
 * ASMaxLogLevel is declared a non-const extern so that you can modify it at runtime. This can
 * be helpful for turning logging on while the application is running.
 *
 * @code
 *  ASMaxLogLevel = ASLOGLEVEL_INFO;
 * @endcode
 *
 * @{
 */

#if defined(DEBUG) || defined(AS_DEBUG)

/**
 * Assertions that only fire when DEBUG is defined.
 *
 * An assertion is like a programmatic breakpoint. Use it for sanity checks to save headache while
 * writing your code.
 */
#import <TargetConditionals.h>

#if defined __cplusplus
extern "C" {
#endif

int ASIsInDebugger(void);

#if defined __cplusplus
}
#endif

#if TARGET_IPHONE_SIMULATOR
// We leave the __asm__ in this macro so that when a break occurs, we don't have to step out of
// a "breakInDebugger" function.
#define ASDASSERT(xx) { if (!(xx)) { ASDPRINT(@"ASDASSERT failed: %s", #xx); \
if (ASDebugAssertionsShouldBreak && ASIsInDebugger()) { __asm__("int $3\n" : : ); } } \
} ((void)0)
#else
#define ASDASSERT(xx) { if (!(xx)) { ASDPRINT(@"ASDASSERT failed: %s", #xx); \
if (ASDebugAssertionsShouldBreak && ASIsInDebugger()) { raise(SIGTRAP); } } \
} ((void)0)
#endif // #if TARGET_IPHONE_SIMULATOR

#else
#define ASDASSERT(xx) ((void)0)
#endif // #if defined(DEBUG) || defined(AS_DEBUG)


#define ASLOGLEVEL_INFO     5
#define ASLOGLEVEL_WARNING  3
#define ASLOGLEVEL_ERROR    1

/**
 * The maximum log level to output for AppScaffold debug logs.
 *
 * This value may be changed at run-time.
 *
 * The default value is ASLOGLEVEL_WARNING.
 */
//extern NSInteger ASMaxLogLevel;

/**
 * Whether or not debug assertions should halt program execution like a breakpoint when they fail.
 *
 * An example of when this is used is in unit tests, when failure cases are tested that will
 * fire debug assertions.
 *
 * The default value is YES.
 */
extern BOOL ASDebugAssertionsShouldBreak;

/**
 * Only writes to the log when DEBUG is defined.
 *
 * This log method will always write to the log, regardless of log levels. It is used by all
 * of the other logging methods in AppScaffold' debugging library.
 */
#if defined(DEBUG) || defined(AS_DEBUG)
#define ASDPRINT(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define ASDPRINT(xx, ...)  ((void)0)
#endif // #if defined(DEBUG) || defined(AS_DEBUG)

/**
 * Write the containing method's name to the log using ASDPRINT.
 */
#define ASDPRINTMETHODNAME() ASDPRINT(@"%s", __PRETTY_FUNCTION__)

#if defined(DEBUG) || defined(AS_DEBUG)
/**
 * Only writes to the log if condition is satisified.
 *
 * This macro powers the level-based loggers. It can also be used for conditionally enabling
 * families of logs.
 */
#define ASDCONDITIONLOG(condition, xx, ...) { if ((condition)) { ASDPRINT(xx, ##__VA_ARGS__); } \
} ((void)0)
#else
#define ASDCONDITIONLOG(condition, xx, ...) ((void)0)
#endif // #if defined(DEBUG) || defined(AS_DEBUG)


/**
 * Only writes to the log if ASMaxLogLevel >= ASLOGLEVEL_ERROR.
 */
#define ASDERROR(xx, ...)  ASDCONDITIONLOG((ASLOGLEVEL_ERROR <= ASMaxLogLevel), xx, ##__VA_ARGS__)

/**
 * Only writes to the log if ASMaxLogLevel >= ASLOGLEVEL_WARNING.
 */
#define ASDWARNING(xx, ...)  ASDCONDITIONLOG((ASLOGLEVEL_WARNING <= ASMaxLogLevel), \
xx, ##__VA_ARGS__)

/**
 * Only writes to the log if ASMaxLogLevel >= ASLOGLEVEL_INFO.
 */
#define ASDINFO(xx, ...)  ASDCONDITIONLOG((ASLOGLEVEL_INFO <= ASMaxLogLevel), xx, ##__VA_ARGS__)

/**@}*/// End of Debugging Tools //////////////////////////////////////////////////////////////////
