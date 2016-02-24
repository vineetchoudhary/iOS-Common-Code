//
//  WebViewController.m
//
//  Created by Vineet Choudhary
//  Copyright (c) Vineet Choudhary. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

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
    [self checkNavigationController];
}

#pragma mark - Instancetype
- (instancetype)initWithNibInDefaultBundle{
    return [self initWithNibName:NSStringFromClass([WebViewController class]) bundle:nil];
}

#pragma mark - Setup initial view and values

-(void)checkNavigationController{
    if (((self.navigationController && self.navigationController.isBeingPresented) || self.isBeingPresented) && !self.navigationItem.rightBarButtonItem) {
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissSelf)]];
    }else if (self.isMovingToParentViewController && !self.navigationController.isBeingPresented && self.navigationItem.rightBarButtonItem){
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)dismissSelf{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)loadUISettings{
    [barButtonItemBack setImage:[self backButtonImage]];
    [barButtonItemForward setImage:[self forwardButtonImage]];
    [toolbarBottom setTranslucent:_translucentToolBar];
    [self setBarButtonState];
    
    if(_tintColor){
        [barButtonItemBack setTintColor:_tintColor];
        [barButtonItemForward setTintColor:_tintColor];
        [barButtonItemRefresh setTintColor:_tintColor];
        [activityIndicator setTintColor:_tintColor];
    }
    if (_backgroundColor) {
        [toolbarBottom setBackgroundColor:_backgroundColor];
    }
    if (_webViewBackgroundColor) {
        [webView setBackgroundColor:_webViewBackgroundColor];
    }
}


-(void)setValues{
    if (_url.length==0) {
        _url = [[NSBundle mainBundle] pathForResource:@"NoUrlError" ofType:@"html"];
    }
    [webView setDelegate:self];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    
}

#pragma mark - Web View Delegate

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [self setBarButtonState];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self setBarButtonState];
}

-(void)webView:(UIWebView *)webViewLocal didFailLoadWithError:(NSError *)error{
    [self setBarButtonState];
    //ignore NSURLErrorCancelled error
    if (!(([error.domain isEqualToString:NSURLErrorDomain] && error.code == NSURLErrorCancelled) || ([error.domain isEqualToString:@"WebKitErrorDomain"] && error.code == 102))) {
        UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:nil message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
        [errorAlert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [errorAlert dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:errorAlert animated:YES completion:nil];
    }
}

#pragma mark - Item bar button activity

-(void)setBarButtonState{
    [barButtonItemBack setEnabled: webView.canGoBack];
    [barButtonItemForward setEnabled: webView.canGoForward];
    [barButtonItemRefresh setEnabled: !webView.isLoading];
    [activityIndicator setHidden: !webView.isLoading];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:webView.isLoading];
}

#pragma mark - Images

- (UIImage *)backButtonImage
{
    static UIImage *image;
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        CGSize size = CGSizeMake(12.0, 21.0);
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        path.lineWidth = 1.5;
        path.lineCapStyle = kCGLineCapButt;
        path.lineJoinStyle = kCGLineJoinMiter;
        [path moveToPoint:CGPointMake(11.0, 1.0)];
        [path addLineToPoint:CGPointMake(1.0, 11.0)];
        [path addLineToPoint:CGPointMake(11.0, 20.0)];
        [path stroke];
        
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    });
    
    return image;
}

- (UIImage *)forwardButtonImage
{
    static UIImage *image;
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        UIImage *backButtonImage = [self backButtonImage];
        
        CGSize size = backButtonImage.size;
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGFloat x_mid = size.width / 2.0;
        CGFloat y_mid = size.height / 2.0;
        
        CGContextTranslateCTM(context, x_mid, y_mid);
        CGContextRotateCTM(context, M_PI);
        
        [backButtonImage drawAtPoint:CGPointMake(-x_mid, -y_mid)];
        
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    });
    
    return image;
}

#pragma mark - Bar button actions

- (IBAction)barButtonBackTapped:(UIBarButtonItem *)sender {
    [webView goBack];
}

- (IBAction)barButtonForwardTapped:(UIBarButtonItem *)sender {
    [webView goForward];
}

- (IBAction)barButtonRefreshTapped:(UIBarButtonItem *)sender {
    [webView reload];
}
@end
