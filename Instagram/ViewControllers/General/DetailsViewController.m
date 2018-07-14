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

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *commentsArray;


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
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.commentsArray = self.post.commentsArray;
    self.profilePicture.image = self.cell.profilePicture.image;
    self.profilePicture.layer.cornerRadius = 16;
    self.profilePicture.clipsToBounds = YES;
    self.usernameTopLabel.text = self.cell.usernameTopLabel.text;
    self.usernameBottomLabel.text = self.cell.usernameBottomLabel.text;
    self.timeLabel.text = self.cell.timeLabel.text;
    self.captionLabel.text = self.cell.captionLabel.text;
    self.postedPicture.file = self.post.image;
    [self.postedPicture loadInBackground];
    self.locationLabel.text = self.cell.locationLabel.text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)HomeButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CommentCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
    cell.usernameLabel.text = self.post.author.username;
    cell.commentLabel.text = self.post.commentsArray[indexPath.row];
    [cell setPost:self.post];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

@end
