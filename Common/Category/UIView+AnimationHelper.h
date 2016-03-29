//
//  UIView+AnimationHelper.h
//
//  Created by Vineet Choudhary
//  Copyright (c) Vineet Choudhary. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    AnimationDirectionUp,
    AnimationDirectionDown,
    AnimationDirectionLeft,
    AnimationDirectionRight
} AnimationDirection;

@interface UIView (AnimationHelper)

@property(assign) CGRect originalFrame;

- (void)animateOutOfViewWithDuration:(NSTimeInterval)duration andAnimationDirection:(AnimationDirection)animationDirection;
- (void)animateToOriginalPositionWithDuration:(NSTimeInterval)duration;

@end

