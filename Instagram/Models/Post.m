//
//  Post.m
//  Instagram
//
//  Created by Nicolas Machado on 7/9/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
//

#import "Post.h"

@implementation Post
@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic caption;
@dynamic location;
@dynamic image;
@dynamic likeCount;
@dynamic commentCount;
@dynamic usersLikedArray;
@dynamic commentsArray;


+ (nonnull NSString *)parseClassName {
    return @"Post";
}

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withLocation: ( NSString * _Nullable )location withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Post *newPost = [Post new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.caption = caption;
    newPost.likeCount = @(0);
    newPost.commentCount = @(0);
    newPost.location = location;
    newPost.usersLikedArray = [[NSMutableArray alloc] init];
    newPost.commentsArray = [[NSMutableArray alloc] init];
    
    
    [newPost saveInBackgroundWithBlock: completion];
}

+ (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image {
    
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFile fileWithName:@"image.png" data:imageData];
}

@end
