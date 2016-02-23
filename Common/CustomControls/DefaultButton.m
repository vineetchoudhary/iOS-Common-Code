//
//  DefaultButton.m
//
//  Created by Vineet Choudhary on 11/01/16.
//  Copyright © Vineet Choudhary. All rights reserved.
//

#import "DefaultButton.h"

@implementation DefaultButton

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.layer setCornerRadius:3];
    if (_setBorder) {
        [self.layer setBorderWidth:1];
        [self.layer setBorderColor:_borderColor.CGColor];
    }
}

-(void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    if (highlighted && _heighlightedStateColor && _defaultStateColor) {
        [self setBackgroundColor:_heighlightedStateColor];
        [self setTitleColor:_defaultStateColor forState:UIControlStateNormal];
    }else if (_defaultStateColor && _heighlightedStateColor){
        [self setBackgroundColor:_defaultStateColor];
        [self setTitleColor:_heighlightedStateColor forState:UIControlStateNormal];
    }
}

-(void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
    [self setBackgroundColor:(enabled)?[UIColor grayColor]:[UIColor lightGrayColor]];
}

@end
