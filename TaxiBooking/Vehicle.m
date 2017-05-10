//
//  VehicleModel.m
//  TaxiBooking
//
//  Created by Tony Hrabovskyi on 5/10/17.
//  Copyright © 2017 Tony Hrabovskyi. All rights reserved.
//

#import "Vehicle.h"

@implementation Vehicle

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    self = [super init];
    
    _category = [dictionary objectForKey:@"category"];
    _manufacturer = [dictionary objectForKey:@"manufacturer"];
    _model = [[dictionary objectForKey:@"model"] integerValue];
    _color = [dictionary objectForKey:@"color"];
    _carRegistration = [dictionary objectForKey:@"carRegistration"];
    
    return self;
}

- (void)putAdditionalInfo:(NSDictionary*)dictionary {
    
    _seats = [[dictionary objectForKey:@"seats"] integerValue];
    _luggageBig = [[dictionary objectForKey:@"luggageBig"] integerValue];
    _luggageSmall = [[dictionary objectForKey:@"luggageSmall"] integerValue];
    _year = [[dictionary objectForKey:@"year"] integerValue];
}

@end
