//
//  UIAlertController+AppAlert.h
//
//  Created by Vineet Choudhary
//  Copyright © Vineet Choudhary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (AppAlert)

//alert
+(void)showCommonErrorMessage;
+(void)showNetworkErrorMessage;
+(void)showWithMessage:(NSString *)message;
+(void)showErrorWithMessage:(NSString *)message;

//action
+ (void)showAlertControllerForImageSelectionWithDelegate:(id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)delegate;

@end
