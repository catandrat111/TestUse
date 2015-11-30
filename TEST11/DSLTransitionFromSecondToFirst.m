//
//  DSLTransitionFromSecondToFirst.m
//  TransitionExample
//
//  Created by Pete Callaway on 21/07/2013.
//  Copyright (c) 2013 Dative Studios. All rights reserved.
//

#import "DSLTransitionFromSecondToFirst.h"

#import "DSLFirstViewController.h"
#import "DSLSecondViewController.h"
#import "DSLThingCell.h"

@implementation DSLTransitionFromSecondToFirst

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    DSLSecondViewController *fromViewController = (DSLSecondViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    DSLFirstViewController *toViewController = (DSLFirstViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];

    // Get a snapshot of the image view
    // @其中,snapshotViewAfterScreenUpdates 方法的解释,我也不是很懂,反正初级来说会用就行,还可以参照下面的解析:
//    在iOS7 以前， 获取一个UIView的快照有以下步骤： 首先创建一个UIGraphics的图像上下文，然后将视图的layer渲染到该上下文中，从而取得一个图像，最后关闭图像上下文，并将图像显示在UIImageView中。现在我们只需要一行代码就可以完成上述步骤了：
//    
//    [view snapshotViewAfterScreenUpdates:NO];
//    这个方法制作了一个UIView的副本，如果我们希望视图在执行动画之前保存现在的外观，以备之后使用（动画中视图可能会被子视图遮盖或者发生其他一些变化），该方法就特别方便。
//    afterUpdates参数表示是否在所有效果应用在视图上了以后再获取快照。例如，如果该参数为NO，则立马获取该视图现在状态的快照，反之，以下代码只能得到一个空白快照：
//    [view snapshotViewAfterScreenUpdates:YES];
//    [view setAlpha:0.0];
//    由于我们设置afterUpdates参数为YES，而视图的透明度值被设置成了0，所以方法将在该设置应用在视图上了之后才进行快照，于是乎屏幕空空如也。另外就是……你可以对快照再进行快照……继续快照……
    UIView *imageSnapshot = [fromViewController.imageView snapshotViewAfterScreenUpdates:NO];
    imageSnapshot.frame = [containerView convertRect:fromViewController.imageView.frame fromView:fromViewController.imageView.superview];
    fromViewController.imageView.hidden = YES;

    // Get the cell we'll animate to
    DSLThingCell *cell = [toViewController collectionViewCellForThing:fromViewController.thing];
    cell.imageView.hidden = YES;

    // Setup the initial view states
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    [containerView addSubview:imageSnapshot];

    [UIView animateWithDuration:duration animations:^{
        // Fade out the source view controller
        fromViewController.view.alpha = 0.0;

        // Move the image view
        imageSnapshot.frame = [containerView convertRect:cell.imageView.frame fromView:cell.imageView.superview];
    } completion:^(BOOL finished) {
        // Clean up
        [imageSnapshot removeFromSuperview];
        fromViewController.imageView.hidden = NO;
        cell.imageView.hidden = NO;

        // Declare that we've finished
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

@end
