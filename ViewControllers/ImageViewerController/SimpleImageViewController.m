//
//  SimpleImageViewController.m
//
//  Created by Vineet Choudhary
//  Copyright (c) Vineet Choudhary. All rights reserved.
//

#import "SimpleImageViewController.h"

@interface SimpleImageViewController ()

@end

@implementation SimpleImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUISettings];
    [self setValues];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark - Setup initial view and values

-(void)loadUISettings{
    if([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self.navigationController setupNavigationBarWithNavigationItem:self.navigationItem andTitle:@"Image" andLeftBarItemTyep:LeftBarItemBack andRightBarItemType:RightBarItemNone andRightBarTitle:nil andRightBarImages:nil];
}

-(void)setValues{
    _scrollView.delegate = self;
    [self.imageView setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:[UIImage imageNamed:@"place-holder"]];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageView;
}


@end
