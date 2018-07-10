//
//  LoginViewController.h
//  Instagram
//
//  Created by Nicolas Machado on 7/9/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *bottomBarView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;
@property (weak, nonatomic) IBOutlet UILabel *instagramLabel;
@property (weak, nonatomic) IBOutlet UILabel *forgotYourLoginDetailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *getHelpSigningInLabel;
@property (weak, nonatomic) IBOutlet UILabel *orLabel;
@property (weak, nonatomic) IBOutlet UILabel *loginWithFacebookLabel;
@property (weak, nonatomic) IBOutlet UILabel *dontHaveAnAccountLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView1;
@property (weak, nonatomic) IBOutlet UIView *lineView2;


@end
