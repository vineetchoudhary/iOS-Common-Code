//
//  HamburgerViewController.m
//
//  Created by Vineet Choudhary
//  Copyright © Vineet Choudhary. All rights reserved.
//

#import "HamburgerViewController.h"

@interface HamburgerViewController ()

@end

@implementation HamburgerViewController{
    BOOL enableTableViewHeader;
    NSDictionary *staticItem;
    NSArray *menuItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadHamburgerMenuData];
    
    //register table cell nib
    [tableViewHamburgerMenu registerNib:[HamburgerTableViewCell cellNib] forCellReuseIdentifier:[HamburgerTableViewCell cellIdentifer]];
    
    //set table header view
    if (enableTableViewHeader){
        [tableViewHamburgerMenu setTableHeaderView:viewTableHeader];
        [imageViewTableHeaderBottomSepartor setBackgroundColor:[UIColor appTableSeparatorColor]];
    }
    
    //setupStaticItem
    if (staticItem) {
        [imageViewBottomSepartor setBackgroundColor:[UIColor appTableSeparatorColor]];
        constraintsStaticBottomOptionHeight.constant = [HamburgerTableViewCell cellHeight];
        [labelStaticItemTitle setText:[staticItem objectForKey:hamburger_menu_item_title]];
        [imageViewStaticItemImage setImage:[UIImage imageNamed:[staticItem objectForKey:hamburger_menu_item_image]]];
    }else{
        constraintsStaticBottomOptionHeight.constant = 0;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadHamburgerMenuData{
    NSString *hamburgerDataPath = [[NSBundle mainBundle] pathForResource:@"HamburgerData" ofType:@"plist"];
    NSDictionary *hamburgerData = [NSDictionary dictionaryWithContentsOfFile:hamburgerDataPath];
    menuItem = [hamburgerData objectForKey:hamburger_menu_items];
    enableTableViewHeader = (BOOL)[hamburgerData objectForKey:hamburger_enable_table_header];
    staticItem = ([hamburgerData.allKeys containsObject:hamburger_bottom_static_item])?[hamburgerData objectForKey:hamburger_bottom_static_item]:nil;
}


#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return menuItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HamburgerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HamburgerTableViewCell cellIdentifer] forIndexPath:indexPath];
    [cell configCellWithMenuItem:[menuItem objectAtIndex:indexPath.row]];
    [cell addFullBottomSeparatorWithColor:[UIColor appTableSeparatorColor] andLineThickness:1];
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id frontViewController;
    HamburgerItem hamburgerItem = indexPath.row;
    switch (hamburgerItem) {
        case HamburgerItem0:{
            //frontViewController
        }break;
        case HamburgerItem1:{
            //frontViewController
        }break;
        case HamburgerItem2:{
            //frontViewController
        }break;
        case HamburgerItem3:{
            //frontViewController
        }break;
        default:
            break;
    }
    if (frontViewController) {
        [((UINavigationController *)self.revealViewController.frontViewController) setDrawerFrontViewController:frontViewController andAnimated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [HamburgerTableViewCell cellHeight];
}


@end
