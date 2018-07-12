//
//  ProfileViewController.h
//  Instagram
//
//  Created by Nicolas Machado on 7/10/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
//

#import <ParseUI/ParseUI.h>
#import <UIKit/UIKit.h>
#import "Parse.h"

@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *settingsButtonView;
@property (weak, nonatomic) IBOutlet UILabel *postsCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameOfUserLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;
@property (weak, nonatomic) IBOutlet UIButton *editProfileButton;
@property (weak, nonatomic) IBOutlet UILabel *websiteLabel;
@property (weak, nonatomic) IBOutlet PFImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) PFUser *user;
@end
