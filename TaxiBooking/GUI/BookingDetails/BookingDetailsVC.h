//
//  BookingDetailsVC.h
//  TaxiBooking
//
//  Created by sxsasha on 5/9/17.
//  Copyright © 2017 Tony Hrabovskyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Booking;

@interface BookingDetailsVC : UIViewController

+ (BookingDetailsVC *)getFromStoryboard;
- (void)setupBooking:(Booking *)booking;
@end
