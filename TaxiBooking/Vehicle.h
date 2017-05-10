//
//  VehicleModel.h
//  TaxiBooking
//
//  Created by Tony Hrabovskyi on 5/10/17.
//  Copyright © 2017 Tony Hrabovskyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vehicle : NSObject

@property (strong, nonatomic, readonly) NSString*   category;
@property (strong, nonatomic, readonly) NSString*   manufacturer;
@property (assign, nonatomic, readonly) NSInteger   model;
@property (assign, nonatomic, readonly) NSInteger   seats;
@property (assign, nonatomic, readonly) NSInteger   luggageBig;
@property (assign, nonatomic, readonly) NSInteger   luggageSmall;
@property (assign, nonatomic, readonly) NSInteger   year;
@property (strong, nonatomic, readonly) NSString*   color;
@property (strong, nonatomic, readonly) NSString*   carRegistration;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
@end
