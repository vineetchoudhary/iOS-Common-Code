//
//  NSUserDefaults+AppSetting.h
//
//  Created by Vineet Choudhary
//  Copyright (c) Vineet Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (AppSetting)

@property(nonatomic,getter=isUserLoggedIn) BOOL userLoggedIn;
@property(nonatomic) NSDictionary *loggedInUserDetails;
@property(nonatomic,getter=authenticationToken) NSString *authenticationToken;
@property(nonatomic,readonly) NSString *authTokenForServerRequest;
@property(nonatomic,getter=deviceId) NSString *deviceId;
@property(nonatomic,getter=deviceToken) NSString *deviceToken;

-(void)clearUserDefault;
@end
