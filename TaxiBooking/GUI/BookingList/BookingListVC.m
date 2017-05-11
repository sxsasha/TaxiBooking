//
//  BookingListVC.m
//  TaxiBooking
//
//  Created by sxsasha on 5/9/17.
//  Copyright © 2017 Tony Hrabovskyi. All rights reserved.
//

#import "BookingListVC.h"
#import "Constants.h"

#import "ProfileBaseView.h"
#import "BookingCell.h"
#import "BookingDetailsVC.h"
#import "Driver.h"
#import "Utilities.h"


@interface BookingListVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *bookingList;
@property (weak, nonatomic) IBOutlet ProfileBaseView *profileBaseView;

@property (strong, nonatomic) NSObject *driver;
@property (strong, nonatomic) NSArray <Booking *> *bookings;
@end

static NSString *cellIdentifier = @"BookingCell";

@implementation BookingListVC

+ (BookingListVC *)getFromStoryboard {
    NSString *name = NSStringFromClass([self class]);
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:name bundle:nil];
    BookingListVC *vc = [mainStoryboard instantiateInitialViewController];
    return vc;
}

#pragma mark - API

- (void)setupDriver:(Driver*)driver {
    _driver = driver;
    
    self.profileBaseView.nameLabel.text = [NSString stringWithFormat:@"%@ %@", driver.firstName, driver.lastName];
    self.profileBaseView.emailLabel.text = driver.email;
    
    [Utilities loadImageFromURL:driver.photoURL andCompletionBlock:^(UIImage *image) {
        if (image) {
            [self setupProfileImage:image];
        }
    }];
    
    _bookings = driver.bookingList;
    [self.bookingList reloadData];
}

#pragma mark - Main Overriden methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTableView];
    [self customizeNavigation];
}

#pragma mark - Initialization

- (void)configTableView {
    self.bookingList.delegate = self;
    self.bookingList.dataSource = self;
}

- (void)customizeNavigation {
    self.navigationItem.title = @"Assigned bookings";
    
    UIBarButtonItem *logout = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logoutAction:)];
    
    logout.tintColor = DARK_GREY;
    self.navigationItem.leftBarButtonItem = logout;
}

- (void)setupProfileImage:(UIImage *)image {
    
    UIImageView *imageView = self.profileBaseView.profileImage;
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, NO, 1.0);

    [[UIBezierPath bezierPathWithRoundedRect:imageView.bounds
                                cornerRadius:imageView.bounds.size.height / 2.f] addClip];
    // Draw your image
    [image drawInRect:imageView.bounds];
    
    // Get the image, here setting the UIImageView image
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    [self.profileBaseView layoutIfNeeded];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bookings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Booking *booking = self.bookings[indexPath.row];
    BookingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell configWithBooking:booking];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Booking *booking = self.bookings[indexPath.row];
    BookingDetailsVC *detailsVC = [BookingDetailsVC getFromStoryboard];
    [detailsVC setupBooking:booking];
    
    [self.navigationController pushViewController:detailsVC animated:YES];
}

#pragma mark - Logout

- (IBAction)logoutAction:(id)sender {
    [self showLogoutQuestion];
}

- (void)showLogoutQuestion {
    UIAlertController* controller = [UIAlertController alertControllerWithTitle:@"Logout" message:@"Are you sure?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle: @"YES"
                                                          style: UIAlertActionStyleDestructive
                                                        handler: ^(UIAlertAction *action) {
                                                            [self logoutUser];
                                                        }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleCancel handler:nil];
    
    [controller addAction: alertAction];
    [controller addAction: cancelAction];
    [self presentViewController: controller animated: YES completion:^{
        [controller.view.superview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOutside)]];
    }];
}

- (void)tapOutside {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)logoutUser {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
