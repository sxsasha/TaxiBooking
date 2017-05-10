//
//  LoginVC.m
//  TaxiBooking
//
//  Created by sxsasha on 5/9/17.
//  Copyright © 2017 Tony Hrabovskyi. All rights reserved.
//

#import "LoginVC.h"
#import "Constants.h"
#import "BookingListVC.h"

@interface LoginVC ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;

@end

@implementation LoginVC

+ (LoginVC *)getFromStoryboard {
    NSString *name = NSStringFromClass([self class]);
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:name bundle:nil];
    LoginVC *vc = [mainStoryboard instantiateInitialViewController];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customizeLoginButton];
    [self customizeTextFields];
    [self customizeNavigation];
    // Do any additional setup after loading the view.
}

#pragma mark - Initializations

- (void)customizeLoginButton {
    _logInButton.layer.cornerRadius = 8.0f;
    _logInButton.clipsToBounds = YES;
    _logInButton.layer.borderColor = GREY.CGColor;
    _logInButton.layer.borderWidth = 0.5f;
    _logInButton.layer.backgroundColor = [UIColor whiteColor].CGColor;
}

- (void)customizeTextFields {
    _usernameField.layer.cornerRadius = 8.0f;
    _usernameField.clipsToBounds = YES;
    _usernameField.layer.borderColor = GREY.CGColor;
    _usernameField.layer.borderWidth = 0.5f;
    
    _passwordField.layer.cornerRadius = 8.0f;
    _passwordField.clipsToBounds = YES;
    _passwordField.layer.borderColor = GREY.CGColor;
    _passwordField.layer.borderWidth = 0.5f;
}

- (void)customizeNavigation {
    self.navigationItem.title = @"Driver LogIn";
}


#pragma mark - Actions

- (IBAction)logIn:(id)sender {
    BookingListVC *bookingList = [BookingListVC getFromStoryboard];
    [self.navigationController pushViewController:bookingList animated:YES];
}

@end
