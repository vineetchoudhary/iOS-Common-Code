//
//  UITableViewCell+CellSeparator.h
//
//  Created by Vineet Choudhary
//  Copyright (c) 2015 Vineet Choudhary
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (
                            )

-(void)addFullTopSeparatorWithColor:(UIColor *)color andLineThicknes:(CGFloat)thickness;
-(void)addFullBottomSeparatorWithColor:(UIColor *)color andLineThickness:(CGFloat)thickness;
-(void)addBottomSeparatorWithColor:(UIColor *)color andLineWidth:(CGFloat)thickness andX:(CGFloat)x;

@end
