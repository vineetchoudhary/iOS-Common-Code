//
//  CircleImageView.h
//
//  Created by Vineet Choudhary
//  Copyright © Vineet Choudhary. All rights reserved.
//

#import "CircleImageView.h"

@implementation CircleImageView

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.layer setCornerRadius: self.frame.size.height/2];
    [self.layer setMasksToBounds: YES];
    if (_setBorder) {
        [self.layer setBorderWidth:5];
        [self.layer setBorderColor:[UIColor grayColor].CGColor];
    }
}


@end
