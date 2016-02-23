//
//  UIFont+AppFonts.h
//
//  Created by Vineet Choudhary
//  Copyright © Vineet Choudhary. All rights reserved.
//

#import "UIFont+AppFonts.h"

@implementation UIFont (AppFonts)

+(UIFont *)appDefaultFont:(CGFloat)size{
    return [UIFont fontWithName:@"MuseoSans-500" size:size];
}

@end
