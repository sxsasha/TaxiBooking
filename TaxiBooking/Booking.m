//
//  BookingModel.m
//  TaxiBooking
//
//  Created by Tony Hrabovskyi on 5/9/17.
//  Copyright © 2017 Tony Hrabovskyi. All rights reserved.
//

#import "Utilities.h"
#import "BookingManager.h"
#import "Driver.h"
#import "Booking.h"


@interface Booking ()

@property (copy, nonatomic) CompletionBlock block;

@end

@implementation Booking

- (instancetype)initWithDictionary:(NSDictionary*)dictionary andDriver:(Driver*)driver {
    self = [super init];
    
    _driverID = driver.driverID;
    _bookingID = [[dictionary objectForKey:@"bookingId"] integerValue];
    _reference = [dictionary objectForKey:@"reference"];
    _pickupDateTime = [[Utilities shaderDateFormatter] dateFromString:[dictionary objectForKey:@"pickupDateTime"]];
    _category = [dictionary objectForKey:@"category"];
    _adultPax = [[dictionary objectForKey:@"adultPax"] integerValue];
    _childrenPax = [[dictionary objectForKey:@"childrenPax"] integerValue];
    _distanceKm = [[dictionary objectForKey:@"distanceKm"] floatValue];
    _distanceMiles = [[dictionary objectForKey:@"distanceMiles"] floatValue];
    _durationInSeconds = [[dictionary objectForKey:@"durationInSeconds"] integerValue];

    
    return self;
}

- (void)putAdditionData:(NSDictionary*)dictionary withError:(NSError*)error {
    
    _bookingID = [[dictionary objectForKey:@"bookingId"] integerValue];
    _reference = [dictionary objectForKey:@"reference"];
    _pickupDateTime = [[Utilities shaderDateFormatter] dateFromString:[dictionary objectForKey:@"pickupDateTime"]];
    _category = [dictionary objectForKey:@"category"];
    _adultPax = [[dictionary objectForKey:@"adultPax"] integerValue];
    _childrenPax = [[dictionary objectForKey:@"childrenPax"] integerValue];
    _distanceKm = [[dictionary objectForKey:@"distanceKm"] floatValue];
    _distanceMiles = [[dictionary objectForKey:@"distanceMiles"] floatValue];
    _durationInSeconds = [[dictionary objectForKey:@"durationInSeconds"] integerValue];
    
    _notes = [dictionary objectForKey:@"notes"];
    _currency = [dictionary objectForKey:@"currency"];
    _price = [[dictionary objectForKey:@"price"] floatValue];
    _flightInfo = [dictionary objectForKey:@"flightInfo"];
    _block(error);
    _block = nil;
}

- (void)loadingFullInfoWithBlock:(CompletionBlock)completionBlock {
    _block = completionBlock;
    [[BookingManager sharedManager] bookingLoading:self];
}

@end
