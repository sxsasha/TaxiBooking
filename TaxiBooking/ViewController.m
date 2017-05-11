//
//  ViewController.m
//  TaxiBooking
//
//  Created by Tony Hrabovskyi on 5/9/17.
//  Copyright © 2017 Tony Hrabovskyi. All rights reserved.
//

#import "ViewController.h"
#import "Driver.h"
#import "Utilities.h"
#import "Booking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    // test example
    
    Driver *driver = [[Driver alloc] initWithLogin:@"tia61@example.org" andPassword:@"secret"];
    [driver authorizeWithBlock:^(NSError *error) {
        if (error)
            NSLog(@"%@", error.localizedDescription);
        else
            NSLog(@"Authorized");
        
//        [driver logout];
        [Utilities loadImageFromURL:driver.photoURL andCompletionBlock:^(UIImage *image) {
            NSLog(@"photo loaded");
            NSLog(@"%@", image);
        }];
        
        //Booking *booking = [driver.bookingList firstObject];
        for (Booking *booking in driver.bookingList) {
            [booking loadingFullInfoWithBlock:^(NSError *error) {
                if (error) {
                    NSLog(@"Error: %@", error.localizedDescription);
                } else {
                    NSLog(@"Full info loaded, notes: %@", booking.notes);
                }
            }];
        }
    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
