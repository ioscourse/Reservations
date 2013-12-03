//
//  ReservationsViewController.m
//  Reservations
//
//  Created by webstudent on 11/11/13.
//  Copyright (c) 2013 Jennifer Sexton. All rights reserved.
//

#import "ReservationsViewController.h"

@interface ReservationsViewController ()

@end

@implementation ReservationsViewController
@synthesize HotelPicker;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self LoadHotels];
}
- (void) LoadHotels
{
    
    listOfHotels = [[NSMutableArray alloc] init];
    
    // Add Month Titles.
    [listOfHotels addObject:@"Hampton Inn"];
    [listOfHotels addObject:@"Residence Inn"];
    if (FixedID==0)
    {
        FixedID=0;
        strHotel=[listOfHotels objectAtIndex:0];
    }
    
    
    [HotelPicker reloadAllComponents];
    [HotelPicker selectRow:FixedID inComponent:0 animated:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//PickerViewController.m
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}
//PickerViewController.m
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [listOfHotels count];
}
//PickerViewController.m
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [listOfHotels objectAtIndex:row];
}
//PickerViewController.m
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    strHotel=[listOfHotels objectAtIndex:row];
    FixedID=row;
}


- (IBAction)btnView:(id)sender {
}
@end
