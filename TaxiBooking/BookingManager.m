//
//  BookingManager.m
//  TaxiBooking
//
//  Created by Tony Hrabovskyi on 5/9/17.
//  Copyright © 2017 Tony Hrabovskyi. All rights reserved.
//

#import "Driver.h"
#import "BookingManager.h"

@implementation BookingManager

static NSString *apiToken = @"32v7a8ojRSkLfwySlgCB5Zo5KckpopjpOH63qlqpqRv6F9hWGjlZUDZTzOIK";
static BookingManager* instance;

+ (BookingManager*)shaderManager {
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
            NSLog(@"%@", answer);
            
            NSInteger code = [[[answer objectForKey:@"response"] objectForKey:@"code"] integerValue];
            if (code == 1) {
                NSDictionary *driverInfo = [answer objectForKey:@"driver"];
                [driver putAdditionalInfo:driverInfo];
            
            
            } else
                error = [NSError errorWithDomain:@"backseatz.com" code:0 userInfo:@{NSLocalizedDescriptionKey:@"Error with login. Check login and password."}];
        } else
            error = [NSError errorWithDomain:@"backseatz.com" code:400 userInfo:@{NSLocalizedDescriptionKey:@"Check your Internet connection."}];
        
        
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

@end














