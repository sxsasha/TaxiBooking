//
//  Driver.h
//  TaxiBooking
//
//  Created by Tony Hrabovskyi on 5/9/17.
//  Copyright © 2017 Tony Hrabovskyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Booking;

typedef enum : NSUInteger {
    MALEGENDER,
    FEMALEGENDER
} GENDER;

typedef void (^CompletionBlock)(NSError *error);

@interface Driver : NSObject

@property (assign, nonatomic, readonly) NSInteger   driverID;

@property (strong, nonatomic, readonly) NSString*   username;
@property (strong, nonatomic, readonly) NSString*   email;
@property (strong, nonatomic, readonly) NSString*   password;
@property (assign, nonatomic, readonly) BOOL        isAuthorized;

@property (strong, nonatomic, readonly) NSString*   firstName;
@property (strong, nonatomic, readonly) NSString*   lastName;
@property (assign, nonatomic, readonly) GENDER      gender;
@property (strong, nonatomic, readonly) NSString*   phoneNumber;
@property (strong, nonatomic, readonly) NSString*   photoURL;

@property (assign, nonatomic, readonly) NSInteger   supplierID;
@property (strong, nonatomic, readonly) NSString*   supplier;

@property (strong, nonatomic) NSArray<Booking *> *bookingList;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithLogin:(NSString*)login andPassword:(NSString*)password;
- (void)putAdditionalInfo:(NSDictionary*)dictionary;
- (void)authorizeWithBlock:(CompletionBlock)completionBlock;
- (void)logout;
                             
@end
