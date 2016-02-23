//
//  UIView+AppLocalNotification.m
//  Pronto
//
//  Created by Vineet Choudhary
//  Copyright © Vineet Choudhary. All rights reserved.
//

#import "UIView+AppLocalNotification.h"

@implementation UIView (AppLocalNotification)

#pragma mark - Toast
+ (void)showToastWithMessage:(NSString *)message WithCompletion:(void (^)())completion{
    NSDictionary *options = @{
                              kCRToastTextKey : message,
                              kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                              kCRToastBackgroundColorKey : [UIColor appControlDefaultStateColor],
                              kCRToastAnimationInTypeKey : @(CRToastAnimationTypeSpring),
                              kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeSpring),
                              kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                              kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop),
                              kCRToastNotificationTypeKey : @(CRToastTypeStatusBar),
                              kCRToastTimeIntervalKey : @(1.5),
                              kCRToastInteractionRespondersKey : @(CRToastInteractionTypeTapOnce)
                              };
    [CRToastManager showNotificationWithOptions:options completionBlock:^{
        if (completion) {
            completion();
        }
    }];
    
}


-(UILabel *)labelNotificationCount{
    static UILabel *notificationCountLabel;
    if (notificationCountLabel == nil) {
        notificationCountLabel = [[UILabel alloc] init];
        [notificationCountLabel setFont:[UIFont systemFontOfSize:11]];
        [notificationCountLabel setBackgroundColor:[UIColor blackColor]];
        [notificationCountLabel setTextAlignment:NSTextAlignmentCenter];
        
        //register NSManagedObjectContextDidSaveNotification notification to sense any modification MessageData
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(managedObjectContextChanged:) name:NSManagedObjectContextDidSaveNotification object:nil];
    }
    return notificationCountLabel;
}

-(void)setLabelNotificationCount:(UILabel *)labelNotificationCount{
    labelNotificationCount = labelNotificationCount;
}


-(void)addNotificationCountSubView{
    //get unread message
    NSInteger unreadMessages = 0;
    
    //set or update unread message count
    [self.labelNotificationCount setText:[NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:unreadMessages]]];
    
    //check either it's already contatins counter label or not
    __block BOOL isContains = NO;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UILabel class]]) {
            isContains = YES;
            *stop = YES;
        }
    }];
    
    // if contains then return
    if (!isContains) {
        
        // add notification counter label subview
        [self addSubview:self.labelNotificationCount];
        isContains = YES;
        
        //set label x and y
        CGRect initalRect = CGRectMake(self.frame.size.width/2 - 2.5, self.frame.origin.y/4 - 2.5, 0, 0);
        [self.labelNotificationCount setFrame:initalRect];
    }
    
    //if no unread message then return
    if (unreadMessages == 0 && isContains) {
        [self.labelNotificationCount removeFromSuperview];
        return;
    }
    
    //apply size animation
    [UIView animateWithDuration:0.5 animations:^{
        [self.labelNotificationCount sizeToFit];
        CGRect finalRect = CGRectMake(self.frame.size.width/2 - 2.5, self.frame.origin.y/4 - 2.5, self.labelNotificationCount.frame.size.width + 5, self.labelNotificationCount.frame.size.height);
        [self.labelNotificationCount setFrame:finalRect];
        [self.labelNotificationCount.layer setCornerRadius:self.labelNotificationCount.frame.size.width/4];
        [self.labelNotificationCount.layer setMasksToBounds:YES];
    }completion:^(BOOL finished) {
        if (finished) {
            [self.labelNotificationCount.layer removeAllAnimations];
        }
    }];
}

-(UILabel *)labelNotificationCountOnNavigationBar{
    static UILabel *labelNotificationCountOnNavigationBar;
    if (labelNotificationCountOnNavigationBar == nil) {
        labelNotificationCountOnNavigationBar = [[UILabel alloc] init];
        [labelNotificationCountOnNavigationBar setFont:[UIFont systemFontOfSize:11]];
        [labelNotificationCountOnNavigationBar setBackgroundColor:[UIColor blackColor]];
        [labelNotificationCountOnNavigationBar setTextAlignment:NSTextAlignmentCenter];
        
        //register NSManagedObjectContextDidSaveNotification notification to sense any modification MessageData
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(managedObjectContextChanged:) name:NSManagedObjectContextDidSaveNotification object:nil];
    }
    return labelNotificationCountOnNavigationBar;
}

-(void)setLabelNotificationCountOnNavigationBar:(UILabel *)labelNotificationCountOnNavigationBar{
    labelNotificationCountOnNavigationBar = labelNotificationCountOnNavigationBar;
}

-(void)addNotificationCountSubViewOnNavigaionBar{
    //get unread message
    NSInteger unreadMessages = 0;
    
    //set or update unread message count
    [self.labelNotificationCountOnNavigationBar setText:[NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:unreadMessages]]];
    
    //check either it's already contatins counter label or not
    __block BOOL isContains = NO;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UILabel class]]) {
            isContains = YES;
            *stop = YES;
        }
    }];
    
    // if contains then return
    BOOL isNewllyAdded = NO;
    if (!isContains) {
        
        // add notification counter label subview
        [self addSubview:self.labelNotificationCountOnNavigationBar];
        isContains = YES;
        isNewllyAdded = YES;
        
        //set label x and y
        CGRect initalRect = CGRectMake(self.frame.size.width/2 - 2.5, self.frame.origin.y/2 - 2.5, 0, 0);
        [self.labelNotificationCountOnNavigationBar setFrame:initalRect];
    }
    [self.labelNotificationCountOnNavigationBar setHidden:NO];\
    //if no unread message then return
    if (unreadMessages == 0 && isContains) {
        [self.labelNotificationCountOnNavigationBar setHidden:YES];
        return;
    }
    
    //apply size animation
    [UIView animateWithDuration:0.5 animations:^{
        [self.labelNotificationCountOnNavigationBar sizeToFit];
        if (isNewllyAdded) {
            CGRect finalRect = CGRectMake(self.frame.size.width/2 - 2.5, self.frame.origin.y/2 - 2.5, self.labelNotificationCountOnNavigationBar.frame.size.width + 5, self.labelNotificationCountOnNavigationBar.frame.size.height);
            [self.labelNotificationCountOnNavigationBar setFrame:finalRect];
        }else {
            CGRect finalRect = self.labelNotificationCountOnNavigationBar.frame;
            finalRect.size.width = finalRect.size.width + 5;
            [self.labelNotificationCountOnNavigationBar setFrame:finalRect];
        }
        [self.labelNotificationCountOnNavigationBar.layer setCornerRadius:self.labelNotificationCountOnNavigationBar.frame.size.width/4];
        [self.labelNotificationCountOnNavigationBar.layer setMasksToBounds:YES];
    }completion:^(BOOL finished) {
        if (finished) {
            [self.labelNotificationCountOnNavigationBar.layer removeAllAnimations];
        }
    }];
}


#pragma mark - NSManagedObjectContextDidSaveNotification notification handler
- (void)managedObjectContextChanged:(NSNotification *)notification{
    NSArray *updatedObject = [[notification.userInfo objectForKey:NSUpdatedObjectsKey] allObjects];
    NSArray *insertedObject = [[notification.userInfo objectForKey:NSInsertedObjectsKey] allObjects];
    if ((updatedObject.count > 0 || insertedObject.count > 0)) {
        NSInteger unreadMessages = 0;
        [self.labelNotificationCount setText:[NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:unreadMessages]]];
    }
}

@end
