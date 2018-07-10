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
    /*@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
     @property (weak, nonatomic) IBOutlet UIImageView *postedPicture;
     @property (weak, nonatomic) IBOutlet UILabel *usernameTopLabel;
     @property (weak, nonatomic) IBOutlet UILabel *locationLabel;
     @property (weak, nonatomic) IBOutlet UILabel *usernameBottomLabel;
     @property (weak, nonatomic) IBOutlet UILabel *captionLabel;
     */
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
    self.photoImageView.file = post[@"image"];
    [self.photoImageView loadInBackground];
}


@end
