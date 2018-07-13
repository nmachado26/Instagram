//
//  CommentCell.m
//  Instagram
//
//  Created by Nicolas Machado on 7/12/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.profilePicture.layer.cornerRadius = 14;
    self.profilePicture.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPost:(Post *)post {
    _post = post;
    PFUser *user = post[@"author"];
    self.profilePicture.file = user[@"profile_image"];
    [self.profilePicture loadInBackground];
}

@end
