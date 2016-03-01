//
//  LocationPickerViewController.h
//
//  Created by Vineet Choudhary
//  Copyright (c) Vineet Choudhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BSForwardGeocoder.h"
#import "BSKmlResult.h"

@class LocationPickerViewController;
@protocol LocationPickerDelegate <NSObject>

-(void)locationPicker:(LocationPickerViewController *)sender andLocation:(CLLocation *)location andAddress:(NSString *)address andCity:(NSString *)city;

@end

@interface LocationPickerViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,UISearchBarDelegate, UITableViewDataSource,UITableViewDelegate,BSForwardGeocoderDelegate,UIAlertViewDelegate,UINavigationControllerCustomDelegate>{
    IBOutlet MKMapView *mapView;
    IBOutlet UISearchBar *searchBar;
    IBOutlet UIView *activityLayerView;
    IBOutlet UIButton *buttonUserLocation;
}
@property(nonatomic,weak) id<LocationPickerDelegate> delegate;
@property(nonatomic,strong) CLLocation *savedLocation;
- (IBAction)buttonCurrentLocation:(UIButton *)sender;

@end
