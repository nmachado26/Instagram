//
//  DetailsViewController.h
//  Instagram
//
//  Created by Nicolas Machado on 7/10/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import "PostCell.h"

@interface DetailsViewController : UIViewController

@property (strong, nonatomic) Post *post;
@property (strong, nonatomic) PostCell *cell;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *usernameBottomLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameTopLabel;
@property (weak, nonatomic) IBOutlet PFImageView *postedPicture;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end
