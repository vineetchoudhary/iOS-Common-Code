//
//  LocationPickerViewController.m
//
//  Created by Vineet Choudhary
//  Copyright (c) Vineet Choudhary. All rights reserved.
//

#import "LocationPickerViewController.h"
#import "CustomPlacemark.h"

NSString *const defaultLocationNotificationText = @"Getting address...";

@interface LocationPickerViewController ()

@end

@implementation LocationPickerViewController{
    UITableViewController *searchTVC;
    NSMutableArray *searchResponseItems;
    BSForwardGeocoder *forwardGeocoder;
    CLGeocoder *geoCoder;
    id<MKAnnotation> selectedAnnotation;
    __block NSString *currentLocationAddress;
    NSString *city;
    BOOL isSuggestion;
    BOOL isRequstToHomeLocation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUISettings];
    [self setValue];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadUISettings{
    if([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self.navigationController setupNavigationBarWithNavigationItem:self.navigationItem andTitle:@"Select Location" andLeftBarItemTyep:LeftBarItemBack andRightBarItemType:RightBarItemText andRightBarTitle:@"Done" andRightBarImages:nil];
    activityLayerView.hidden = YES;
}

-(void)setValue{
    [self.navigationController setCustomDelegate:self];
    geoCoder = [[CLGeocoder alloc] init];
    isRequstToHomeLocation = YES;
    //map view
    [mapView setShowsUserLocation: YES];
    [mapView setDelegate: self];
    [mapView addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)]];
    
    //sugestive search table
    searchTVC = [[UITableViewController alloc] init];
    searchResponseItems = [NSMutableArray array];
    [searchTVC.tableView setDataSource: self];
    [searchTVC.tableView setDelegate: self];
    [searchBar setDelegate: self];
    [searchTVC.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    if (_savedLocation) {
        [self addAnnotationLocationCoordinate:_savedLocation.coordinate withTitle:nil];
        [mapView setRegion:MKCoordinateRegionMake(_savedLocation.coordinate, MKCoordinateSpanMake(0.08, 0.08)) animated:YES];
    }
}

#pragma mark - Gesture recongnizer

-(void)longPressGesture:(UILongPressGestureRecognizer *)longPressGesture{
    if (longPressGesture.state == UIGestureRecognizerStateRecognized) {
        [mapView removeAnnotations:mapView.annotations];
        CGPoint touchPoint = [longPressGesture locationInView:mapView];
        CLLocationCoordinate2D touchMapCoordinate = [mapView convertPoint:touchPoint toCoordinateFromView:mapView];
        [self addAnnotationLocationCoordinate:touchMapCoordinate withTitle:nil];
    }
}

-(void)addAnnotationLocationCoordinate:(CLLocationCoordinate2D )locationCoordinate withTitle:(NSString *)title{
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = locationCoordinate;
    annotation.title = (title.length > 0)?title:defaultLocationNotificationText;
    [mapView addAnnotation:annotation];
    [mapView selectAnnotation:annotation animated:YES];
    (title.length == 0)?[self updateAnnotationAddress]:nil;
}

-(void)updateAnnotationAddress{
    [mapView.annotations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[MKPointAnnotation class]]) {
            MKPointAnnotation *annotation = (MKPointAnnotation *)obj;
            CLLocation *location = [[CLLocation alloc] initWithLatitude:selectedAnnotation.coordinate.latitude longitude:selectedAnnotation.coordinate.longitude];
            [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
                if (placemarks.count > 0) {
                    CLPlacemark *placeMark = placemarks.firstObject;
                    annotation.title = [CommonFunction buildAddressFromPlaceMark:placeMark];
                    city = [CommonFunction buildPlacemarkCity:placeMark];
//                    [searchBar setText:annotation.title];
                }
            }];
        }
    }];
}


#pragma mark - Alert view delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Map Kit Delegate

