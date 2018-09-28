//
//  ASViewRecycler.h
//
//  Created by square on 15/5/25.
//  Copyright (c) 2015年 square. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * For recycling views in scroll views.
 *
 * @defgroup Core-View-Recycling View Recyling
 * @{
 *
 * View recycling is an important aspect of iOS memory management and performance when building
 * scroll views. UITableView uses view recycling via the table cell dequeue mechanism.
 * ASViewRecycler implements this recycling functionality, allowing you to implement recycling
 * mechanisms in your own views and controllers.
 *
 *
 * <h2>Example Use</h2>
 *
 * Imagine building a UITableView. We'll assume that a viewRecycler object exists in the view.
 *
 * Views are usually recycled once they are no longer on screen, so within a did scroll event
 * we might have code like the following:
 *
@code
for (UIView<ASRecyclableView>* view in visibleViews) {
  if (![self isVisible:view]) {
    [viewRecycler recycleView:view];
    [view removeFromSuperview];
  }
}
@endcode
 *
 * This will take the views that are no longer visible and add them to the recycler. At a later
 * point in that same didScroll code we will check if there are any new views that are visible.
 * This is when we try to dequeue a recycled view from the recycler.
 *
@code
UIView<ASRecyclableView>* view = [viewRecycler dequeueReusableViewWithIdentifier:reuseIdentifier];
if (nil == view) {
  // Allocate a new view that conforms to the ASRecyclableView protocol.
  view = [[[...]] autorelease];
}
[self addSubview:view];
@endcode
 *
 */

@protocol ASRecyclableView;

/**
 * An object for efficiently reusing views by recycling and dequeuing them from a pool of views.
 *
 * This sort of object is likely what UITableView and ASPagingScrollView use to recycle their views.
 */
@interface ASViewRecycler : NSObject

- (UIView<ASRecyclableView> *)dequeueReusableViewWithIdentifier:(NSString *)reuseIdentifier;

- (void)recycleView:(UIView<ASRecyclableView> *)view;

- (void)removeAllViews;

@end

/**
 * The ASRecyclableView protocol defines a set of optional methods that a view may implement to
 * handle being added to a ASViewRecycler.
 */
@protocol ASRecyclableView <NSObject>

@optional

/**
 * The identifier used to categorize views into buckets for reuse.
 *
 * Views will be reused when a new view is requested with a matching identifier.
 *
 * If the reuseIdentifier is nil then the class name will be used.
 */
@property (nonatomic, copy) NSString* reuseIdentifier;

/**
 * Called immediately after the view has been dequeued from the recycled view pool.
 */
- (void)prepareForReuse;

@end

/**
 * A simple implementation of the ASRecyclableView protocol as a UIView.
 *
 * This class can be used as a base class for building recyclable views if specific reuse
 * identifiers are necessary, e.g. when the same class might have different implementations
 * depending on the reuse identifier.
 *
 * Assuming functionality is consistent for a given class it is simpler not to have a
 * reuseIdentifier, making the view recycler use the class name as the reuseIdentifier. In this case
 * subclassing this class is overkill.
 */
@interface ASRecyclableView : UIView <ASRecyclableView>

// Designated initializer.
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic, copy) NSString* reuseIdentifier;

@end

/**@}*/ // End of View Recyling

/**
 * Dequeues a reusable view from the recycled views pool if one exists, otherwise returns nil.
 *
 * @fn ASViewRecycler::dequeueReusableViewWithIdentifier:
 * @param reuseIdentifier  Often the name of the class of view you wish to fetch.
 */

/**
 * Adds a given view to the recycled views pool.
 *
 * @fn ASViewRecycler::recycleView:
 * @param view   The view to recycle. The reuse identifier will be retrieved from the view
 *                    via the ASRecyclableView protocol.
 */

/**
 * Removes all of the views from the recycled views pool.
 *
 * @fn ASViewRecycler::removeAllViews
 */

/**
 * Initializes a newly allocated view with the given reuse identifier.
 *
 * This is the designated initializer.
 *
 * @fn ASRecyclableView::initWithReuseIdentifier:
 * @param reuseIdentifier  The identifier that will be used to group this view in the view
 *                              recycler.
 */

/**
 * This view's reuse identifier.
 *
 * Used by ASViewRecycler to pool this view into a group of similar recycled views.
 *
 * @fn ASRecyclableView::reuseIdentifier
 */
