//
//  UITableViewCell+Cell.h
//
//  Created by Vineet Choudhary
//  Copyright (c) Vineet Choudhary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (Cell)

-(void)addFullTopSeparatorWithColor:(UIColor *)color andLineWidth:(CGFloat)lineWidth;
-(void)addFullBottomSeparatorWithColor:(UIColor *)color andLineWidth:(CGFloat)lineWidth;
-(void)addBottomSeparatorWithColor:(UIColor *)color andLineWidth:(CGFloat)lineWidth andX:(CGFloat)x;
+(CGSize)getCellHeightForText:(NSString *)text andAttributeDictionary:(NSDictionary *)attributeDictionary andTotalHorigontalSpaceing:(CGFloat)horigontalSpaceing andTotalVerticalSpaceing:(CGFloat)verticalSpacing;

@end
