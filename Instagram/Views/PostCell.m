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
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapLike:)];
    [self.likeButton addGestureRecognizer:profileTapGestureRecognizer];
    [self.likeButton setUserInteractionEnabled:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [self setUpCellUI];
}

- (void)setUpCellUI{
    self.profilePicture.layer.cornerRadius = 16;
    self.bottomProfilePicture.layer.cornerRadius = 12;
    self.bottomProfilePicture.clipsToBounds = YES;
    
    double likeCount = [self.post.likeCount doubleValue];
    double minusOneLikeCountDouble = likeCount - 1;
    NSNumber *minusOneLikeCount = @(minusOneLikeCountDouble);
    if(likeCount > 0){
        self.likeCountLabel.text = [minusOneLikeCount stringValue];
    }
    else{
        self.likeCountLabel.text = @"0";
    }
  //  self.likeCountLabel.text = [self.post.likeCount stringValue];
    
    PFUser *user = [PFUser currentUser];
    if([self.post.usersLikedArray containsObject:user.username]){        self.likeButton.image = [UIImage imageNamed:@"red_heart"];
    }
    self.userLikedLabel.text = [self.post.usersLikedArray firstObject];
}

- (void)setPost:(Post *)post {
    _post = post;
    PFUser *user = post[@"author"];
    self.profilePicture.file = user[@"profile_image"];
    [self.profilePicture loadInBackground];
    self.bottomProfilePicture.file = user[@"profile_image"];
    [self.bottomProfilePicture loadInBackground];
    self.photoImageView.file = post[@"image"];
    [self.photoImageView loadInBackground];
}

- (void) didTapLike:(UITapGestureRecognizer *)sender{
    PFUser *user = [PFUser currentUser];
    if([self.post.usersLikedArray containsObject:user.username]){ //unliking
        [self.post.usersLikedArray removeObject:user.username];
        [self.post setObject:self.post.usersLikedArray forKey:@"usersLikedArray"];
        double likeCount = [self.post.likeCount doubleValue];
        likeCount -= 1;
        self.post.likeCount = @(likeCount);
        //self.likeCountLabel.text = [self.post.likeCount stringValue];
        self.likeButton.image = [UIImage imageNamed:@"hollow_heart"];
    }
    else{ //liking
        
        [self.post.usersLikedArray addObject:user.username];
        [self.post setObject:self.post.usersLikedArray forKey:@"usersLikedArray"];
        double likeCount = [self.post.likeCount doubleValue];
        likeCount += 1;
        double minusOneLikeCountDouble = [self.post.likeCount doubleValue];
        NSNumber *minusOneLikeCount = @(minusOneLikeCountDouble);
        self.post.likeCount = @(likeCount);
        if(likeCount > 0){
            self.likeCountLabel.text = [minusOneLikeCount stringValue]; //this causes the negative one
        }
        else{
            //and label is blank
            //likecountlabel is blank
            //otherslabel is blank
            self.likeCountLabel.text = [self.post.likeCount stringValue];
        }
        self.likeButton.image = [UIImage imageNamed:@"red_heart"];
    }
    [self.post saveInBackground];
}

@end
