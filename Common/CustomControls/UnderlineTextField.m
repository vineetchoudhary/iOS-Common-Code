//
//  UnderlineTextField.h
//
//  Created by Vineet Choudhary on 11/01/16.
//  Copyright © Vineet Choudhary. All rights reserved.
//

#import "UnderlineTextField.h"

@implementation UnderlineTextField

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.layer setBorderWidth:0];
    [self setValue:_placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
    UIBezierPath *bottomBorderBezierPath = [[UIBezierPath alloc] init];
    [bottomBorderBezierPath moveToPoint:CGPointMake(0, self.frame.size.height-1)];
    [bottomBorderBezierPath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height-1)];
    
    CAShapeLayer *bottomShapeLayer = [[CAShapeLayer alloc] init];
    [bottomShapeLayer setPath:bottomBorderBezierPath.CGPath];
    [bottomShapeLayer setStrokeColor:[UIColor grayColor].CGColor];
    [bottomShapeLayer setFillColor:_bottomBorderColor.CGColor];
    [bottomShapeLayer setLineWidth:1.0f];
    [self.layer addSublayer:bottomShapeLayer];
}

@end
