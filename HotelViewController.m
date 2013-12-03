//
//  HotelViewController.m
//  Reservations
//
//  Created by webstudent on 12/2/13.
//  Copyright (c) 2013 Jennifer Sexton. All rights reserved.
//

#import "HotelViewController.h"
#define METERS_PER_MILE 1609.344

@interface HotelViewController ()

@end

@implementation HotelViewController

@synthesize hotelname, street, city, state, zip, mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    if (FixedID==0)
    {
        hotelname.Text = @"Hampton Inn";
        street.text=@"615 Clark Dr";
        city.text=@"Rockford";
        state.text=@"IL";
        zip.text = @"61107";
    }
    else{
        hotelname.Text = @"Residence Inn";
        street.text=@"7542 Colosseum Dr";
        city.text=@"Rockford";
        state.text=@"IL";
        zip.text = @"61107";
    }
    [self LoadHotel];
}
-(void)dismissKeyboard {
    [hotelname resignFirstResponder];
    [street resignFirstResponder];
    [city resignFirstResponder];
    [state resignFirstResponder];
    [zip resignFirstResponder];
}
- (IBAction)hideKeyboard:(id)sender {
    [hotelname resignFirstResponder];
    [street resignFirstResponder];
    [city resignFirstResponder];
    [state resignFirstResponder];
    [zip resignFirstResponder];
}
- (void)LoadHotel
{
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    
    NSString *addressString = [NSString stringWithFormat:@"%@ %@ %@ %@",
                               street.text,
                               city.text,
                               state.text,
                               zip.text];
    
    [geocoder geocodeAddressString:addressString
                 completionHandler:^(NSArray *placemarks, NSError *error) {
                     
                     if (error) {
                         NSLog(@"Geocode failed with error: %@", error);
                         return;
                     }
                     
                     if (placemarks && placemarks.count > 0)
                     {
                         CLPlacemark *placemark = placemarks[0];
                         
                         CLLocation *location = placemark.location;
                         _coordinates = location.coordinate;
                         _coordinates = location.coordinate;
                         
                         [self showHotel];
                     }
                 }];
    [self dismissKeyboard];
}
- (void)showHotel{
    NSDictionary *address = @{
                              (NSString *)kABPersonAddressStreetKey: street.text,
                              (NSString *)kABPersonAddressCityKey: city.text,
                              (NSString *)kABPersonAddressStateKey: state.text,
                              (NSString *)kABPersonAddressZIPKey: zip.text
                              };
    
    MKPlacemark *place = [[MKPlacemark alloc]
                          initWithCoordinate:_coordinates
                          addressDictionary:address];
    
    MKMapItem *mapItem = [[MKMapItem alloc]initWithPlacemark:place];
    
    NSDictionary *options = @{
                              MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving
                              };
    // [mapItem openInMapsWithLaunchOptions:options];
    //[mapItem openInMapsWithLaunchOptions:nil];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(_coordinates, 1*METERS_PER_MILE, 1*METERS_PER_MILE);
    
    [mapView setRegion:viewRegion animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getDirections:(id)sender {
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    
    NSString *addressString = [NSString stringWithFormat:@"%@ %@ %@ %@",
                               street.text,
                               city.text,
                               state.text,
                               zip.text];
    
    [geocoder geocodeAddressString:addressString
                 completionHandler:^(NSArray *placemarks, NSError *error) {
                     
                     if (error) {
                         NSLog(@"Geocode failed with error: %@", error);
                         return;
                     }
                     
                     if (placemarks && placemarks.count > 0)
                     {
                         CLPlacemark *placemark = placemarks[0];
                         
                         CLLocation *location = placemark.location;
                         _coordinates = location.coordinate;
                         _coordinates = location.coordinate;
                         
                         [self showMap];
                     }
                 }];
    [self dismissKeyboard];
}

- (IBAction)btnBack:(id)sender {
}

- (IBAction)btnRestaurant:(id)sender {
    [self.mapView removeAnnotations:self.mapView.annotations];
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = @"restaurants";
    MKCoordinateSpan span = MKCoordinateSpanMake(.1, .1);
    request.region = MKCoordinateRegionMake(_coordinates, span);
    MKLocalSearch *search =
    [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:
     ^(MKLocalSearchResponse *response, NSError *error) {
         // Handle results
         int i = 0;
         do {
             MKMapItem *mapItem = [response.mapItems objectAtIndex:i];
             MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
             myAnnotation.coordinate = mapItem.placemark.coordinate;
             myAnnotation.title = mapItem.name;
             myAnnotation.subtitle = mapItem.placemark.title;
             [self.mapView addAnnotation:myAnnotation];
             i++;
         } while (i < response.mapItems.count);
     }];
    [mapView setRegion:request.region animated:YES];
}

- (IBAction)btnAtm:(id)sender {
    [self.mapView removeAnnotations:self.mapView.annotations];
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = @"atm";
    MKCoordinateSpan span = MKCoordinateSpanMake(.1, .1);
    request.region = MKCoordinateRegionMake(_coordinates, span);
    MKLocalSearch *search =
    [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:
     ^(MKLocalSearchResponse *response, NSError *error) {
         // Handle results
         int i = 0;
         do {
             MKMapItem *mapItem = [response.mapItems objectAtIndex:i];
             MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
             myAnnotation.coordinate = mapItem.placemark.coordinate;
             myAnnotation.title = mapItem.name;
             myAnnotation.subtitle = mapItem.placemark.title;
             [self.mapView addAnnotation:myAnnotation];
             i++;
         } while (i < response.mapItems.count);
     }];
    [mapView setRegion:request.region animated:YES];
}
- (void)showMap{
    NSDictionary *address = @{
                              (NSString *)kABPersonAddressStreetKey: street.text,
                              (NSString *)kABPersonAddressCityKey: city.text,
                              (NSString *)kABPersonAddressStateKey: state.text,
                              (NSString *)kABPersonAddressZIPKey: zip.text
                              };
    
    MKPlacemark *place = [[MKPlacemark alloc]
                          initWithCoordinate:_coordinates
                          addressDictionary:address];
    
    MKMapItem *mapItem = [[MKMapItem alloc]initWithPlacemark:place];
    
    NSDictionary *options = @{
                              MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving
                              };
    [mapItem openInMapsWithLaunchOptions:options];
    //[mapItem openInMapsWithLaunchOptions:nil];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(_coordinates, 1*METERS_PER_MILE, 1*METERS_PER_MILE);
    
    [mapView setRegion:viewRegion animated:YES];
}

@end
