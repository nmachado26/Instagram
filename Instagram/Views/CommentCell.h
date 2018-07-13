//
//  CommentCell.h
//  Instagram
//
//  Created by Nicolas Machado on 7/12/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import "Post.h"

@interface CommentCell : UITableViewCell

@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet PFImageView *profilePicture;
@end
