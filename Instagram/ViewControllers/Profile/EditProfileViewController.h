//
//  EditProfileViewController.h
//  Instagram
//
//  Created by Nicolas Machado on 7/11/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *websiteTextField;
@property (weak, nonatomic) IBOutlet UITextView *biographyTextView;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *website;
@property (strong, nonatomic) NSString *biography;

@end
