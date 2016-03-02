//
//  HamburgerTableViewCell.m
//
//  Created by Vineet Choudhary
//  Copyright © Vineet Choudhary. All rights reserved.
//

#import "HamburgerTableViewCell.h"

NSString *const hamburger_enable_table_header = @"EnableHeader";
NSString *const hamburger_bottom_static_item = @"BottomStaticItem";
NSString *const hamburger_menu_items = @"MenuItems";
NSString *const hamburger_menu_item_title = @"ItemTitle";
NSString *const hamburger_menu_item_image = @"ItemImage";

@implementation HamburgerTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(UINib *)cellNib{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

+(CGFloat)cellHeight{
    return 50;
}

+(NSString *)cellIdentifer{
    return @"HamburgerCellId";
}


-(void)configCellWithMenuItem:(NSDictionary *)menuItem{
    [labelItemTitle setText:[menuItem objectForKey:hamburger_menu_item_title]];
    [imageViewItemImage setImage:[UIImage imageNamed:[menuItem objectForKey:hamburger_menu_item_image]]];
}

@end
