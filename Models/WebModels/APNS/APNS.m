//
//  APNS.m
//
//  Created by Vineet Choudhary
//  Copyright (c) Vineet Choudhary. All rights reserved.
//

#import "APNS.h"

NSString *const apns_aps = @"aps";
NSString *const apns_alert = @"alert";
NSString *const apns_badge = @"badge";
NSString *const apns_sound = @"sound";

@implementation APNS

- (instancetype)initWithServerResponse:(NSDictionary *)serverResponse{
    self = [super init];
    if (self) {
        if ([serverResponse.allKeys containsObject:apns_aps]) {
            NSDictionary *aps = [serverResponse objectForKey:apns_aps];
            if ([aps.allKeys containsObject:apns_alert]) [self setMessage: [aps objectForKey:apns_alert]];
            if ([aps.allKeys containsObject:apns_badge]) [self setBadge:[aps objectForKey:apns_badge]];
            if ([aps.allKeys containsObject:apns_sound])[self setSound:[aps objectForKey:apns_sound]];
        }
    }
    return self;
}

-(PushNotificationType)pushNotificationTypeWithCode:(NSString *)code{
    NSArray *pushNotificationCode = @[@"type1", @"type2"];
    return [pushNotificationCode indexOfObject:code];
}

@end
