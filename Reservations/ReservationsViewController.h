//
//  ReservationsViewController.h
//  Reservations
//
//  Created by webstudent on 11/11/13.
//  Copyright (c) 2013 Jennifer Sexton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReservationsAppDelegate.h"

@interface ReservationsViewController : UIViewController
{
    NSMutableArray *listOfHotels;
}
@property (weak, nonatomic) IBOutlet UIPickerView *HotelPicker;
- (IBAction)btnView:(id)sender;

@end
