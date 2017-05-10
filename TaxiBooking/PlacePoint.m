//
//  PointModel.m
//  TaxiBooking
//
//  Created by Tony Hrabovskyi on 5/10/17.
//  Copyright © 2017 Tony Hrabovskyi. All rights reserved.
//

#import "PlacePoint.h"

@implementation PlacePoint

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    self = [super init];
    
    _type = [dictionary objectForKey:@"type"];
    _name = [dictionary objectForKey:@"name"];
    _addressCity = [dictionary objectForKey:@"addressCity"];

    return self;
}

- (void)putAdditionalInfo:(NSDictionary*)dictionary {
    
    _type = [dictionary objectForKey:@"type"];
    _name = [dictionary objectForKey:@"name"];
    _pointDescription = [dictionary objectForKey:@"description"];
    _addressStreet1 = [dictionary objectForKey:@"addressStreet1"];
    _addressStreet2 = [dictionary objectForKey:@"addressStreet2"];
    _addressStreet3 = [dictionary objectForKey:@"addressStreet3"];
    _addressStreet4 = [dictionary objectForKey:@"addressStreet4"];
    _addressBuilding = [dictionary objectForKey:@"addressBuilding"];
    _addressFloor = [dictionary objectForKey:@"addressFloor"];
    _addressZip = [dictionary objectForKey:@"addressZip"];
    _addressCity = [dictionary objectForKey:@"addressCity"];
    _addressDistrict = [dictionary objectForKey:@"addressDistrict"];
    _addressSubdistrict = [dictionary objectForKey:@"addressSubdistrict"];
    _addressRegion = [dictionary objectForKey:@"addressRegion"];
    _addressState = [dictionary objectForKey:@"addressState"];
    _addressCountryCode = [dictionary objectForKey:@"addressCountryCode"];
    _location = CLLocationCoordinate2DMake([[dictionary objectForKey:@"addressLatitude"] floatValue], [[dictionary objectForKey:@"addressLongitude"] floatValue]);

    
}


@end
