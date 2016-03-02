//
//  HamburgerTableViewCell.m
//
//  Created by Vineet Choudhary
//  Copyright © Vineet Choudhary. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const hamburger_enable_table_header;
extern NSString *const hamburger_bottom_static_item;
extern NSString *const hamburger_menu_items;
extern NSString *const hamburger_menu_item_title;
extern NSString *const hamburger_menu_item_image;

@interface HamburgerTableViewCell : UITableViewCell{
    IBOutlet UIImageView *imageViewItemImage;
    IBOutlet UILabel *labelItemTitle;
}

+(UINib *)cellNib;
+(CGFloat)cellHeight;
+(NSString *)cellIdentifer;
-(void)configCellWithMenuItem:(NSDictionary *)menuItem;

@end
