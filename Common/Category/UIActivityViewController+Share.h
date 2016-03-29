//
//  UIActivityViewController+Share.h
//  Pronto
//
//  Created by Vineet Choudhary on 01/03/16.
//  Copyright © 2016 FINOIT TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActivityViewController (Share)

+ (void)showShareActivityViewControllerWithPresentViewController:(UIViewController *)presentViewController;

@end

@interface CustomActivityItemProvider : UIActivityItemProvider<UIActivityItemSource>

@end
