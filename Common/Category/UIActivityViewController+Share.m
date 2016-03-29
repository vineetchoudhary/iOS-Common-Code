//
//  UIActivityViewController+Share.m
//  Pronto
//
//  Created by Vineet Choudhary on 01/03/16.
//  Copyright © 2016 FINOIT TECHNOLOGIES. All rights reserved.
//

#import "UIActivityViewController+Share.h"

@implementation UIActivityViewController (Share)

+ (void)showShareActivityViewControllerWithPresentViewController:(UIViewController *)presentViewController{
    CustomActivityItemProvider *customAIP = [[CustomActivityItemProvider alloc] initWithPlaceholderItem:@""];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[customAIP] applicationActivities:nil];
    [presentViewController presentViewController:activityViewController animated:YES completion:nil];
}


@end

@implementation CustomActivityItemProvider

- (id)activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController{
    return @"";
}

- (id)activityViewController:(UIActivityViewController *)activityViewController itemForActivityType:(NSString *)activityType{
    return @"I just downloaded Pronto App on my iPhone.\n\nIt is a smartphone messenger which replaces SMS and there is no PIN or username to remember - it works just like SMS and uses your internet data plan.\n\nGet it now from https://www.bing.com and say good-bye to SMS!";
}

- (NSString *)activityViewController:(UIActivityViewController *)activityViewController subjectForActivityType:(NSString *)activityType{
    return @"Pronto - Find the right friend at the right time";
}

- (NSString *)activityViewController:(UIActivityViewController *)activityViewController dataTypeIdentifierForActivityType:(NSString *)activityType{
    return @"";
}

- (UIImage *)activityViewController:(UIActivityViewController *)activityViewController thumbnailImageForActivityType:(NSString *)activityType suggestedSize:(CGSize)size{
    return nil;
}

@end
