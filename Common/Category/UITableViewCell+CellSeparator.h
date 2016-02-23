//
//  UITableViewCell+CellSeparator.h
//
//  Created by Vineet Choudhary
//  Copyright (c) 2015 Vineet Choudhary
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (CellSeparator)

-(void)addFullTopSeparatorWithColor:(UIColor *)color andLineThickness:(CGFloat)thickness;
-(void)addFullBottomSeparatorWithColor:(UIColor *)color andLineThickness:(CGFloat)thickness;
-(void)addBottomSeparatorWithColor:(UIColor *)color andLineThickness:(CGFloat)thickness andX:(CGFloat)x;

@end
