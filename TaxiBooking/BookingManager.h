//
//  BookingManager.h
//  TaxiBooking
//
//  Created by Tony Hrabovskyi on 5/9/17.
//  Copyright © 2017 Tony Hrabovskyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Driver, Booking;

@protocol BookingDelegate <NSObject>

- (void)loginCallback:(NSError*)error;

@end

@interface BookingManager : NSObject

+ (BookingManager*)sharedManager;

- (void)driverLogin:(Driver*)driver;
- (void)driverLogout:(Driver*)driver;
- (void)bookingLoading:(Booking*)booking;
@end
