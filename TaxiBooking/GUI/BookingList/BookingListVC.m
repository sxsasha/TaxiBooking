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
            self.profileBaseView.profileImage.image = image;
            [self.profileBaseView layoutIfNeeded];
        }
    }];
    
    _bookings = driver.bookingList;
    [self.bookingList reloadData];
}

- (void)setupBookings:(NSArray*)bookingList {
    
}


#pragma mark - Main Overriden methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTableView];
    [self customizeNavigation];
    // Do any additional setup after loading the view.
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
    BookingDetailsVC *detailsVC = [BookingDetailsVC getFromStoryboard];
    [self.navigationController pushViewController:detailsVC animated:YES];
}

#pragma mark - Actions

- (IBAction)logoutAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
