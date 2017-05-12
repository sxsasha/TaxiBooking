//
//  Driver.m
//  TaxiBooking
//
//  Created by Tony Hrabovskyi on 5/9/17.
//  Copyright © 2017 Tony Hrabovskyi. All rights reserved.
//

#import "NSString+Extensions.h"
#import "BookingManager.h"
#import "Driver.h"

@interface Driver() <BookingDelegate>
@property (copy, nonatomic) CompletionBlock block;

@end

@implementation Driver

- (instancetype)initWithLogin:(NSString*)login andPassword:(NSString*)password {
    self = [super init];
    
    if ([login isMail]) {
        _email = login;
    } else {
        _username = login;
    }
    _password = password;
    
    return self;
}

- (void)authorizeWithBlock:(CompletionBlock)completionBlock {
    if (!_block) {
        _block = completionBlock;
        [[BookingManager sharedManager] driverLogin:self];
    }
}

- (void)putAdditionalInfo:(NSDictionary*)dictionary {
    _driverID = [[dictionary objectForKey:@"driverId"] integerValue];
    _email = [dictionary objectForKey:@"email"];
    _username = [dictionary objectForKey:@"username"];
    
    _firstName = [dictionary objectForKey:@"firstname"];
    _lastName = [dictionary objectForKey:@"lastname"];
    _phoneNumber = [dictionary objectForKey:@"phone1"];
    _photoURL = [dictionary objectForKey:@"photoUrl"];
    
    _supplier = [dictionary objectForKey:@"supplier"];
    _supplierID = [[dictionary objectForKey:@"supplierId"] integerValue];
    
    
    if ([[dictionary objectForKey:@"gender"] isEqualToString:@"F"]) {
        _gender = FEMALEGENDER;
    } else {
        _gender = MALEGENDER;
    }
}

- (void)logout {
    [[BookingManager sharedManager] driverLogout:self];
    _isAuthorized = FALSE;
}

#pragma mark BookingDelegate

- (void)loginCallback:(NSError *)error {
    if (_block == nil)
        return;
    
    _block(error);
    _block = nil;
}




@end
