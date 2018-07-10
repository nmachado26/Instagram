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

@interface PostCell : UITableViewCell

@property (strong, nonatomic) IBOutlet PFImageView *photoImageView;
@property (strong, nonatomic) Post *post;

@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
//@property (weak, nonatomic) IBOutlet UIImageView *postedPicture;
@property (weak, nonatomic) IBOutlet UILabel *usernameTopLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameBottomLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;


@end
