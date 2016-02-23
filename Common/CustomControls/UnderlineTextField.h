//
//  UnderlineTextField.h
//
//  Created by Vineet Choudhary on 11/01/16.
//  Copyright © Vineet Choudhary. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface UnderlineTextField : UITextField

@property(nonatomic) IBInspectable UIColor *placeholderColor;
@property(nonatomic) IBInspectable UIColor *bottomBorderColor;

@end
