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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self setUpView];
}

- (void)setUpView{
    self.commentsArray = self.post.commentsArray;
    self.profilePicture.image = self.cell.profilePicture.image;
    self.profilePicture.layer.cornerRadius = 16;
    self.profilePicture.clipsToBounds = YES;
    self.usernameTopLabel.text = self.cell.usernameTopLabel.text;
    self.usernameBottomLabel.text = self.cell.usernameBottomLabel.text;
    self.timeLabel.text = self.cell.timeLabel.text;
    self.captionLabel.text = self.cell.captionLabel.text;
    self.locationLabel.text = self.cell.locationLabel.text;
    self.postedPicture.file = self.post.image;
    [self.postedPicture loadInBackground];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)HomeButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65; //manual sizing
}

@end
