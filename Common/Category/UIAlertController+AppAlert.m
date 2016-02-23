//
//  UIAlertController+AppAlert.h
//
//  Created by Vineet Choudhary
//  Copyright © Vineet Choudhary. All rights reserved.
//

#import "UIAlertController+AppAlert.h"

#define ALERT_ERROR_TITLE @"Error"
#define ALERT_ERROR_CANCEL_BUTTON_TITLE @"OK"
#define ALERT_NETWORK_ERROR_MESSAGE @"No Internet Access."
#define ALERT_COMMON_ERROR_TITLE @"Try that again"
#define ALERT_COMMON_ERROR_MESSAGE @"Something went wrong."

@implementation UIAlertController (AppAlert)

+(void)showWithMessage:(NSString *)message{
    [self showAlertControllerWithTitle:@"" andMessage:message];
}

+(void)showErrorWithMessage:(NSString *)message{
    [self showAlertControllerWithTitle:ALERT_ERROR_TITLE andMessage:message];
}

+(void)showNetworkErrorMessage{
    [self showAlertControllerWithTitle:ALERT_ERROR_TITLE andMessage:ALERT_NETWORK_ERROR_MESSAGE];
}

+(void)showCommonErrorMessage{
    [self showAlertControllerWithTitle:ALERT_COMMON_ERROR_TITLE andMessage:ALERT_COMMON_ERROR_MESSAGE];
}

+(void)showAlertControllerWithTitle:(NSString *)title andMessage:(NSString *)message{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:ALERT_ERROR_CANCEL_BUTTON_TITLE style:UIAlertActionStyleCancel handler:nil]];
    [((AppDelegate *)[[UIApplication sharedApplication] delegate]).navigationController showViewController:alertController sender:nil];
}

@end
