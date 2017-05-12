//
//  Customer.h
//  TaxiBooking
//
//  Created by Tony Hrabovskyi on 5/10/17.
//  Copyright © 2017 Tony Hrabovskyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Customer : NSObject

@property (strong, nonatomic, readonly) NSString*    title;
@property (strong, nonatomic, readonly) NSString*    firstName;
@property (strong, nonatomic, readonly) NSString*    lastName;
@property (strong, nonatomic, readonly) NSString*    phoneNumber;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

- (NSString *)fullName;
@end
