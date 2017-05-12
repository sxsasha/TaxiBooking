//
//  BookingManager.m
//  TaxiBooking
//
//  Created by Tony Hrabovskyi on 5/9/17.
//  Copyright © 2017 Tony Hrabovskyi. All rights reserved.
//

#import "Vehicle.h"
#import "Customer.h"
#import "PlacePoint.h"
#import "Booking.h"
#import "Driver.h"
#import "BookingManager.h"

@implementation BookingManager

static NSString *apiToken = @"32v7a8ojRSkLfwySlgCB5Zo5KckpopjpOH63qlqpqRv6F9hWGjlZUDZTzOIK";
static BookingManager* instance;

+ (BookingManager*)sharedManager {
    if (instance == nil)
        instance = [[BookingManager alloc] init];
    
    return instance;
}

- (void)driverLogin:(Driver<BookingDelegate> *)driver {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://backseatz.com/api/driverapp/driver-login"]];
    NSString *postDataString;
    if (driver.email)
        postDataString = [NSString stringWithFormat:@"email=%@&password=%@&deviceOs=IOS&apnToken=%@&api_token=%@",
                          driver.email, driver.password, @"none", apiToken];
    else
        postDataString = [NSString stringWithFormat:@"username=%@&password=%@&deviceOs=IOS&apnToken=%@&api_token=%@",
                          driver.username, driver.password, @"none", apiToken];
    
    request.HTTPBody = [postDataString dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            
            NSDictionary *answer = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//            NSLog(@"%@", answer);
            
            NSInteger code = [[[answer objectForKey:@"response"] objectForKey:@"code"] integerValue];
            if (code == 1) {
                NSDictionary *driverInfo = [answer objectForKey:@"driver"];
                [driver putAdditionalInfo:driverInfo];
                
                NSMutableArray<Booking *> *bookingList = [NSMutableArray array];
                
                NSArray<NSDictionary*> *bookingInfo = [answer objectForKey:@"bookings"];
                for (NSDictionary *dict in bookingInfo) {
                    Booking *booking = [[Booking alloc] initWithDictionary:[dict objectForKey:@"booking"] andDriver:driver];
                    
                    booking.vehicle = [[Vehicle alloc] initWithDictionary: [dict objectForKey:@"vehicle"]];
                    booking.customer = [[Customer alloc] initWithDictionary:[dict objectForKey:@"customer"]];
                    booking.pickupPoint = [[PlacePoint alloc] initWithDictionary:[dict objectForKey:@"pickupPoint"]];
                    booking.dropoffPoint = [[PlacePoint alloc] initWithDictionary:[dict objectForKey:@"dropoffPoint"]];
                    
                    [bookingList addObject:booking];
                }
            
                driver.bookingList = [bookingList copy];
            } else
                error = [NSError errorWithDomain:@"Unknown Users" code:0 userInfo:@{NSLocalizedDescriptionKey:@"Error with login. Check login and password."}];
        } else
            error = [NSError errorWithDomain:@"No Internet Connection" code:400 userInfo:@{NSLocalizedDescriptionKey:@"Check your Internet connection."}];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [driver loginCallback:error];
        });
    }] resume];
}

- (void)driverLogout:(Driver<BookingDelegate> *)driver {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://backseatz.com/api/driverapp/driver-logout"]];
    NSString *postDataString = [NSString stringWithFormat:@"driverId=%ld&username=%@&apnToken=%@&api_token=%@",
                                (long)driver.driverID, driver.username, @"none", apiToken];
    
    request.HTTPBody = [postDataString dataUsingEncoding:NSUTF8StringEncoding];;
    request.HTTPMethod = @"POST";
    
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            
            NSDictionary *answer = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"%@", answer);
            
            NSInteger code = [[[answer objectForKey:@"response"] objectForKey:@"code"] integerValue];
            if (code == 1) {
                
            } else { // error
                
            }
        }
    }] resume];
}

- (void)bookingLoading:(Booking*)booking {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://backseatz.com/api/driverapp/booking-details"]];
    NSString *postDataString = [NSString stringWithFormat:@"driverId=%li&bookingId=%li&api_token=%@", (long)booking.driverID, (long)booking.bookingID, apiToken];
    
    request.HTTPBody = [postDataString dataUsingEncoding:NSUTF8StringEncoding];;
    request.HTTPMethod = @"POST";
    
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *dictionary;
        if (!error) {
            
            NSDictionary *answer = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"%@", answer);
            
            NSInteger code = [[[answer objectForKey:@"response"] objectForKey:@"code"] integerValue];
            if (code == 1) {
                
                [booking.vehicle putAdditionalInfo:[answer objectForKey:@"vehicle"]];
                [booking.pickupPoint putAdditionalInfo:[answer objectForKey:@"pickupPoint"]];
                [booking.dropoffPoint putAdditionalInfo:[answer objectForKey:@"dropoffPoint"]];
                
                dictionary = [answer objectForKey:@"booking"];
                
                
            } else {
                NSString *errorMessage = [[answer objectForKey:@"response"] objectForKey:@"message"];
                error = [NSError errorWithDomain:@"Loading Wrong" code:0 userInfo:@{NSLocalizedDescriptionKey:errorMessage}];
            }
        } else
            error = [NSError errorWithDomain:@"No Internet Connection" code:0 userInfo:@{NSLocalizedDescriptionKey:@"Check your Internet connection."}];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [booking putAdditionData:dictionary withError:error];
        });
        
    }] resume];
}

@end

