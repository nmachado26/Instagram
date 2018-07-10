//
//  LoginViewController.m
//  Instagram
//
//  Created by Nicolas Machado on 7/9/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpGradient];
    [self setUpUI];
    // Do any additional setup after loading the view.
}

- (void)setUpUI{
    //view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    self.loginButton.layer.borderWidth = 1;
    self.loginButton.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:.1f].CGColor;
    self.usernameTextField.layer.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.1f].CGColor;
    self.passwordTextField.layer.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.1f].CGColor;
    self.bottomBarView.layer.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.1f].CGColor;
    
    self.loginButton.tintColor = [UIColor whiteColor];
    self.forgotYourLoginDetailsLabel.textColor = [UIColor whiteColor];
    self.getHelpSigningInLabel.textColor = [UIColor whiteColor];
    self.loginWithFacebookLabel.textColor = [UIColor whiteColor];
    self.orLabel.textColor = [UIColor whiteColor];
    self.dontHaveAnAccountLabel.textColor = [UIColor whiteColor];
    self.lineView1.backgroundColor = [UIColor whiteColor];
    self.lineView2.backgroundColor = [UIColor whiteColor];
    self.loginButton.titleLabel.textColor = [UIColor whiteColor];
    self.instagramLabel.textColor = [UIColor whiteColor];
}
- (void)setUpGradient{
    // Create the colors
    UIColor *color1 = [UIColor colorWithRed:255.0/255.0 green:64.0/255.0 blue:79.0/255.0 alpha:1.0];
    UIColor *color2 = [UIColor colorWithRed:218.0/255.0 green:65.0/255.0 blue:71.0/255.0 alpha:1.0];
    UIColor *color3 = [UIColor colorWithRed:176.0/255.0 green:69.0/255.0 blue:103.0/255.0 alpha:1.0];
    UIColor *color4 = [UIColor colorWithRed:146.0/255.0 green:23.0/255.0 blue:178.0/255.0 alpha:1.0];
//    UIColor *bottomColor = [UIColor colorWithRed:150.0/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1.0];
    
    // Create the gradient
    CAGradientLayer *theViewGradient = [CAGradientLayer layer];
    theViewGradient.colors = [NSArray arrayWithObjects: (id)color1.CGColor, (id)color2.CGColor, (id)color3.CGColor, (id)color4.CGColor, nil];
    theViewGradient.frame = self.view.bounds;
    
    //Add gradient to view
    [self.view.layer insertSublayer:theViewGradient atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginButtonPressed:(id)sender {
    [self loginUser];
}
- (IBAction)signupButtonPressed:(id)sender {
    if([self.usernameTextField.text isEqual:@""]){
        [self presentAlert:@"sign up"];
    }
    else if([self.passwordTextField.text isEqual:@""]){
        [self presentAlert:@"sign up"];
    }
    else{
        [self registerUser];
    }
}

- (void)loginUser{
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            [self presentAlert:@"login"];
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}

- (void)registerUser{
    PFUser *newUser = [PFUser user];
    newUser.username = self.usernameTextField.text;
    newUser.password = self.passwordTextField.text;
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(error != nil){
            NSLog(@"Error: %@", error.localizedDescription);
            [self presentAlert:@"sign in"];
        }
        else{
            NSLog(@"User registered successfully");
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}

- (void)presentAlert:(NSString*)type{
    //NSString* type can insert login in or sign out in the string if desired
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Empty username or password" preferredStyle:(UIAlertControllerStyleAlert)];
    // create a cancel action
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) { // handle cancel response here. Doing nothing will dismiss the view.
    }];
    // add the cancel action to the alertController
    [alert addAction:cancelAction];
    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { // handle response here.
    }];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:^{
        // optional code for what happens after the alert controller has finished presenting
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
