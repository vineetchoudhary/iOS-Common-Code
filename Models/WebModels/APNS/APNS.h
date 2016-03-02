//
//  APNS.h
//
//  Created by Vineet Choudhary
//  Copyright (c) Vineet Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    PushNotificationType1,
    PushNotificationType2
} PushNotificationType;

@interface APNS : NSObject

@property (nonatomic, retain) NSString *sound;
@property (nonatomic, retain) NSNumber *badge;
@property (nonatomic, retain) NSString *message;
@property (nonatomic) PushNotificationType pushNotificationType;

- (instancetype)initWithServerResponse:(NSDictionary *)serverResponse;

@end
