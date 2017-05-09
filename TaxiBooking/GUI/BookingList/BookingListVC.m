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


@interface BookingListVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *bookingList;
@property (weak, nonatomic) IBOutlet ProfileBaseView *profileBaseView;

@property (strong, nonatomic) NSObject *driver;
@property (strong, nonatomic) NSArray *bookings;
@end

static NSString *cellIdentifier = @"BookingCell";

@implementation BookingListVC

+ (BookingListVC *)getFromStoryboard {
    NSString *name = NSStringFromClass([self class]);
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:name bundle:nil];
    BookingListVC *vc = [mainStoryboard instantiateInitialViewController];
    return vc;
}

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
    
    logout.tintColor = LABELS_DARK_BACKGROUND;
    self.navigationItem.leftBarButtonItem = logout;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15; //self.bookings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BookingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    return cell;
}

#pragma mark - Actions

- (IBAction)logoutAction:(id)sender {

}

@end
