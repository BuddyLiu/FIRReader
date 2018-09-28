//
//  ASSnapshotRotation.h
//
//  Created by square on 15/5/25.
//  Copyright (c) 2015年 square. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * An object designed to easily implement snapshot rotation.
 *
 * Snapshot rotation involves taking two screenshots of a UIView: the "before" and the "after"
 * state of the rotation. These two images are then cross-faded during the rotation, creating an
 * animation that minimizes visual artifacts that would otherwise be noticed when rotation occurs.
 *
 * This feature will only function on iOS 6.0 and higher. On older iOS versions the view will rotate
 * just as it always has.
 *
 * This functionality has been adopted from WWDC 2012 session 240 "Polishing Your Interface
 * Rotations".
 *
 * @defgroup Snapshot-Rotation Snapshot Rotation
 * @{
 */

@protocol ASSnapshotRotationDelegate;

/**
 * The ASSnapshotRotation class provides support for implementing snapshot-based rotations on views.
 *
 * You must call this object's rotation methods from your controller in order for the rotation
 * object to implement the rotation animations correctly.
 */
@interface ASSnapshotRotation : NSObject

// Designated initializer.
- (id)initWithDelegate:(id<ASSnapshotRotationDelegate>)delegate;

@property (nonatomic, weak) id<ASSnapshotRotationDelegate> delegate;

@property (nonatomic, readonly, assign) CGRect frameBeforeRotation;
@property (nonatomic, readonly, assign) CGRect frameAfterRotation;

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation;

@end

/**
 * The ASTableViewSnapshotRotation class implements the fixedInsetsForSnapshotRotation: delegate
 * method and forwards all other delegate methods along.
 *
 * If you are rotating a UITableView you can instantiate a ASTableViewSnapshotRotation object and
 * use it just like you would a snapshot rotation object. The ASTableViewSnapshotRotation class
 * intercepts the fixedInsetsForSnapshotRotation: method and returns insets that map to the
 * dimensions of the content view for the first visible cell in the table view.
 *
 * The assigned delegate only needs to implement containerViewForSnapshotRotation: and
 * rotatingViewForSnapshotRotation:.
 */
@interface ASTableViewSnapshotRotation : ASSnapshotRotation
@end

/**
 * The methods declared by the ASSnapshotRotation protocol allow the adopting delegate to respond to
 * messages from the ASSnapshotRotation class and thus implement snapshot rotations.
 */
@protocol ASSnapshotRotationDelegate <NSObject>
@required

/** @name Accessing Rotation Views */

/**
 * Tells the delegate to return the container view of the rotating view.
 *
 * This is often the controller's self.view. This view must not be the same as the rotatingView and
 * rotatingView must be in the subview tree of containerView.
 *
 *        @sa ASSnapshotRotation::rotatingViewForSnapshotRotation:
 */
- (UIView *)containerViewForSnapshotRotation:(ASSnapshotRotation *)snapshotRotation;

/**
 * Tells the delegate to return the rotating view.
 *
 * The rotating view is the view that will be snapshotted during the rotation.
 *
 * This view must not be the same as the containerView and must be in the subview tree of
 * containerView.
 *
 *        @sa ASSnapshotRotation::containerViewForSnapshotRotation:
 */
- (UIView *)rotatingViewForSnapshotRotation:(ASSnapshotRotation *)snapshotRotation;

@optional

/** @name Configuring Fixed Insets */

/**
 * Asks the delegate to return the insets of the rotating view that should be fixed during rotation.
 *
 * This method will only be called on iOS 6.0 and higher.
 *
 * The returned insets will denote which parts of the snapshotted images will not stretch during
 * the rotation animation.
 */
- (UIEdgeInsets)fixedInsetsForSnapshotRotation:(ASSnapshotRotation *)snapshotRotation;

@end

#if defined __cplusplus
extern "C" {
#endif

/**
 * Returns an opaque UIImage snapshot of the given view.
 *
 * This method takes into account the offset of scrollable views and captures whatever is currently
 * in the frame of the view.
 *
 * @param view A snapshot will be taken of this view.
 * @returns A UIImage with the snapshot of @c view.
 */
UIImage* ASSnapshotOfView(UIView* view);

/**
 * Returns a UIImageView with an image snapshot of the given view.
 *
 * The frame of the returned view is set to match the frame of @c view.
 *
 * @param view A snapshot will be taken of this view.
 * @returns A UIImageView with the snapshot of @c view and matching frame.
 */
UIImageView* ASSnapshotViewOfView(UIView* view);

/**
 * Returns a UIImage snapshot of the given view with transparency.
 *
 * This method takes into account the offset of scrollable views and captures whatever is currently
 * in the frame of the view.
 *
 * @param view A snapshot will be taken of this view.
 * @returns A UIImage with the snapshot of @c view.
 */
UIImage* ASSnapshotOfViewWithTransparency(UIView* view);

/**
 * Returns a UIImageView with an image snapshot with transparency of the given view.
 *
 * The frame of the returned view is set to match the frame of @c view.
 *
 * @param view A snapshot will be taken of this view.
 * @returns A UIImageView with the snapshot of @c view and matching frame.
 */
UIImageView* ASSnapshotViewOfViewWithTransparency(UIView* view);

#if defined __cplusplus
}
#endif

/**
 * @}
 */

/** @name Creating a Snapshot Rotation Object */

/**
 * Initializes a newly allocated rotation object with a given delegate.
 *
 * @param delegate A delegate that implements the ASSnapshotRotation protocol.
 * @returns A ASSnapshotRotation object initialized with @c delegate.
 * @fn ASSnapshotRotation::initWithDelegate:
 */

/** @name Accessing the Delegate */

/**
 * The delegate of the snapshot rotation object.
 *
 * The delegate must adopt the ASSnapshotRotation protocol. The ASSnapshotRotation class, which does
 * not retain the delegate, invokes each protocol method the delegate implements.
 *
 * @fn ASSnapshotRotation::delegate
 */

/** @name Implementing UIViewController Autorotation */

/**
 * Prepares the animation for a rotation by taking a snapshot of the rotatingView in its current
 * state.
 *
 * This method must be called from your UIViewController implementation.
 *
 * @fn ASSnapshotRotation::willRotateToInterfaceOrientation:duration:
 */

/**
 * Crossfades between the initial and final snapshots.
 *
 * This method must be called from your UIViewController implementation.
 *
 * @fn ASSnapshotRotation::willAnimateRotationToInterfaceOrientation:duration:
 */

/**
 * Finalizes the rotation animation by removing the snapshot views from the container view.
 *
 * This method must be called from your UIViewController implementation.
 *
 * @fn ASSnapshotRotation::didRotateFromInterfaceOrientation:
 */
