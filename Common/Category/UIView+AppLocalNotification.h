//
//  UIView+AppLocalNotification.h
//
//  Created by Vineet Choudhary
//  Copyright © Vineet Choudhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CRToast.h>
#import <CRToastConfig.h>

@interface UIView (AppLocalNotification){
    
}

@property(nonatomic, strong) UILabel *labelNotificationCount;
@property(nonatomic, strong) UILabel *labelNotificationCountOnNavigationBar;

-(void)addNotificationCountSubView;
-(void)addNotificationCountSubViewOnNavigaionBar;
+ (void)showToastWithMessage:(NSString *)message WithCompletion:(void (^)())completion;

@end
