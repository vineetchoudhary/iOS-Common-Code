//
//  AppDelegate.m
//
//  Created by Vineet Choudhary on 01/03/16.
//  Copyright © Vineet Choudhary. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setupMainApplicationLaunchActivity];
    [self setupOtherApplicationLaunchActivity];
    
    //handle push notification lanuch
    if([launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey]){
        DebugLog(@"Application Push Notification StartUp%@",[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey]);
        [self pushNotificationHandlerWithInfo:[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey] withLaunchApplication:YES];
    }
    
    return YES;
}

#pragma mark - Application Launch Activity

-(void)setupMainApplicationLaunchActivity{
    //setup netowrk handler
    [[NetworkHandler networkHandler] setShowNetworkErrorMessage:DEBUG];
    
    //setup front view controller
    id frontViewController;
    if ([NSUserDefaults standardUserDefaults].isUserLoggedIn) {
        //frontViewController =
    }else{
        //frontViewController =
    }
    
    //setup hamburger view controller
    HamburgerViewController *hamburgerViewController = [[HamburgerViewController alloc] initWithNibName:NSStringFromClass([HamburgerViewController class]) bundle:nil];
    
    //setup navigation controller
    _navigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    [_navigationController setupNavigationBarView];
    
    //setup reveal view controller
    _revealViewController = [[SWRevealViewController alloc] init];
    [_revealViewController setRearViewRevealOverdraw:0];
    [_revealViewController setFrontViewController:_navigationController];
    [_navigationController setDrawerFrontViewController:frontViewController andDrawerRearViewController:hamburgerViewController andAnimated:NO];
    
    //setup window
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_window setRootViewController:_revealViewController];
    [_window makeKeyAndVisible];
}

-(void)setupOtherApplicationLaunchActivity{
    //setup fabric crashlytics
    [Fabric with:@[[Crashlytics class]]];
    
    //register for push notification
    UIUserNotificationSettings *notificationSetting = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound) categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSetting];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    //setup location manager
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [_locationManager setDistanceFilter:kCLDistanceFilterNone];
    [_locationManager setDelegate:self];
    if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_locationManager requestWhenInUseAuthorization];
    }
    [_locationManager startMonitoringSignificantLocationChanges];
    [_locationManager startUpdatingLocation];
}

#pragma mark - Push Notification Handler
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString *deviceTokenString = deviceToken.description;
    deviceTokenString = [deviceTokenString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    deviceTokenString = [deviceTokenString stringByReplacingOccurrencesOfString:@" " withString:@""];
    DebugLog(@"Push Notification - Device Token : %@",deviceTokenString);
    
    if ([NSUserDefaults standardUserDefaults].deviceToken.length == 0 || ![deviceTokenString isEqualToString:[NSUserDefaults standardUserDefaults].deviceToken]) {
        [[NSUserDefaults standardUserDefaults] setDeviceToken:deviceTokenString];
    }
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    DebugLog(@"Push Notification - ERROR : %@",error);
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    DebugLog(@"Receive Local Notification - : %@",notification.userInfo);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    DebugLog(@"Receive Remote Notification - %@",userInfo);
    [self pushNotificationHandlerWithInfo:userInfo withLaunchApplication:NO];
}

-(void)pushNotificationHandlerWithInfo:(NSDictionary *)info withLaunchApplication:(BOOL)isAppLaunch{
    APNS *apns = [[APNS alloc] initWithServerResponse:info];
    if (isAppLaunch) {
        
    }else{
        [UIView showToastWithMessage:apns.message WithCompletion:nil];
    }
}

#pragma mark - CLLocationManager Delegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    _currentLocation = locations.lastObject.copy;
}

#pragma mark - AppDelegate properties getter
+(AppDelegate *)appDelegate{
    return ((AppDelegate *)[UIApplication sharedApplication].delegate);
}

@end
