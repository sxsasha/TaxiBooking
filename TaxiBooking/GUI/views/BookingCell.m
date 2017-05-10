//
//  BookingCell.m
//  TaxiBooking
//
//  Created by sxsasha on 5/9/17.
//  Copyright © 2017 Tony Hrabovskyi. All rights reserved.
//

#import "BookingCell.h"
#import "Booking.h"
#import "PlacePoint.h"


@interface BookingCell ()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *toLabel;
@property (weak, nonatomic) IBOutlet UILabel *estimateLabel;
@property (weak, nonatomic) IBOutlet UILabel *classLabel;
@end


@implementation BookingCell

- (void)configWithBooking:(Booking *)booking {
    _dateLabel.text = [self getDate:booking.pickupDateTime];
    _estimateLabel.text = [self getEstimate:booking.distanceKm
                          durationInSeconds:booking.durationInSeconds];
    _classLabel.text = booking.category;
    NSString *fromString = [self getAddressDescription:booking.pickupPoint.name
                                                  type:booking.pickupPoint.type
                                           addressCity:booking.pickupPoint.addressCity];
    NSString *toString = [self getAddressDescription:booking.dropoffPoint.name
                                                type:booking.dropoffPoint.type
                                         addressCity:booking.dropoffPoint.addressCity];
    _fromLabel.text = [NSString stringWithFormat:@"From: %@", fromString];
    _toLabel.text = [NSString stringWithFormat:@"To: %@", toString];
}

#pragma mark - Change text format

- (NSString *)getEstimate:(Float32)distance
        durationInSeconds:(NSUInteger)duration {
    
    Float32 minutes = ((float)duration / 60.f);
    NSString *estimate = [NSString stringWithFormat:@"Est. %2.fkm - %2.f minutes",distance , minutes];
    return estimate;
}

- (NSString *)getDate:(NSDate *)pickupDateTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.PMSymbol = @"pm";
    dateFormatter.AMSymbol = @"am";
    dateFormatter.dateFormat = @"E dd MMM hh:mm a";
    
    NSString *dateString = [NSString stringWithFormat:@"%@ pick-up",[dateFormatter stringFromDate:pickupDateTime]];
    return dateString;
}

- (NSString *)getAddressDescription:(NSString *)name
                               type:(NSString *)type
                        addressCity:(NSString *)addressCity {
    
    //needs rework
    
    //NSString *nameString = [NSString stringWithFormat:@"%@ %@", name, type];
    
    //UIFont *boldFont = [UIFont boldSystemFontOfSize:13.f];
    //NSMutableAttributedString *nameAttribString = [[NSMutableAttributedString alloc] initWithString:nameString];
    //[nameAttribString addAttribute:NSFontAttributeName value:<#(nonnull id)#> range:<#(NSRange)#>;
    //NSString *formatString = [NSString stringWithFormat:@""]
    //Float32 minutes = ((float)duration / 60.f);
   // NSString *estimate = [NSString stringWithFormat:@"Est. %2.fkm - %2.f minutes",distance , minutes];
    NSString *string = [NSString stringWithFormat:@"%@ %@ - %@", name, type, addressCity];
    
    return string;
}


@end
