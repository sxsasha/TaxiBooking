//
//  BookingModel.m
//  TaxiBooking
//
//  Created by Tony Hrabovskyi on 5/9/17.
//  Copyright © 2017 Tony Hrabovskyi. All rights reserved.
//

#import "Utilities.h"
#import "Booking.h"

@implementation Booking

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    self = [super init];
    
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

- (void)putAdditionData:(NSDictionary*)dictionary {
    
    _notes = [dictionary objectForKey:@"notes"];
    _currency = [dictionary objectForKey:@"currency"];
    _price = [[dictionary objectForKey:@"price"] floatValue];
    _flightInfo = [dictionary objectForKey:@"flightInfo"];
}

@end
