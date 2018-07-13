//
//  PostCell.h
//  Instagram
//
//  Created by Nicolas Machado on 7/9/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
//

#import <ParseUI/ParseUI.h>
#import <UIKit/UIKit.h>
#import "Parse.h"
#import "Post.h"

@interface PostCell : UITableViewCell <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet PFImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *userLikedLabel;
@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet PFImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UIImageView *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *commentButton;
@property (weak, nonatomic) IBOutlet PFImageView *bottomProfilePicture;
@property (weak, nonatomic) IBOutlet UILabel *usernameTopLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameBottomLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UITextField *commentTextField;


@end
