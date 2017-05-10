//
//  BookingModel.h
//  TaxiBooking
//
//  Created by Tony Hrabovskyi on 5/9/17.
//  Copyright © 2017 Tony Hrabovskyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Vehicle, Customer, PlacePoint;

@interface Booking : NSObject

@property (assign, nonatomic, readonly) NSInteger     bookingID;
@property (strong, nonatomic, readonly) NSString*     reference;
@property (strong, nonatomic, readonly) NSDate*       pickupDateTime;
@property (strong, nonatomic, readonly) NSString*     category;
@property (strong, nonatomic, readonly) NSString*     notes;
@property (strong, nonatomic, readonly) NSString*     currency;
@property (assign, nonatomic, readonly) Float32       price;
@property (assign, nonatomic, readonly) NSUInteger    adultPax;
@property (assign, nonatomic, readonly) NSUInteger    childrenPax;
@property (assign, nonatomic, readonly) Float32       distanceKm;
@property (assign, nonatomic, readonly) Float32       distanceMiles;
@property (assign, nonatomic, readonly) NSUInteger    durationInSeconds;
@property (strong, nonatomic, readonly) NSString*     flightInfo;

@property (strong, nonatomic) Vehicle*      vehicle;
@property (strong, nonatomic) Customer*     customer;
@property (strong, nonatomic) PlacePoint*   pickupPoint;
@property (strong, nonatomic) PlacePoint*   dropoffPoint;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
