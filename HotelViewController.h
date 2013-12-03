//
//  HotelViewController.h
//  Reservations
//
//  Created by webstudent on 12/2/13.
//  Copyright (c) 2013 Jennifer Sexton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>
#import "ReservationsAppDelegate.h"

@interface HotelViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *hotelname;
@property (strong, nonatomic) IBOutlet UITextField *street;
@property (strong, nonatomic) IBOutlet UITextField *city;
@property (strong, nonatomic) IBOutlet UITextField *state;
@property (strong, nonatomic) IBOutlet UITextField *zip;
@property CLLocationCoordinate2D coordinates;

- (IBAction)getDirections:(id)sender;
- (void)showMap;
- (IBAction)hideKeyboard:(id)sender;
- (IBAction)btnBack:(id)sender;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)btnRestaurant:(id)sender;
- (IBAction)btnAtm:(id)sender;
@end
