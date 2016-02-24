//
//  WebViewController.m
//
//  Created by Vineet Choudhary
//  Copyright (c) Vineet Choudhary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>{
    __weak IBOutlet UIToolbar *toolbarBottom;
    __weak IBOutlet UIWebView *webView;
    __weak IBOutlet UIBarButtonItem *barButtonItemBack;
    __weak IBOutlet UIBarButtonItem *barButtonItemForward;
    __weak IBOutlet UIBarButtonItem *barButtonItemRefresh;
    __weak IBOutlet UIActivityIndicatorView *activityIndicator;
}

@property(nonatomic,strong) NSString *url;
@property(nonatomic,strong) UIColor *tintColor;
@property(nonatomic,strong) UIColor *backgroundColor;
@property(nonatomic,strong) UIColor *webViewBackgroundColor;
@property(nonatomic,assign) BOOL translucentToolBar;

- (instancetype)initWithNibInDefaultBundle;

- (IBAction)barButtonBackTapped:(UIBarButtonItem *)sender;
- (IBAction)barButtonForwardTapped:(UIBarButtonItem *)sender;
- (IBAction)barButtonRefreshTapped:(UIBarButtonItem *)sender;

@end
