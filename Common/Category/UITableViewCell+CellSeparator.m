//
//  UITableViewCell+CellSeparator.m
//
//  Created by Vineet Choudhary on 09/11/15.
//  Copyright (c) 2015 Finoit Technologies. All rights reserved.
//


#import "UITableViewCell+CellSeparator.h"

@implementation UITableViewCell (CellSeparator)

#pragma mark - Top Separator

-(void)addFullTopSeparatorWithColor:(UIColor *)color andLineThickness:(CGFloat)thickness{
    CGRect cellContentFrame = self.contentView.frame;
    UIBezierPath *bottomSeparatorBezierPath = [[UIBezierPath alloc] init];
    [bottomSeparatorBezierPath moveToPoint:CGPointMake(0, 0)];
    [bottomSeparatorBezierPath addLineToPoint:CGPointMake(cellContentFrame.size.width, 0)];
    
    CAShapeLayer *bottomShapeLayer = [[CAShapeLayer alloc] init];
    [bottomShapeLayer setPath:bottomSeparatorBezierPath.CGPath];
    [bottomShapeLayer setStrokeColor:(color == nil)?[UIColor grayColor].CGColor:color.CGColor];
    [bottomShapeLayer setFillColor:[UIColor clearColor].CGColor];
    [bottomShapeLayer setLineWidth:(thickness == 0)?1.0f:thickness];
    [self.contentView.layer.sublayers enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[CAShapeLayer class]]) {
            [((CAShapeLayer*)obj) removeFromSuperlayer];
        }
    }];
    [self.contentView.layer addSublayer:bottomShapeLayer];
}

#pragma mark - Bottom Separator

-(void)addFullBottomSeparatorWithColor:(UIColor *)color andLineThickness:(CGFloat)thickness{
    [self addBottomSeparatorWithColor:color andLineThickness:thickness andX:0];
}

-(void)addBottomSeparatorWithColor:(UIColor *)color andLineThickness:(CGFloat)thickness andX:(CGFloat)x{
    CGRect cellContentFrame = self.contentView.frame;
    UIBezierPath *bottomSeparatorBezierPath = [[UIBezierPath alloc] init];
    [bottomSeparatorBezierPath moveToPoint:CGPointMake(x, cellContentFrame.size.height)];
    [bottomSeparatorBezierPath addLineToPoint:CGPointMake(cellContentFrame.size.width, cellContentFrame.size.height)];
    
    CAShapeLayer *bottomShapeLayer = [[CAShapeLayer alloc] init];
    [bottomShapeLayer setPath:bottomSeparatorBezierPath.CGPath];
    [bottomShapeLayer setStrokeColor:(color == nil)?[UIColor grayColor].CGColor:color.CGColor];
    [bottomShapeLayer setFillColor:[UIColor clearColor].CGColor];
    [bottomShapeLayer setLineWidth:(thickness == 0)?1.0f:thickness];
    [self.contentView.layer.sublayers enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[CAShapeLayer class]]) {
            [((CAShapeLayer*)obj) removeFromSuperlayer];
        }
    }];
    [self.contentView.layer addSublayer:bottomShapeLayer];
}

@end
