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

@end
