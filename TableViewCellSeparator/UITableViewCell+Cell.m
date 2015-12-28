//
//  UITableViewCell+Cell.m
//
//  Created by Vineet Choudhary
//  Copyright (c) Vineet Choudhary. All rights reserved.
//


#import "UITableViewCell+Cell.h"

@implementation UITableViewCell (Cell)

#pragma mark - Top Separator

-(void)addFullTopSeparatorWithColor:(UIColor *)color andLineWidth:(CGFloat)lineWidth{
    CGRect cellContentFrame = self.contentView.frame;
    UIBezierPath *bottomSeparatorBezierPath = [[UIBezierPath alloc] init];
    [bottomSeparatorBezierPath moveToPoint:CGPointMake(0, 1)];
    [bottomSeparatorBezierPath addLineToPoint:CGPointMake(cellContentFrame.size.width, 1)];
    
    CAShapeLayer *bottomShapeLayer = [[CAShapeLayer alloc] init];
    [bottomShapeLayer setPath:bottomSeparatorBezierPath.CGPath];
    [bottomShapeLayer setStrokeColor:(color == nil)?[UIColor grayColor].CGColor:color.CGColor];
    [bottomShapeLayer setFillColor:[UIColor clearColor].CGColor];
    [bottomShapeLayer setLineWidth:(lineWidth == 0)?1.0f:lineWidth];
    [self.contentView.layer.sublayers enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[CAShapeLayer class]]) {
            [((CAShapeLayer*)obj) removeFromSuperlayer];
        }
    }];
    [self.contentView.layer addSublayer:bottomShapeLayer];
}

#pragma mark - Bottom Separator

-(void)addFullBottomSeparatorWithColor:(UIColor *)color  andLineWidth:(CGFloat)lineWidth{
    CGRect cellContentFrame = self.contentView.frame;
    UIBezierPath *bottomSeparatorBezierPath = [[UIBezierPath alloc] init];
    [bottomSeparatorBezierPath moveToPoint:CGPointMake(0, cellContentFrame.size.height-1)];
    [bottomSeparatorBezierPath addLineToPoint:CGPointMake(cellContentFrame.size.width, cellContentFrame.size.height-1)];
    
    CAShapeLayer *bottomShapeLayer = [[CAShapeLayer alloc] init];
    [bottomShapeLayer setPath:bottomSeparatorBezierPath.CGPath];
    [bottomShapeLayer setStrokeColor:(color == nil)?[UIColor grayColor].CGColor:color.CGColor];
    [bottomShapeLayer setFillColor:[UIColor clearColor].CGColor];
    [bottomShapeLayer setLineWidth:(lineWidth == 0)?1.0f:lineWidth];
    [self.contentView.layer.sublayers enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[CAShapeLayer class]]) {
            [((CAShapeLayer*)obj) removeFromSuperlayer];
        }
    }];
    [self.contentView.layer addSublayer:bottomShapeLayer];
}

-(void)addBottomSeparatorWithColor:(UIColor *)color andLineWidth:(CGFloat)lineWidth andX:(CGFloat)x{
    CGRect cellContentFrame = self.contentView.frame;
    UIBezierPath *bottomSeparatorBezierPath = [[UIBezierPath alloc] init];
    [bottomSeparatorBezierPath moveToPoint:CGPointMake(x, cellContentFrame.size.height-1)];
    [bottomSeparatorBezierPath addLineToPoint:CGPointMake(cellContentFrame.size.width, cellContentFrame.size.height-1)];
    
    CAShapeLayer *bottomShapeLayer = [[CAShapeLayer alloc] init];
    [bottomShapeLayer setPath:bottomSeparatorBezierPath.CGPath];
    [bottomShapeLayer setStrokeColor:(color == nil)?[UIColor grayColor].CGColor:color.CGColor];
    [bottomShapeLayer setFillColor:[UIColor clearColor].CGColor];
    [bottomShapeLayer setLineWidth:(lineWidth == 0)?1.0f:lineWidth];
    [self.contentView.layer.sublayers enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[CAShapeLayer class]]) {
            [((CAShapeLayer*)obj) removeFromSuperlayer];
        }
    }];
    [self.contentView.layer addSublayer:bottomShapeLayer];
}

#pragma mark - Cell Size

+(CGSize)getCellHeightForText:(NSString *)text andAttributeDictionary:(NSDictionary *)attributeDictionary andTotalHorigontalSpaceing:(CGFloat)horigontalSpaceing andTotalVerticalSpaceing:(CGFloat)verticalSpacing{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGRect addressRect = [text boundingRectWithSize: CGSizeMake (-verticalSpacing,CGFLOAT_MAX) options:( NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading ) attributes:attributeDictionary context:nil];
    return CGSizeMake(screenWidth, addressRect.size.height+horigontalSpaceing);
}

@end
