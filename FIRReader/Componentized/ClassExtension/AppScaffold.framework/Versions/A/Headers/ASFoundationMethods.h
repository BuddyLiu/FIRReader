//
//  ASFoundationMethods.h
//
//  Created by square on 15/5/25.
//  Copyright (c) 2015年 square. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#if defined __cplusplus
extern "C" {
#endif

/**
 * For filling in gaps in Apple's Foundation framework.
 *
 * @defgroup Foundation-Methods Foundation Methods
 * @{
 *
 * Utility methods save time and headache. You've probably written dozens of your own. AppScaffold
 * hopes to provide an ever-growing set of convenience methods that compliment the Foundation
 * framework's functionality.
 */

#pragma mark - NSInvocation Methods

/**
 * Construct an NSInvocation with an instance of an object and a selector
 *
 *  @return an NSInvocation that will call the given selector on the given target
 */
NSInvocation* ASInvocationWithInstanceTarget(NSObject* target, SEL selector);

/**
 * Construct an NSInvocation for a class method given a class object and a selector
 *
 *  @return an NSInvocation that will call the given class method/selector.
 */
NSInvocation* ASInvocationWithClassTarget(Class targetClass, SEL selector);

#pragma mark - CGRect Methods

/**
 * For manipulating CGRects.
 *
 * @defgroup CGRect-Methods CGRect Methods
 * @{
 *
 * These methods provide additional means of modifying the edges of CGRects beyond the basics
 * included in CoreGraphics.
 */

/**
 * Modifies only the right and bottom edges of a CGRect.
 *
 * @return a CGRect with dx and dy subtracted from the width and height.
 *
 *      Example result: CGRectMake(x, y, w - dx, h - dy)
 */
CGRect ASRectContract(CGRect rect, CGFloat dx, CGFloat dy);

/**
 * Modifies only the right and bottom edges of a CGRect.
 *
 * @return a CGRect with dx and dy added to the width and height.
 *
 *      Example result: CGRectMake(x, y, w + dx, h + dy)
 */
CGRect ASRectExpand(CGRect rect, CGFloat dx, CGFloat dy);

/**
 * Modifies only the top and left edges of a CGRect.
 *
 * @return a CGRect whose origin has been offset by dx, dy, and whose size has been
 *              contracted by dx, dy.
 *
 *      Example result: CGRectMake(x + dx, y + dy, w - dx, h - dy)
 */
CGRect ASRectShift(CGRect rect, CGFloat dx, CGFloat dy);

/**
 * Inverse of UIEdgeInsetsInsetRect.
 *
 *      Example result: CGRectMake(x - left, y - top,
 *                                 w + left + right, h + top + bottom)
 */
CGRect ASEdgeInsetsOutsetRect(CGRect rect, UIEdgeInsets outsets);

/**
 * Returns the x position that will center size within containerSize.
 *
 *      Example result: floorf((containerSize.width - size.width) / 2.f)
 */
CGFloat ASCenterX(CGSize containerSize, CGSize size);

/**
 * Returns the y position that will center size within containerSize.
 *
 *      Example result: floorf((containerSize.height - size.height) / 2.f)
 */
CGFloat ASCenterY(CGSize containerSize, CGSize size);

/**
 * Returns a rect that will center viewToCenter within containerView.
 *
 * @return a CGPoint that will center viewToCenter within containerView.
 */
CGRect ASFrameOfCenteredViewWithinView(UIView* viewToCenter, UIView* containerView);

/**
 * Returns the size of the string with given UILabel properties.
 */
CGSize ASSizeOfStringWithLabelProperties(NSString *string, CGSize constrainedToSize, UIFont *font, NSLineBreakMode lineBreakMode, NSInteger numberOfLines);

/**@}*/


#pragma mark - NSRange Methods

/**
 * For manipulating NSRange.
 *
 * @defgroup NSRange-Methods NSRange Methods
 * @{
 */

/**
 * Create an NSRange object from a CFRange object.
 *
 * @return an NSRange object with the same values as the CFRange object.
 *
 * @attention This has the potential to behave unexpectedly because it converts the
 *                 CFRange's long values to unsigned integers. AppScaffold will fire off a debug
 *                 assertion at runtime if the value will be chopped or the sign will change.
 *                 Even though the assertion will fire, the method will still chop or change
 *                 the sign of the values so you should take care to fix this.
 */
NSRange ASMakeNSRangeFromCFRange(CFRange range);

/**@}*/


#pragma mark - NSData Methods

/**
 * For manipulating NSData.
 *
 * @defgroup NSData-Methods NSData Methods
 * @{
 */

/**
 * Calculates an md5 hash of the data using CC_MD5.
 */
NSString* ASMD5HashFromData(NSData* data);

/**
 * Calculates a sha1 hash of the data using CC_SHA1.
 */
NSString* ASSHA1HashFromData(NSData* data);

/**@}*/


#pragma mark - NSString Methods

/**
 * For manipulating NSStrings.
 *
 * @defgroup NSString-Methods NSString Methods
 * @{
 */

/**
 * Calculates an md5 hash of the string using CC_MD5.
 *
 * Treats the string as UTF8.
 */
NSString* ASMD5HashFromString(NSString* string);

/**
 * Calculates a sha1 hash of the string using CC_SHA1.
 *
 * Treats the string as UTF8.
 */
NSString* ASSHA1HashFromString(NSString* string);

/**
 * Returns a Boolean value indicating whether the string is a NSString object that contains only
 * whitespace and newlines.
 */
BOOL ASIsStringWithWhitespaceAndNewlines(NSString* string);

/**
 * Compares two strings expressing software versions.
 *
 * The comparison is (except for the development version provisions noted below) lexicographic
 * string comparison. So as long as the strings being compared use consistent version formats,
 * a variety of schemes are supported. For example "3.02" < "3.03" and "3.0.2" < "3.0.3". If you
 * mix such schemes, like trying to compare "3.02" and "3.0.3", the result may not be what you
 * expect.
 *
 * Development versions are also supported by adding an "a" character and more version info after
 * it. For example "3.0a1" or "3.01a4". The way these are handled is as follows: if the parts
 * before the "a" are different, the parts after the "a" are ignored. If the parts before the "a"
 * are identical, the result of the comparison is the result of NUMERICALLY comparing the parts
 * after the "a". If the part after the "a" is empty, it is treated as if it were "0". If one
 * string has an "a" and the other does not (e.g. "3.0" and "3.0a1") the one without the "a"
 * is newer.
 *
 * Examples (?? means undefined):
 * @htmlonly
 * <pre>
 *   "3.0" = "3.0"
 *   "3.0a2" = "3.0a2"
 *   "3.0" > "2.5"
 *   "3.1" > "3.0"
 *   "3.0a1" < "3.0"
 *   "3.0a1" < "3.0a4"
 *   "3.0a2" < "3.0a19"  <-- numeric, not lexicographic
 *   "3.0a" < "3.0a1"
 *   "3.02" < "3.03"
 *   "3.0.2" < "3.0.3"
 *   "3.00" ?? "3.0"
 *   "3.02" ?? "3.0.3"
 *   "3.02" ?? "3.0.2"
 * </pre>
 * @endhtmlonly
 */
NSComparisonResult ASCompareVersionStrings(NSString* string1, NSString* string2);

/**
 * Parses a URL query string into a dictionary where the values are arrays.
 *
 * A query string is one that looks like &param1=value1&param2=value2...
 *
 * The resulting NSDictionary will contain keys for each parameter name present in the query.
 * The value for each key will be an NSArray which may be empty if the key is simply present
 * in the query. Otherwise each object in the array with be an NSString corresponding to a value
 * in the query for that parameter.
 */
NSDictionary* ASQueryDictionaryFromStringUsingEncoding(NSString* string, NSStringEncoding encoding);

/**
 * Returns a string that has been escaped for use as a URL parameter.
 */
NSString* ASStringByAddingPercentEscapesForURLParameterString(NSString* parameter);

/**
 * Appends a dictionary of query parameters to a string, adding the ? character if necessary.
 */
NSString* ASStringByAddingQueryDictionaryToString(NSString* string, NSDictionary* query);

/**@}*/


#pragma mark - CGFloat Methods

/**
 * For manipulating CGFloat.
 *
 * @defgroup CGFloat-Methods CGFloat Methods
 * @{
 *
 * These methods provide math functions on CGFloats. They could easily be replaced with <tgmath.h>
 * but that is currently (Xcode 5.0) incompatible with CLANG_ENABLE_MODULES (on by default for
 * many projects/targets). We'll use CG_INLINE because this really should be completely inline.
 */

#if CGFLOAT_IS_DOUBLE
  #define AS_CGFLOAT_EPSILON DBL_EPSILON
#else
  #define AS_CGFLOAT_EPSILON FLT_EPSILON
#endif

/**
 * fabs()/fabsf() sized for CGFloat
 */
CG_INLINE CGFloat ASCGFloatAbs(CGFloat x) {
#if CGFLOAT_IS_DOUBLE
  return (CGFloat)fabs(x);
#else
  return (CGFloat)fabsf(x);
#endif
}

/**
 * floor()/floorf() sized for CGFloat
 */
CG_INLINE CGFloat ASCGFloatFloor(CGFloat x) {
#if CGFLOAT_IS_DOUBLE
  return (CGFloat)floor(x);
#else
  return (CGFloat)floorf(x);
#endif
}

/**
 * ceil()/ceilf() sized for CGFloat
 */
CG_INLINE CGFloat ASCGFloatCeil(CGFloat x) {
#if CGFLOAT_IS_DOUBLE
  return (CGFloat)ceil(x);
#else
  return (CGFloat)ceilf(x);
#endif
}

/**
 * round()/roundf() sized for CGFloat
 */
CG_INLINE CGFloat ASCGFloatRound(CGFloat x) {
#if CGFLOAT_IS_DOUBLE
  return (CGFloat)round(x);
#else
  return (CGFloat)roundf(x);
#endif
}

/**
 * sqrt()/sqrtf() sized for CGFloat
 */
CG_INLINE CGFloat ASCGFloatSqRt(CGFloat x) {
#if CGFLOAT_IS_DOUBLE
  return (CGFloat)sqrt(x);
#else
  return (CGFloat)sqrtf(x);
#endif
}

/**
 * copysign()/copysignf() sized for CGFloat
 */
CG_INLINE CGFloat ASCGFloatCopySign(CGFloat x, CGFloat y) {
#if CGFLOAT_IS_DOUBLE
  return (CGFloat)copysign(x, y);
#else
  return (CGFloat)copysignf(x, y);
#endif
}

/**
 * pow()/powf() sized for CGFloat
 */
CG_INLINE CGFloat ASCGFloatPow(CGFloat x, CGFloat y) {
#if CGFLOAT_IS_DOUBLE
  return (CGFloat)pow(x, y);
#else
  return (CGFloat)powf(x, y);
#endif
}

/**
 * cos()/cosf() sized for CGFloat
 */
CG_INLINE CGFloat ASCGFloatCos(CGFloat x) {
#if CGFLOAT_IS_DOUBLE
  return (CGFloat)cos(x);
#else
  return (CGFloat)cosf(x);
#endif
}

/**@}*/

#pragma mark - General Purpose Methods

/**
 * Bounds a given value within the min and max values.
 *
 * If max < min then value will be min.
 *
 * @returns min <= result <= max
 */
CGFloat ASBoundf(CGFloat value, CGFloat min, CGFloat max);

/**
 * Bounds a given value within the min and max values.
 *
 * If max < min then value will be min.
 *
 * @returns min <= result <= max
 */
NSInteger ASBoundi(NSInteger value, NSInteger min, NSInteger max);

/**@}*/

#if defined __cplusplus
};
#endif

/**@}*/// End of Foundation Methods ///////////////////////////////////////////////////////////////
