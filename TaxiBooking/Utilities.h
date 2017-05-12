//
//  Globals.h
//  TaxiBooking
//
//  Created by Tony Hrabovskyi on 5/9/17.
//  Copyright © 2017 Tony Hrabovskyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;

typedef void (^CompletionImageBlock)(UIImage* image);



@interface Utilities : NSObject

+ (void)loadImageFromURL:(NSString*)imageURL andCompletionBlock:(CompletionImageBlock)completionBlock;
@end
