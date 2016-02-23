//
//  DefaultButton.m
//
//  Created by Vineet Choudhary on 11/01/16.
//  Copyright © Vineet Choudhary. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface DefaultButton : UIButton

@property(nonatomic) IBInspectable BOOL setBorder;
@property(nonatomic) IBInspectable UIColor *borderColor;
@property(nonatomic) IBInspectable UIColor *defaultStateColor;
@property(nonatomic) IBInspectable UIColor *heighlightedStateColor;


@end
