//
//  Customer.m
//  TaxiBooking
//
//  Created by Tony Hrabovskyi on 5/10/17.
//  Copyright © 2017 Tony Hrabovskyi. All rights reserved.
//

#import "Customer.h"

@implementation Customer

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    self = [super init];
    
    _title = [dictionary objectForKey:@"title"];
    _firstName = [dictionary objectForKey:@"firstname"];
    _lastName = [dictionary objectForKey:@"lastname"];
    _phoneNumber = [dictionary objectForKey:@"phone1"];
    
    return self;
}

@end