-(MKAnnotationView *)mapView:(MKMapView *)mapViewLocal viewForAnnotation:(id<MKAnnotation>)annotation{
    selectedAnnotation = annotation;
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        CLLocation *location = [[CLLocation alloc] initWithLatitude:selectedAnnotation.coordinate.latitude longitude:selectedAnnotation.coordinate.longitude];
        [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            if (placemarks.count > 0) {
                CLPlacemark *placeMark = placemarks.firstObject;
                currentLocationAddress = [CommonFunction buildAddressFromPlaceMark:placeMark];
                city = [CommonFunction buildPlacemarkCity:placeMark];
            }
        }];
        return nil;
    }
    MKPinAnnotationView *pinAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
    currentLocationAddress = annotation.title;
    [pinAnnotation setCanShowCallout:YES];
    [pinAnnotation setDraggable:YES];
    return pinAnnotation;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState{
    if (newState == MKAnnotationViewDragStateEnding) {
        [self updateAnnotationAddress];
    }
}

-(void)mapView:(MKMapView *)mapViewLocal didUpdateUserLocation:(MKUserLocation *)userLocation{
    [buttonUserLocation setEnabled:YES];
    if (_savedLocation==nil && isRequstToHomeLocation) {
        isRequstToHomeLocation = NO;
        [mapView setRegion:MKCoordinateRegionMake(mapView.userLocation.coordinate, MKCoordinateSpanMake(0.08, 0.08)) animated:YES];
    }
}

-(void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    if ([searchBar isFirstResponder]) {
        [searchBar resignFirstResponder];
    }
    [searchTVC removeFromParentViewController];
    [searchTVC.tableView removeFromSuperview];
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    selectedAnnotation = view.annotation;
}


#pragma mark - Search bar delegate method

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBarLocal{
    [searchTVC removeFromParentViewController];
    [searchTVC.tableView removeFromSuperview];
    [searchBar resignFirstResponder];
    searchBar.text = nil;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBarLocal{
    [searchTVC removeFromParentViewController];
    [searchTVC.tableView removeFromSuperview];
    [searchBar resignFirstResponder];
    activityLayerView.hidden = NO;
    if (forwardGeocoder == nil) {
        forwardGeocoder = [[BSForwardGeocoder alloc] initWithDelegate:self];
    }
    isSuggestion = NO;
    [forwardGeocoder findLocation:searchBar.text];
}

-(void)searchBar:(UISearchBar *)searchBarLocal textDidChange:(NSString *)searchText
{
    //search
    if([searchText isEqualToString:@""]){
        [searchTVC removeFromParentViewController];
        [searchTVC.tableView removeFromSuperview];
        searchBarLocal.text = @"";
    }else{
        isSuggestion = YES;
        MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
        request.naturalLanguageQuery = searchText;
        
        MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:request];
        
        [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
            if (response.mapItems.count > 0){
                BOOL isOldItemDeleted = NO;
                for (MKMapItem *mapItem in response.mapItems) {
                    if (!isOldItemDeleted) {
                        [searchResponseItems removeAllObjects];
                        isOldItemDeleted = YES;
                    }
                    [searchResponseItems addObject:mapItem];
                }
                if(![self.view.subviews containsObject:searchTVC.tableView]){
                    [self addChildViewController:searchTVC];
                    [self.view addSubview:searchTVC.tableView];
                }
                [searchTVC.tableView reloadData];
            }
            if (searchResponseItems.count == 0){
                [searchTVC removeFromParentViewController];
                [searchTVC.tableView removeFromSuperview];
            }
        }];
    }
}


#pragma mark - Forward Geocoding delegate method

