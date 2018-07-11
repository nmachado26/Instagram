//
//  ProfileCollectionCell.h
//  Instagram
//
//  Created by Nicolas Machado on 7/10/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import "Post.h"
#import "Parse.h"


@interface ProfileCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet PFImageView *profilePost;

@end
