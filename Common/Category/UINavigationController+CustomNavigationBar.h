//
//  UINavigationController+CustomNavigationBar.h
//
//  Created by Vineet Choudhary
//  Copyright (c) Vineet Choudhary. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LeftBarItemBack = 0,
    LeftBarItemMenu,
    LeftBarItemDown,
    LeftBarItemText,
    LeftBarItemNone,
} LeftBarItemType;

typedef enum : NSUInteger {
    RightBarItemText = 0,
    RightBarWithTextAndIcon,
    RightBarWithOneIcon,
    RightBarWithTwoIcon,
    RightBarWithThreeIcon,
    RightBarItemNone
} RightBarItemType;

typedef enum : NSUInteger {
    NavigationBarBackButtonId = 1000,
    NavigationBarMenuButtonId,
    NavigationBarLeftDownButtonId,
    NavigationBarLeftTextButtonId,
    NavigationBarTextButtonId,
    NavigationBarWithOneIconFirstButtonId,
    NavigationBarWithTwoIconFirstButtonId,
    NavigationBarWithTwoIconSecondButtonId,
    NavigationBarWithThreeIconFirstButtonId,
    NavigationBarWithThreeIconSecondButtonId,
    NavigationBarWithThreeIconThirdButtonId,
    NavigationBarNotificationButtonId
} NavigationBarButtonId;

@protocol UINavigationControllerCustomDelegate <NSObject,UINavigationControllerDelegate,UIGestureRecognizerDelegate>
-(void)navigationBarButtonItemTappedWithId:(NavigationBarButtonId)navigationBarButtonId;
@end

@interface UINavigationController (CustomNavigationBar) <UINavigationControllerDelegate>

@property(nonatomic,weak) id<UINavigationControllerCustomDelegate>customDelegate;

-(void)setupNavigationBarView;
-(void)setStatusBarHidden:(BOOL)hidden;
-(void)setupNavigationBarWithNavigationItem:(UINavigationItem *)navigationItem andTitle:(NSString *)title andLeftBarItemTyep:(LeftBarItemType)leftBarItemType andRightBarItemType:(RightBarItemType)rightBarItemType andRightBarTitle:(NSString *)buttonTitle andRightBarImages:(NSArray *)images;

-(void)setDrawerFrontViewController:(id)frontViewController andAnimated:(BOOL)animated;
-(void)setDrawerFrontViewController:(id)frontViewController andDrawerRearViewController:(id)rearViewController andAnimated:(BOOL)animated;

@end
