//
//  ViewController.m
//  InstaClone
//
//  Created by fdadzie20 on 7/6/20.
//  Copyright © 2020 fdadzie20. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)onSignUp:(id)sender {
    PFUser *newUser = [PFUser user];
    
    newUser.username = self.userTextField.text;
    newUser.password = self.passTextField.text;
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            [self performSegueWithIdentifier:@"showPosts" sender:(nil)];
            // manually segue to logged in view
        }
    }];
}


- (IBAction)onLogin:(id)sender {
    NSString *username = self.userTextField.text;
    NSString *password = self.passTextField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            [self performSegueWithIdentifier:@"showPosts" sender:(nil)];
            // display view controller that needs to shown after successful login
        }
    }];
}


@end
