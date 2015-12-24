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
}

#pragma mark - Setup initial view and values

-(void)loadUISettings{
    if([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [barButtonItemBack setImage:[self backButtonImage]];
    [barButtonItemForward setImage:[self forwardButtonImage]];
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
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:error.localizedDescription message:nil delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
    [errorAlert show];
}

#pragma mark - Item bar button activity

-(void)setBarButtonState{
    [barButtonItemBack setEnabled: webView.canGoBack];
    [barButtonItemForward setEnabled: webView.canGoForward];
    [barButtonItemRefresh setEnabled: !webView.isLoading];
    [activityIndicator setHidden: !webView.isLoading];
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
