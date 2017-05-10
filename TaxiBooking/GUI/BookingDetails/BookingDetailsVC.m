//
//  BookingDetailsVC.m
//  TaxiBooking
//
//  Created by sxsasha on 5/9/17.
//  Copyright © 2017 Tony Hrabovskyi. All rights reserved.
//

#import "BookingDetailsVC.h"
#import "Constants.h"
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
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressFrom;
@property (weak, nonatomic) IBOutlet UILabel *toLabelLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressToLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mapHeightContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeightContraint;
@property (assign, nonatomic)  CGFloat defaultHeight;

@end

@implementation BookingDetailsVC


+ (BookingDetailsVC *)getFromStoryboard {
    NSString *name = NSStringFromClass([self class]);
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:name bundle:nil];
    BookingDetailsVC *vc = [mainStoryboard instantiateInitialViewController];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configAll];
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

    NSLog(@"targetContentOffset: %@", NSStringFromCGPoint(scrollView.contentOffset));
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

@end
