//
//  UIView+AnimationHelper.m
//
//  Created by Vineet Choudhary
//  Copyright (c) Vineet Choudhary. All rights reserved.
//

#import "UIView+AnimationHelper.h"
#import <objc/runtime.h>

@implementation UIView (AnimationHelper)

- (void)setOriginalFrame:(CGRect)originalFrame{
    NSArray *frameComponent = [NSArray arrayWithObjects:[NSNumber numberWithFloat:originalFrame.origin.x],
                              [NSNumber numberWithFloat:originalFrame.origin.y],
                              [NSNumber numberWithFloat:originalFrame.size.height],
                              [NSNumber numberWithFloat:originalFrame.size.width],nil];
    NSLog(@"%@",frameComponent);
    NSLog(@"%@",self.superview);
    objc_setAssociatedObject(self, @selector(originalFrame), frameComponent, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)originalFrame{
    NSArray *frameComponent = objc_getAssociatedObject(self, @selector(originalFrame));
    NSLog(@"%@",frameComponent);
    NSLog(@"%@",self.superview);
    if (frameComponent) {
        return CGRectMake(((NSNumber *)frameComponent[0]).floatValue, ((NSNumber *)frameComponent[1]).floatValue, ((NSNumber *)frameComponent[2]).floatValue, ((NSNumber *)frameComponent[3]).floatValue);
    }
    return CGRectZero;
}

- (void)animateOutOfViewWithDuration:(NSTimeInterval)duration andAnimationDirection:(AnimationDirection)animationDirection{
    if (self.originalFrame.size.height == 0) {
        [self setOriginalFrame: self.frame];
    }
    CGRect selfFrame = self.frame;
    switch (animationDirection) {
        case AnimationDirectionDown:{
            selfFrame.origin.y += (([UIScreen mainScreen].bounds.size.height - selfFrame.origin.y) + selfFrame.size.height);
        }break;
            
        case AnimationDirectionLeft:{
            selfFrame.origin.x -= (selfFrame.origin.x + selfFrame.size.width);
        }break;
            
        case AnimationDirectionRight:{
            selfFrame.origin.x += (([UIScreen mainScreen].bounds.size.width - selfFrame.origin.x) + selfFrame.size.width);
        }break;
            
        case AnimationDirectionUp:{
            selfFrame.origin.y -= selfFrame.origin.y + selfFrame.size.height;
        }break;
        default:
            break;
    }
    [UIView animateWithDuration:duration animations:^{
        [self setFrame:selfFrame];
    }];
}

- (void)animateToOriginalPositionWithDuration:(NSTimeInterval)duration{
    [UIView animateWithDuration:duration animations:^{
        [self setFrame:self.originalFrame];
    }];
}

@end
