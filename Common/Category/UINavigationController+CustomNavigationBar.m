//
//  UINavigationController+CustomNavigationBar.m
//
//  Created by Vineet Choudhary
//  Copyright (c) Vineet Choudhary. All rights reserved.
//

#import "UINavigationController+CustomNavigationBar.h"
#import <objc/runtime.h>
#import <SWRevealViewController.h>

@implementation UINavigationController (CustomNavigationBar)

-(void)viewDidLoad{
    [super viewDidLoad];
    [self setDelegate:self];
}


#pragma mark - Associate custom delegate

-(void)setCustomDelegate:(id<UINavigationControllerCustomDelegate>)customDelegateLocal{
    objc_setAssociatedObject(self, @selector(customDelegate), customDelegateLocal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(id<UINavigationControllerCustomDelegate>)customDelegate{
    return objc_getAssociatedObject(self, @selector(customDelegate));
}

#pragma mark - Navigation controller delegate
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        navigationController.interactivePopGestureRecognizer.delegate = nil;
        navigationController.interactivePopGestureRecognizer.enabled = NO;
    }else if (operation == UINavigationControllerOperationPop) {

    }
    return nil;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animate{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        if (navigationController.childViewControllers.count > 1){
            navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
            navigationController.interactivePopGestureRecognizer.enabled = YES;
        }else{
            navigationController.interactivePopGestureRecognizer.delegate = nil;
            navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}

#pragma mark - Navigation Custom Setup

-(void)setupNavigationBarWithNavigationItem:(UINavigationItem *)navigationItem andTitle:(NSString *)title andLeftBarItemTyep:(LeftBarItemType)leftBarItemType andRightBarItemType:(RightBarItemType)rightBarItemType andRightBarTitle:(NSString *)buttonTitle andRightBarImages:(NSArray *)images{
    /**
     leftBarItems contains all navigation items which visible in left bar.
     **/
    self.interactivePopGestureRecognizer.enabled = YES;
    NSMutableArray *leftBarItems = [[NSMutableArray alloc] init];
    if (!(leftBarItemType == LeftBarItemNone)) {
        
        //left bar button item
        if (leftBarItemType ==  LeftBarItemText) {
            UIBarButtonItem *leftBarItemWithText = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarItemWithTextTapped:)];
            [leftBarItemWithText setTintColor:[UIColor blackColor]];
            [leftBarItems addObject:leftBarItemWithText];

        }else{
            //left bar button image
            NSString *leftButtonImage = (leftBarItemType == LeftBarItemBack)?@"App_Back":(leftBarItemType == LeftBarItemMenu)?@"App_SideBar_Icon":@"ic_down";
            UIImageView *leftButtonImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:leftButtonImage]];
            CGRect backImageRect = CGRectMake(-5, 2, leftButtonImageView.image.size.width, leftButtonImageView.image.size.height);
            CGRect menuImageRect = CGRectMake(-5, 2, leftButtonImageView.image.size.width, leftButtonImageView.image.size.height);
            [leftButtonImageView setUserInteractionEnabled:YES];
            [leftButtonImageView setFrame:(leftBarItemType == LeftBarItemBack)?backImageRect:menuImageRect];
            
            //left bar item custome view with gesture
            UIView *leftBarItemCustomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftButtonImageView.image.size.width, leftButtonImageView.image.size.height)];
            UITapGestureRecognizer *leftButtonGesture = (leftBarItemType == LeftBarItemBack) ? [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backButtonTapGestureHandler:)] : (leftBarItemType == LeftBarItemMenu)? [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuButtonTapGestureHandler:)] : [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(downButtonTapGestureHandler:)] ;
            [leftBarItemCustomView addGestureRecognizer:leftButtonGesture];
            [leftBarItemCustomView addSubview:leftButtonImageView];
            
            UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBarItemCustomView];
            [leftButtonImageView setUserInteractionEnabled:YES];
            [leftBarItems addObject:leftButtonItem];
        }
    }
    navigationItem.leftBarButtonItems = leftBarItems;
    [navigationItem setTitle:title];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor whiteColor]}];
    
    if (!(rightBarItemType == RightBarItemNone)) {
        /**
         rightBarItems contains all navigation items which visible in left bar
         **/
        NSMutableArray *rightBarItems = [[NSMutableArray alloc] init];
        switch (rightBarItemType) {
                //right bar button item with text
            case RightBarItemText:{
                UIBarButtonItem *rightBarItemWithText = [[UIBarButtonItem alloc] initWithTitle:buttonTitle style:UIBarButtonItemStyleDone target:self action:@selector(rightBarItemWithTextTapped:)];
                [rightBarItemWithText setTintColor:[UIColor blackColor]];
                [rightBarItems addObject:rightBarItemWithText];
            }break;
                
                //right bar with one bar button item
            case RightBarWithOneIcon:{
                UIView *firstBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
                UIImageView *firstImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:images.firstObject]];
                [firstImageView setFrame:CGRectMake(0, 0, firstImageView.image.size.width, firstImageView.image.size.width)];
                [firstBarView addSubview:firstImageView];
                [firstBarView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightBarOneIconFirstButtonTapHandler:)]];
                UIBarButtonItem *firstBarButton = [[UIBarButtonItem alloc] initWithCustomView:firstBarView];
                [rightBarItems addObject:firstBarButton];
            }break;
                
                //right bar with one icon and one text button
            case RightBarWithTextAndIcon:{
                UIView *firstBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
                UIImageView *firstImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:images.firstObject]];
                [firstImageView setFrame:CGRectMake(10, 0, firstImageView.image.size.width, firstImageView.image.size.width)];
                [firstBarView addSubview:firstImageView];
                [firstBarView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightBarOneIconFirstButtonTapHandler:)]];
                UIBarButtonItem *firstBarButton = [[UIBarButtonItem alloc] initWithCustomView:firstBarView];
                [rightBarItems addObject:firstBarButton];
                
                UIBarButtonItem *rightBarItemWithText = [[UIBarButtonItem alloc] initWithTitle:buttonTitle style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItemWithTextTapped:)];
                [rightBarItemWithText setTintColor:[UIColor blackColor]];
                [rightBarItems addObject:rightBarItemWithText];
            }break;
                
                //right bar with two bar button item
            case RightBarWithTwoIcon:{
                UIView *firstBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
                UIImageView *firstImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:images.firstObject]];
                [firstImageView setFrame:CGRectMake(0, 0, firstImageView.image.size.width, firstImageView.image.size.width)];
                [firstBarView addSubview:firstImageView];
                [firstBarView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightBarTwoIconFirstButtonTapHandler:)]];
                UIBarButtonItem *firstBarButton = [[UIBarButtonItem alloc] initWithCustomView:firstBarView];
                [rightBarItems addObject:firstBarButton];
                
                UIView *secondBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
                [secondBarView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightBarTwoIconSecondButtonTapHandler:)]];
                UIImageView *secondImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:images.lastObject]];
                [secondImageView setFrame:CGRectMake(0, 0, secondImageView.image.size.width, secondImageView.image.size.height)];
                [secondBarView addSubview:secondImageView];
                UIBarButtonItem *secondBarButton = [[UIBarButtonItem alloc] initWithCustomView:secondBarView];
                [rightBarItems addObject:secondBarButton];
                
            }break;
                
                //right bar with three bar button item
            case RightBarWithThreeIcon:{
                
            }break;
                
            default:
                break;
        }
        navigationItem.rightBarButtonItems = rightBarItems;
    }
}



