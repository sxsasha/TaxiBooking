//
//  BookingCell.h
//  TaxiBooking
//
//  Created by sxsasha on 5/9/17.
//  Copyright © 2017 Tony Hrabovskyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *toLabel;
@property (weak, nonatomic) IBOutlet UILabel *estimateLabel;
@property (weak, nonatomic) IBOutlet UILabel *classLabel;

@end
