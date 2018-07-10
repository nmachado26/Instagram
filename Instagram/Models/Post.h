//
//  Post.h
//  Instagram
//
//  Created by Nicolas Machado on 7/9/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
//

#import "PFObject.h"
#import <Foundation/Foundation.h>
#import "Parse/Parse.h"


@interface Post : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) PFFile *image;
@property (nonatomic, strong) NSNumber *likeCount;
@property (nonatomic, strong) NSNumber *commentCount;

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withLocation: ( NSString * _Nullable )location withCompletion: (PFBooleanResultBlock  _Nullable)completion;


@end
