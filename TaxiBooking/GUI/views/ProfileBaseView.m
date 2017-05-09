//
//  ProfileBaseView.m
//  TaxiBooking
//
//  Created by sxsasha on 5/9/17.
//  Copyright © 2017 Tony Hrabovskyi. All rights reserved.
//

#import "ProfileBaseView.h"

@implementation ProfileBaseView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self customizeProfileImage];
}

- (void)customizeProfileImage {
    _profileImage.layer.masksToBounds = NO;
    _profileImage.layer.cornerRadius = self.profileImage.frame.size.height / 2;
}

@end
