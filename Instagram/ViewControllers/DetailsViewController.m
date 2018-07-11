//
//  DetailsViewController.m
//  Instagram
//
//  Created by Nicolas Machado on 7/10/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
//

#import "DetailsViewController.h"
#import "Parse.h"


@interface DetailsViewController ()

@end

@implementation DetailsViewController

/*@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
 @property (weak, nonatomic) IBOutlet UILabel *usernameBottomLabel;
 @property (weak, nonatomic) IBOutlet UILabel *captionLabel;
 @property (weak, nonatomic) IBOutlet UILabel *usernameTopLabel;
 @property (weak, nonatomic) IBOutlet PFImageView *postedPicture;
 @property (weak, nonatomic) IBOutlet UILabel *locationLabel;
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.profilePicture = self.cell.profilePicture;
    self.usernameTopLabel.text = self.cell.usernameTopLabel.text;
    self.usernameBottomLabel.text = self.cell.usernameBottomLabel.text;
    self.captionLabel.text = self.cell.captionLabel.text;
    self.postedPicture.file = self.post.image;
    [self.postedPicture loadInBackground];
    self.locationLabel.text = self.cell.locationLabel.text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