-(void)forwardGeocoderError:(BSForwardGeocoder *)geocoder errorMessage:(NSString *)errorMessage{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

-(void)forwardGeocoderFoundLocation:(BSForwardGeocoder *)geocoder{
    BOOL found = NO;
    [mapView removeAnnotations:mapView.annotations];
    if(forwardGeocoder.status == G_GEO_SUCCESS)
    {
        NSInteger searchResults = forwardGeocoder.results.count;
        
        // Add placemarks for each result
        for(int i = 0; i < searchResults; i++)
        {
            BSKmlResult *place = [forwardGeocoder.results objectAtIndex:i];
            CustomPlacemark *placemark = [[CustomPlacemark alloc] initWithRegion:place.coordinateRegion];
            placemark.title = place.address;
            placemark.subtitle = place.countryName;
            if (isSuggestion == NO) {
                MKCoordinateRegion region = MKCoordinateRegionMake(placemark.coordinate, MKCoordinateSpanMake(0.1, 0.1));
                [mapView setRegion:region animated:TRUE];
                [self addAnnotationLocationCoordinate:placemark.coordinate withTitle:placemark.title];
                city = place.address;
                found = YES;
                break;
            }
            NSArray *countryName = [place findAddressComponent:@"country"];
            if([countryName count] > 0)
            {
                DebugLog(@"Country: %@", ((BSAddressComponent*)[countryName objectAtIndex:0]).longName );
            }
            
        }
        if(!found)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Could not find" delegate:nil cancelButtonTitle:@"OK"  otherButtonTitles: nil];
            [alert show];
        }
    }
    else {
        NSString *message = @"";
        
        switch (forwardGeocoder.status) {
            case G_GEO_BAD_KEY:
                message = @"The API key is invalid.";
                break;
                
            case G_GEO_UNKNOWN_ADDRESS:
                message = [NSString stringWithFormat:@"Could not find %@", forwardGeocoder.searchQuery];
                break;
                
            case G_GEO_TOO_MANY_QUERIES:
                message = @"Too many queries has been made for this API key.";
                break;
                
            case G_GEO_SERVER_ERROR:
                message = @"Server error, please try again.";
                break;
                
                
            default:
                break;
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Information" message:message delegate:nil cancelButtonTitle:@"OK"  otherButtonTitles: nil];
        [alert show];
    }
    activityLayerView.hidden = YES;
}


#pragma mark - Table view datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (searchResponseItems.count > 0) {
        NSInteger tableHeight = (searchResponseItems.count > 4)?200:44 * searchResponseItems.count;
        searchTVC.tableView.frame = CGRectMake(mapView.frame.origin.x, mapView.frame.origin.y, searchTVC.tableView.frame.size.width, tableHeight);
    }else if (searchResponseItems.count == 0){
        
    }
    return searchResponseItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = ((MKMapItem *)[searchResponseItems objectAtIndex:indexPath.row]).name;
//    cell.textLabel.text = [CommonFunction buildAddressFromPlaceMark:((MKMapItem *)[searchResponseItems objectAtIndex:indexPath.row]).placemark];
    return cell;
}


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (searchResponseItems.count > 0) {
        [mapView removeAnnotations:mapView.annotations];
        MKMapItem *selectedResult = [searchResponseItems objectAtIndex:indexPath.row];
        [searchTVC removeFromParentViewController];
        [searchTVC.tableView removeFromSuperview];
        [searchBar resignFirstResponder];
        searchBar.text = selectedResult.name;
        CLLocationCoordinate2D selectedResultCoordinate = selectedResult.placemark.coordinate;
        MKCoordinateRegion region = MKCoordinateRegionMake(selectedResultCoordinate, MKCoordinateSpanMake(0.1, 0.1));
        [mapView setRegion:region animated:TRUE];
        CustomPlacemark *placemark = [[CustomPlacemark alloc] initWithRegion:region];
        [self addAnnotationLocationCoordinate:placemark.coordinate withTitle:defaultLocationNotificationText];
        [self updateAnnotationAddress];
    }
}

#pragma mark - Navigation Controller Custom Delegate

-(void)navigationBarButtonItemTappedWithId:(NavigationBarButtonId)navigationBarButtonId{
    if (navigationBarButtonId == NavigationBarTextButtonId) {
        if (![DataValidation isEmptyString:city]) {
            if (selectedAnnotation) {
                CLLocation *location = [[CLLocation alloc] initWithLatitude:selectedAnnotation.coordinate.latitude longitude:selectedAnnotation.coordinate.longitude];
                [self.delegate locationPicker:self andLocation:location andAddress:([selectedAnnotation isKindOfClass:[MKUserLocation class]])?currentLocationAddress:selectedAnnotation.title andCity:city];
            }else{
                
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [UIAlertView showSimpleAlertViewWithTitle:@"Please wait.Getting address..." andMessage:nil andCancelButtonTitle:akAlertViewCancelButtonTitle];
        }
    }
}

- (IBAction)buttonCurrentLocation:(UIButton *)sender {
    [mapView setRegion:MKCoordinateRegionMake(mapView.userLocation.coordinate, MKCoordinateSpanMake(0.08, 0.08)) animated:YES];
}
@end
