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
#import "Utilities.h"


@interface BookingCell ()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *toLabel;
@property (weak, nonatomic) IBOutlet UILabel *estimateLabel;
@property (weak, nonatomic) IBOutlet UILabel *classLabel;
@end


@implementation BookingCell

- (void)configWithBooking:(Booking *)booking {
    _dateLabel.text = [Utilities getCustomizedDate:booking.pickupDateTime];
    _estimateLabel.text = [self getEstimate:booking.distanceKm
                          durationInSeconds:booking.durationInSeconds];
    _classLabel.text = booking.category;
    NSAttributedString *fromString = [self getAddressDescription:booking.pickupPoint.name
                                                  type:booking.pickupPoint.type
                                           addressCity:booking.pickupPoint.addressCity
                                                      withString:@"From: "];
    NSAttributedString *toString = [self getAddressDescription:booking.dropoffPoint.name
                                                type:booking.dropoffPoint.type
                                         addressCity:booking.dropoffPoint.addressCity
                                                    withString:@"To: "];
    _fromLabel.attributedText = fromString;
    _toLabel.attributedText = toString;
}

#pragma mark - Change text format

- (NSString *)getEstimate:(Float32)distance
        durationInSeconds:(NSUInteger)duration {
    
    Float32 minutes = ((float)duration / 60.f);
    NSString *estimate = [NSString stringWithFormat:@"Est. %2.fkm - %2.f minutes",distance , minutes];
    return estimate;
}

- (NSAttributedString *)getAddressDescription:(NSString *)name
                               type:(NSString *)type
                        addressCity:(NSString *)addressCity
                         withString:(NSString *)string {
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSString *nameString = [NSString stringWithFormat:@"%@ %@", name, type];
    UIFont *boldFont = [UIFont boldSystemFontOfSize:13.f];
    NSAttributedString *nameAttribString = [[NSAttributedString alloc] initWithString:nameString attributes:@{NSFontAttributeName:boldFont}];
    [attrString appendAttributedString:nameAttribString];
    
    NSString *addressString = [NSString stringWithFormat:@" - %@", addressCity];
    NSAttributedString *addressAttrString = [[NSAttributedString alloc] initWithString:addressString];
    [attrString appendAttributedString:addressAttrString];

   // NSString *string = [NSString stringWithFormat:@"%@ %@ - %@", name, type, addressCity];
    return attrString;
}


@end
