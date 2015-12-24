//
//  SimpleImageViewController.h
//
//  Created by Vineet Choudhary
//  Copyright (c) Vineet Choudhary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleImageViewController : UIViewController<UIScrollViewDelegate>

@property(nonatomic,strong) NSString *imageUrl;
@property(nonatomic,weak) IBOutlet UIImageView *imageView;
@property(nonatomic,weak) IBOutlet UIScrollView *scrollView;

@end
