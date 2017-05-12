//
//  PointModel.h
//  TaxiBooking
//
//  Created by Tony Hrabovskyi on 5/10/17.
//  Copyright © 2017 Tony Hrabovskyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>

@interface PlacePoint : NSObject

@property (strong, nonatomic, readonly) NSString*               type;
@property (strong, nonatomic, readonly) NSString*               name;
@property (strong, nonatomic, readonly) NSString*               pointDescription;
@property (strong, nonatomic, readonly) NSString*               addressStreet1;
@property (strong, nonatomic, readonly) NSString*               addressStreet2;
@property (strong, nonatomic, readonly) NSString*               addressStreet3;
@property (strong, nonatomic, readonly) NSString*               addressStreet4;
@property (strong, nonatomic, readonly) NSString*               addressBuilding;
@property (strong, nonatomic, readonly) NSString*               addressFloor;
@property (strong, nonatomic, readonly) NSString*               addressZip;
@property (strong, nonatomic, readonly) NSString*               addressCity;
@property (strong, nonatomic, readonly) NSString*               addressDistrict;
@property (strong, nonatomic, readonly) NSString*               addressSubdistrict;
@property (strong, nonatomic, readonly) NSString*               addressRegion;
@property (strong, nonatomic, readonly) NSString*               addressState;
@property (strong, nonatomic, readonly) NSString*               addressCountryCode;
@property (assign, nonatomic, readonly) CLLocationCoordinate2D  location;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
- (void)putAdditionalInfo:(NSDictionary*)dictionary;
@end
