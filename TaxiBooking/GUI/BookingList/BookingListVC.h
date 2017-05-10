//
//  BookingListVC.h
//  TaxiBooking
//
//  Created by sxsasha on 5/9/17.
//  Copyright © 2017 Tony Hrabovskyi. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Driver;

@interface BookingListVC : UIViewController

+ (BookingListVC *)getFromStoryboard;

- (void)setupDriver:(Driver*)profile;
@end
