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
#import "Driver.h"

@interface LoginVC () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;
@property (weak, nonatomic) IBOutlet UIView *loadingView;

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
    [self customizationLoadView];
    // Do any additional setup after loading the view.
}

#pragma mark - Loading

- (void)showLoadView {
    _loadingView.hidden = NO;
}

- (void)hideLoadView {
    _loadingView.hidden = YES;
}

- (void)customizationLoadView {
    _loadingView.hidden = YES;
    _loadingView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Initializations

- (void)customizeLoginButton {
    _logInButton.layer.cornerRadius = 8.0f;
    _logInButton.clipsToBounds = YES;
    _logInButton.layer.borderColor = DARK_GREY.CGColor;
    _logInButton.layer.borderWidth = 0.4f;
    _logInButton.layer.backgroundColor = [UIColor whiteColor].CGColor;
}

- (void)customizeTextFields {
    _usernameField.layer.cornerRadius = 8.0f;
    _usernameField.clipsToBounds = YES;
    _usernameField.layer.borderColor = DARK_GREY.CGColor;
    _usernameField.layer.borderWidth = 0.4f;
    
    _passwordField.layer.cornerRadius = 8.0f;
    _passwordField.clipsToBounds = YES;
    _passwordField.layer.borderColor = DARK_GREY.CGColor;
    _passwordField.layer.borderWidth = 0.4f;
    
    _usernameField.delegate = self;
    _passwordField.delegate = self;
}

- (void)customizeNavigation {
    self.navigationItem.title = @"Driver LogIn";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.usernameField]) {
        [self.usernameField becomeFirstResponder];
    }
    else if ([textField isEqual:self.passwordField]) {
        [self.usernameField resignFirstResponder];
        [self logIn:nil];
    }
    return YES;
}


#pragma mark - Actions

- (IBAction)logIn:(id)sender {
    [self.usernameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    [self showLoadView];
    NSString *login = self.usernameField.text;
    NSString *pass = self.passwordField.text;
    Driver *driver = [[Driver alloc] initWithLogin:login andPassword:pass];
    [driver authorizeWithBlock:^(NSError *error) {
        [self hideLoadView];
        if (error) {
            [self showError:error.domain message:error.localizedDescription];
            return;
        }
        BookingListVC *bookingList = [BookingListVC getFromStoryboard];
        [bookingList setupDriver:driver];
        [self.navigationController pushViewController:bookingList animated:YES];
    }];
}

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
