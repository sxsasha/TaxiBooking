//
//  BookingDetailsVC.m
//  TaxiBooking
//
//  Created by sxsasha on 5/9/17.
//  Copyright © 2017 Tony Hrabovskyi. All rights reserved.
//

#import "BookingDetailsVC.h"
#import "Constants.h"
#import "Utilities.h"

#import "Booking.h"
#import "Customer.h"
#import "PlacePoint.h"
@import GoogleMaps;

@interface BookingDetailsVC () <UIScrollViewDelegate, GMSMapViewDelegate>

//main views
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *dragView;
@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

//buttons
@property (weak, nonatomic) IBOutlet UIButton *meetingButton;
@property (weak, nonatomic) IBOutlet UIButton *reportButton;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UIButton *chatButton;

//all labels
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *flightLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressFrom;
@property (weak, nonatomic) IBOutlet UILabel *toLabelLabel;
@property (weak, nonatomic) IBOutlet UILabel *toDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressToLabel;
@property (weak, nonatomic) IBOutlet UILabel *estimateLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *notesLabel;

@property (weak, nonatomic) IBOutlet UILabel *customerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *countPeoplesLabel;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mapHeightContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeightContraint;
@property (assign, nonatomic) CGFloat defaultHeight;

@property (strong, nonatomic) Booking *booking;

@end

@implementation BookingDetailsVC


+ (BookingDetailsVC *)getFromStoryboard {
    NSString *name = NSStringFromClass([self class]);
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:name bundle:nil];
    BookingDetailsVC *vc = [mainStoryboard instantiateInitialViewController];
    return vc;
}

#pragma mark - Main override methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configAll];
}

#pragma mark - API

- (void)setupBooking:(Booking *)booking {
    [booking loadingFullInfoWithBlock:^(NSError *error) {
        if (error) {
            [self showError:error.domain message:error.localizedDescription];
        }
        else {
            _booking = booking;
            [self configAllLabels:booking];
            [self hideLoadView];
        }
    }];
}

#pragma mark - Configuration

- (void)configAll {
    self.scrollView.delegate = self;
    self.mapView.delegate = self;
    
    [self customizationButtons];
    [self customizationDragView];
    [self customizationMapView];
    [self customizeNavigation];
    [self customizationLoadView];
    [self loadBooking];
}

#pragma mark - Config after loading

- (void)configMap:(Booking *)booking {
    
}

- (void)configAllLabels:(Booking *)booking {
    
    self.dateLabel.text = [Utilities getCustomizedDate:booking.pickupDateTime];
    self.nameLabel.text = booking.customer.fullName;
    self.flightLabel.text = [NSString stringWithFormat:@"Flight: %@", booking.flightInfo.uppercaseString];
    
    self.fromLabel.attributedText = [self boldFromString:@"From: " name:booking.pickupPoint.name type:booking.pickupPoint.type];
    self.fromDescriptionLabel.text = booking.pickupPoint.pointDescription;
    self.addressFrom.text = [self addressFrom:booking.pickupPoint];
    
    self.toLabelLabel.attributedText = [self boldFromString:@"To: " name:booking.dropoffPoint.name type:booking.dropoffPoint.type];
    self.toDescriptionLabel.text = booking.dropoffPoint.pointDescription;
    self.addressToLabel.text = [self addressFrom:booking.dropoffPoint];
    
    Float32 minutes = ((float)booking.durationInSeconds / 60.f);
    self.estimateLabel.text = [NSString stringWithFormat:@"Est. booking duration: (0 minutes - if applicable) %2.f minutes", minutes];
    self.categoryLabel.text = [NSString stringWithFormat:@"Category: %@", booking.category];
    self.notesLabel.text = [NSString stringWithFormat:@"Notes: %@", booking.notes];

    self.customerNameLabel.text = booking.customer.fullName;
    self.phoneLabel.text = booking.customer.phoneNumber;
    self.countPeoplesLabel.text = [NSString stringWithFormat:@"Adults: %lu Children: %lu", (unsigned long)booking.adultPax, (unsigned long)booking.childrenPax];
}

- (NSAttributedString *)boldFromString:(NSString *)string name:(NSString *)name type:(NSString *)type  {
    NSMutableAttributedString *mutableAttribString = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSString *nameString = [NSString stringWithFormat:@"%@ %@", name, type];
    UIFont *boldFont = [UIFont boldSystemFontOfSize:13.f];
    NSAttributedString *nameAttribString = [[NSAttributedString alloc] initWithString:nameString attributes:@{NSFontAttributeName:boldFont}];
    [mutableAttribString appendAttributedString:nameAttribString];
    return mutableAttribString;
}

- (NSString *)addressFrom:(PlacePoint *)place {
    return [NSString stringWithFormat:@"%@, %@, %@, %@",place.addressStreet1, place.addressStreet2, place.addressCity, place.addressCountryCode];
}

#pragma mark Functionality config

- (void)loadBooking {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideLoadView];
    });
}

- (void)hideLoadView {
    _loadingView.hidden = YES;
}

#pragma mark Customizations

- (void)customizationButtons {
    _meetingButton.layer.masksToBounds = NO;
    _meetingButton.layer.cornerRadius = 25.f;
    _meetingButton.layer.borderWidth = 0.5f;
    _meetingButton.layer.borderColor = GREY.CGColor;
    
    _reportButton.layer.masksToBounds = NO;
    _reportButton.layer.cornerRadius = 7.f;
    _reportButton.layer.borderWidth = 0.5f;
    _reportButton.layer.borderColor = BUITY_RED.CGColor;
}

- (void)customizationDragView {
    _dragView.layer.borderWidth = 0.5f;
    _dragView.layer.borderColor = GREY.CGColor;
}

- (void)customizationMapView {
    _defaultHeight = [UIScreen mainScreen].bounds.size.height / 3.f;
    _viewHeightContraint.constant = _defaultHeight + 510;
    _mapHeightContraint.constant = _defaultHeight;
}

- (void)customizationLoadView {
    _loadingView.backgroundColor = [UIColor whiteColor];
}

- (void)customizeNavigation {
    self.navigationItem.title = @"Booking Details";
    
   UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    back.tintColor = DARK_GREY;
    self.navigationItem.leftBarButtonItem = back;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    //update view
    [self.view layoutIfNeeded];
    
    //do constraint
    if (_mapHeightContraint.constant == _defaultHeight) {
        if (scrollView.contentOffset.y < -60) {
            _mapHeightContraint.constant = _defaultHeight * 2;
        }
    }
    else if (_mapHeightContraint.constant == _defaultHeight * 2) {
        if (scrollView.contentOffset.y > 60) {
            _mapHeightContraint.constant = _defaultHeight;
        }
    }
    
    //animate
    [UIView animateWithDuration:0.25f animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        //compate
    }];
}

#pragma mark - GMSMapViewDelegate



#pragma mark - Actions

- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)tapMeeting:(id)sender {
    
}

- (IBAction)reportAction:(id)sender {
    
}

- (IBAction)phoneAction:(id)sender {
    
}

- (IBAction)messageAction:(id)sender {
    
}

#pragma mark - Show Error

- (void)showError:(NSString *)title message:(NSString *)message {
    UIAlertController* controller = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle: @"Ok"
                                                          style: UIAlertActionStyleDestructive
                                                        handler: ^(UIAlertAction *action) {
                                                            
                                                        }];
    [controller addAction: alertAction];
    
    [self presentViewController: controller animated: YES completion: nil];
}

@end
