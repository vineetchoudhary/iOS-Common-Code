//
//  UIColor+AppColor.m
//
//  Created by Vineet Choudhary
//  Copyright (c) Vineet Choudhary. All rights reserved.
//

#import "UIColor+AppColor.h"

@implementation UIColor (AppColor)

#pragma mark - Common
+(UIColor *)appControlDefaultStateColor{
    return [UIColor colorWithRed:(63.0/255) green:(135.0/255) blue:(251.0/255) alpha:1];
}

+(UIColor *)appTableSeparatorColor{
    return [UIColor colorWithRed:(235.0/255) green:(235.0/255) blue:(235.0/255) alpha:1];
}

+(UIColor *)appImageViewBorderColor{
    return [UIColor colorWithWhite:1 alpha:0.1];
}

#pragma mark - Button Color

+(UIColor *)appDefaultButtonDisableStateColor{
    return [UIColor colorWithRed:(89.0/255) green:(89.0/255) blue:(89.0/255) alpha:1];
}

+(UIColor *)appStatusButtonNormalStateColor{
    return [UIColor colorWithRed:(38.0/255) green:(38.0/255) blue:(38.0/255) alpha:1];
}

+(UIColor *)appStatusButtonSelectedStateColor{
    return [UIColor colorWithRed:(115.0/255) green:(176.0/255) blue:(251.0/255) alpha:1];
}


@end
