//
//  NSUserDefaults+AppSetting.m
//
//  Created by Vineet Choudhary
//  Copyright (c) Vineet Choudhary. All rights reserved.
//

#import "NSUserDefaults+AppSetting.h"

//Default Storage
NSString *const UserLoggedInKey = @"user_logged_in";
NSString *const UserLoggedInAccount = @"user_logged_in_account";
NSString *const LoggedInUserDetailsKey = @"logged_in_user_details";
NSString *const UserAuthenticationToken = @"user_authentication_token";


NSString *const DeviceTokenKey = @"device_token";
NSString *const DeviceIdkey = @"device_id";

@implementation NSUserDefaults (AppSetting)

-(BOOL)isUserLoggedIn{
    return [self boolForKey:UserLoggedInKey];
}

-(void)setUserLoggedIn:(BOOL)userLogedIn{
    [self setBool:userLogedIn forKey:UserLoggedInKey];
    [self synchronize];
}

-(NSDictionary *)loggedInUserDetails{
    NSData *userData = [NSData dataWithData:[self dataForKey:LoggedInUserDetailsKey]];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:userData];
    NSDictionary *userDataDictionary = [unarchiver decodeObjectForKey:LoggedInUserDetailsKey];
    [unarchiver finishDecoding];
    return userDataDictionary;
}

-(void)setLoggedInUserDetails:(NSDictionary *)loggedInUserDetails{
    NSMutableData *userData = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:userData];
    [archiver encodeObject:loggedInUserDetails forKey:LoggedInUserDetailsKey];
    [archiver finishEncoding];
    [self setObject:userData forKey:LoggedInUserDetailsKey];
    [self synchronize];
}

-(NSString *)authTokenForServerRequest{
    return [self stringForKey:UserAuthenticationToken];
//    return [NSString stringWithFormat:@"Token %@",[self stringForKey:UserAuthenticationToken]];
}

-(NSString *)authenticationToken{
    return [self stringForKey:UserAuthenticationToken];
}

-(void)setAuthenticationToken:(NSString *)authenticationToken{
    [self setObject:authenticationToken forKey:UserAuthenticationToken];
}

-(void)clearUserDefault{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [self removePersistentDomainForName:appDomain];
    [NSUserDefaults resetStandardUserDefaults];
}

#pragma mark - APNS Storage
-(NSString *)deviceToken{
    return [self stringForKey:DeviceTokenKey];
}
-(void)setDeviceToken:(NSString *)token{
    [self setObject:token forKey:DeviceTokenKey];
}
-(NSString *)deviceId{
    return [self stringForKey:DeviceIdkey];
}
-(void)setDeviceId:(NSString *)token{
    [self setObject:token forKey:DeviceIdkey];
}

@end
