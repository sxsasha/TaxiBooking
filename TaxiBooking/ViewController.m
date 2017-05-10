//
//  ViewController.m
//  TaxiBooking
//
//  Created by Tony Hrabovskyi on 5/9/17.
//  Copyright © 2017 Tony Hrabovskyi. All rights reserved.
//

#import "ViewController.h"
#import "Driver.h"
#import "Utilities.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    Driver *driver = [[Driver alloc] initWithLogin:@"tia61@example.org" andPassword:@"secret"];
    [driver authorizeWithBlock:^(NSError *error) {
        if (error)
            NSLog(@"%@", error.localizedDescription);
        else
            NSLog(@"Authorized");
        
//        [driver logout];
        NSURL *url = [NSURL URLWithString:driver.photoURL];
        [Utilities loadImageFromURL:url andCompletionBlock:^(UIImage *image) {
            NSLog(@"photo loaded");
            NSLog(@"%@", image);
        }];
        
        
    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