-(void)setupNavigationBarView{
    [self.navigationBar setTranslucent:NO];
    [self.navigationBar setBarTintColor: [UIColor appControlDefaultStateColor]];
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, -20,[UIScreen mainScreen].bounds.size.width, 20)];
    [view setBackgroundColor:[UIColor appControlDefaultStateColor]];
    [self.navigationBar addSubview:view];
}

-(void)setStatusBarHidden:(BOOL)hidden{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIApplication sharedApplication] setStatusBarHidden:hidden withAnimation:UIStatusBarAnimationSlide];
}

#pragma mark - Navigation bar items action
-(void)backButtonTapGestureHandler:(UITapGestureRecognizer *)sender{
    [self popViewControllerAnimated:YES];
}

-(void)downButtonTapGestureHandler:(UITapGestureRecognizer *)sender{
    [self.topViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)menuButtonTapGestureHandler:(UITapGestureRecognizer *)sender{
    [[self revealViewController] revealToggleAnimated:YES];
}

-(void)leftBarItemWithTextTapped:(UIBarButtonItem *)sender{
    [self.topViewController dismissViewControllerAnimated:YES completion:nil];
    if (self.customDelegate) {
        [self.customDelegate navigationBarButtonItemTappedWithId:NavigationBarLeftTextButtonId];
    }
}

-(void)rightBarItemWithTextTapped:(UIBarButtonItem *)sender{
    [self.customDelegate navigationBarButtonItemTappedWithId:NavigationBarTextButtonId];
}

-(void)rightBarOneIconFirstButtonTapHandler:(UITapGestureRecognizer *)sender{
    [self.customDelegate navigationBarButtonItemTappedWithId:NavigationBarWithOneIconFirstButtonId];
}

-(void)rightBarTwoIconFirstButtonTapHandler:(UITapGestureRecognizer *)sender{
    [self.customDelegate navigationBarButtonItemTappedWithId:NavigationBarWithTwoIconFirstButtonId];
}

-(void)rightBarTwoIconSecondButtonTapHandler:(UITapGestureRecognizer *)sender{
    [self.customDelegate navigationBarButtonItemTappedWithId:NavigationBarWithTwoIconSecondButtonId];
}

#pragma mark - Common drawer navigation

-(void)setDrawerFrontViewController:(id)frontViewController andAnimated:(BOOL)animated{
    UINavigationController *navigationController = ((UINavigationController *)self.revealViewController.frontViewController);
    if (navigationController == nil) {
        navigationController = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).navigationController;
    }
    
    if ([navigationController.topViewController isKindOfClass:[frontViewController class]]) {
        frontViewController = nil;
    }
    else{
        __block NSUInteger firstControllerMatchAtIndex = -1;
        [navigationController.viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[frontViewController class]]) {
                firstControllerMatchAtIndex = idx;
                *stop = YES;
            }
        }];
        if (firstControllerMatchAtIndex == -1) {
            (!animated)?[navigationController popViewControllerAnimated:NO]:nil;
            [navigationController pushViewController:frontViewController animated:animated];
            [self performSelector:@selector(clearNavigationViewControllerStack) withObject:nil afterDelay:0.6f];
        }
        else{
            [navigationController popToViewController:[navigationController.viewControllers objectAtIndex:firstControllerMatchAtIndex] animated:animated];
        }
    }
    [self.revealViewController setFrontViewController:self.revealViewController.frontViewController];
    [self.revealViewController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    [navigationController.topViewController.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [navigationController.topViewController.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
}

-(void)clearNavigationViewControllerStack{
    NSArray *tempViewController = [NSArray arrayWithObject:self.viewControllers.lastObject];
    [self setViewControllers:tempViewController];
}

-(void)setDrawerFrontViewController:(id)frontViewController andDrawerRearViewController:(id)rearViewController andAnimated:(BOOL)animated{
    [self setDrawerFrontViewController:frontViewController andAnimated:animated];
    [self.revealViewController setRearViewController:rearViewController];
}

@end
