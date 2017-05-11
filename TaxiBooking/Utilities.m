//
//  Globals.m
//  TaxiBooking
//
//  Created by Tony Hrabovskyi on 5/9/17.
//  Copyright © 2017 Tony Hrabovskyi. All rights reserved.
//

#import "Utilities.h"
#import <UIKit/UIImage.h>

@implementation Utilities

static NSDateFormatter *dateFormatter;

+ (BOOL)isMail:(NSString*)email {
    NSArray<NSString*> *emailParts = [email componentsSeparatedByString:@"@"];
    return emailParts.count == 2 && [emailParts objectAtIndex:0].length > 2 && [emailParts objectAtIndex:1].length >= 2;
}

+ (void)loadImageFromURL:(NSString*)imageURL andCompletionBlock:(CompletionImageBlock)completionBlock {
    
    NSURL *url = [NSURL URLWithString:imageURL];
    
    if (!url) {
        completionBlock(nil);
        return;
    }
    [[[NSURLSession sharedSession] dataTaskWithURL:url
                                completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

                                    UIImage *image;
                                    if (!error) {
                                        image = [UIImage imageWithData:data];
                                    }
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        completionBlock(image);
                                    });
    }] resume];
}

+ (NSDateFormatter*)shaderDateFormatter {
    
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return dateFormatter;
}

+ (NSString *)getCustomizedDate:(NSDate *)pickupDateTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.PMSymbol = @"pm";
    dateFormatter.AMSymbol = @"am";
    dateFormatter.dateFormat = @"E dd MMM hh:mm a";
    
    NSString *dateString = [NSString stringWithFormat:@"%@ pick-up",[dateFormatter stringFromDate:pickupDateTime]];
    return dateString;
}

@end
