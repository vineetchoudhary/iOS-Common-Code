//
//  NSDate+TimeAgo.h
//
//  Created by Vineet Choudhary
//  Copyright © Vineet Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (TimeAgo)

- (NSString *)formattedAsTimeAgo;
- (NSString *)formattedAsTimeAgoWithSeconds;

@end
