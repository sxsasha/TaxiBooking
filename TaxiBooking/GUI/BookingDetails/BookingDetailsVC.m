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
    _mapHeightContraint.constant = _defaultHeight;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
   // NSLog(@"targetContentOffset: %@", NSStringFromCGPoint(velocity));
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    //update view
    [self.view layoutIfNeeded];
    
    //do constraint
    if (_mapHeightContraint.constant == _defaultHeight) {
        if (scrollView.contentOffset.y < -50) {
            _mapHeightContraint.constant = _defaultHeight * 2;
        }
    }
    else if (_mapHeightContraint.constant == _defaultHeight * 2) {
        if (scrollView.contentOffset.y > 100) {
            _mapHeightContraint.constant = _defaultHeight;
        }
    }
    
//    else if (scrollView.contentOffset.y > 100) {
//        _mapHeightContraint.constant = _mapHeightContraint.constant / 2;
//    }
//    
//    if (scrollView.contentOffset.y < -50) {
//        _mapHeightContraint.constant = _mapHeightContraint.constant * 2;
//    }
//    
//    if (scrollView.contentOffset.y > 200) {
//        _mapHeightContraint.constant = _mapHeightContraint.constant / 2;
//    }
//    
    //animate
    [UIView animateWithDuration:0.25f animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        //compate
    }];

    NSLog(@"targetContentOffset: %@", NSStringFromCGPoint(scrollView.contentOffset));
}

#pragma mark - GMSMapViewDelegate

@end
