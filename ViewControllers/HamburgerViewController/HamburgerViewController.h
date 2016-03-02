//
//  HamburgerViewController.m
//
//  Created by Vineet Choudhary
//  Copyright © Vineet Choudhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HamburgerTableViewCell.h"

typedef enum : NSUInteger {
    HamburgerItem0,
    HamburgerItem1,
    HamburgerItem2,
    HamburgerItem3
} HamburgerItem;

@interface HamburgerViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    IBOutlet UIView *viewTableHeader;
    IBOutlet UITableView *tableViewHamburgerMenu;
    IBOutlet NSLayoutConstraint *constraintsStaticBottomOptionHeight;
    IBOutlet UILabel *labelStaticItemTitle;
    IBOutlet UIImageView *imageViewStaticItemImage;
}

@end
