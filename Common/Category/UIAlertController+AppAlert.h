//
//  UIAlertController+AppAlert.h
//
//  Created by Vineet Choudhary
//  Copyright © Vineet Choudhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface UIAlertController (AppAlert)

+(void)showCommonErrorMessage;
+(void)showNetworkErrorMessage;
+(void)showWithMessage:(NSString *)message;
+(void)showErrorWithMessage:(NSString *)message;

@end
