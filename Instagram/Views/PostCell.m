//
//  PostCell.m
//  Instagram
//
//  Created by Nicolas Machado on 7/9/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
//

#import "PostCell.h"
#import "Parse.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.profilePicture.layer.cornerRadius = 16;
    self.profilePicture.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [self setUpCellUI];
}

- (void)setUpCellUI{
    self.profilePicture.layer.cornerRadius = 16;
}

- (void)setPost:(Post *)post {
    _post = post;
    PFUser *user = post[@"author"];
    self.profilePicture.file = user[@"profile_image"];
    [self.profilePicture loadInBackground];
    self.photoImageView.file = post[@"image"];
    [self.photoImageView loadInBackground];
}


@end
