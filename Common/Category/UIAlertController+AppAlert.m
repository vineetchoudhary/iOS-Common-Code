//
//  UIAlertController+AppAlert.h
//
//  Created by Vineet Choudhary
//  Copyright © Vineet Choudhary. All rights reserved.
//

#import "UIAlertController+AppAlert.h"

#pragma mark - Alert Style

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
    [((AppDelegate *)[[UIApplication sharedApplication] delegate]).navigationController presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Action Sheet

#define ALERT_IMAGE_TITLE @"Select Image Source"
#define ALERT_IMAGE_CANCEL_ACTION_TITLE @"Cancel"
#define ALERT_IMAGE_CAMERA_ACTION_TITLE @"Camera"
#define ALERT_IMAGE__ACTION_GALLERY_TITLE @"Image Gallery"

+ (void)showAlertControllerForImageSelectionWithDelegate:(id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)delegate{
    //get navigation controller instance
    UINavigationController *navigationController = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).navigationController;
    
    //setup image picker
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    [imagePickerController setAllowsEditing:YES];
    [navigationController setupNavigationBarForPicker:imagePickerController.navigationBar];
    
    //add alert action
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:ALERT_IMAGE_TITLE message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:ALERT_IMAGE_CANCEL_ACTION_TITLE style:UIAlertActionStyleCancel handler:nil]];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [alertController addAction:[UIAlertAction actionWithTitle:ALERT_IMAGE_CAMERA_ACTION_TITLE style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [imagePickerController setSourceType: UIImagePickerControllerSourceTypeCamera];
            [navigationController.topViewController presentViewController:imagePickerController animated:YES completion:nil];
            [imagePickerController setDelegate:delegate];
        }]];
    }
    [alertController addAction:[UIAlertAction actionWithTitle:ALERT_IMAGE__ACTION_GALLERY_TITLE style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [imagePickerController setSourceType: UIImagePickerControllerSourceTypePhotoLibrary];
        [navigationController setupNavigationBarForPicker:imagePickerController.navigationBar];
        [navigationController.topViewController presentViewController:imagePickerController animated:YES completion:nil];
        [imagePickerController setDelegate:delegate];
    }]];
    //present alert
    [navigationController presentViewController:alertController animated:YES completion:nil];
}


@end
