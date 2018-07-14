//
//  FeedViewController.m
//  Instagram
//
//  Created by Nicolas Machado on 7/9/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
//

#import "FeedViewController.h"
#import "PostCell.h"
#import "Parse.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "DetailsViewController.h"
#import <DateTools.h>
#import <MBProgressHud/MBProgressHud.h>

@interface FeedViewController () <UITableViewDelegate, UITableViewDataSource,  UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *postsArray;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (assign, nonatomic) BOOL isMoreDataLoading;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self tableViewSetUp];
    [self fetchPosts];
    [self refreshSetUp];
}

- (void)tableViewSetUp {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 272;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)refreshSetUp {
    // Initialize a UIRefreshControl
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(!self.isMoreDataLoading){
        // Calculate the position of one screen length before the bottom of the results
        int scrollViewContentHeight = self.tableView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height;

        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
            self.isMoreDataLoading = true;
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [self fetchPostsNext];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchPosts];
}

- (void)fetchPosts {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    
    //[query includeKey:@"author"];
    [query includeKey:@"author"];
    [query includeKey:@"caption"];
    [query includeKey:@"likeCount"];
    [query includeKey:@"commentCount"];
    [query includeKey:@"image"];
    query.limit = 20;
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) { //why nullable?
        if(objects != nil){
            self.postsArray = [objects mutableCopy];
            [self.tableView reloadData];
            
            //stop refresh control
            self.isMoreDataLoading = false;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.refreshControl endRefreshing];
        }
        else{
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)fetchPostsNext {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    
    //[query includeKey:@"author"];
    [query includeKey:@"author"];
    [query includeKey:@"caption"];
    [query includeKey:@"likeCount"];
    [query includeKey:@"commentCount"];
    [query includeKey:@"image"];
    query.skip = self.postsArray.count;
    query.limit = 20;
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) { //why not NSArray *posts, like ParseChat?
        if(objects != nil){
            for(Post *post in objects){
                [self.postsArray addObject:post];
            }
            [self.tableView reloadData];
            
            //end refresh
            self.isMoreDataLoading = false;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.refreshControl endRefreshing];
        }
        else{
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    Post *postObject = self.postsArray[indexPath.row];
    PFUser *user = postObject[@"author"];
    if (user != nil) {
        cell.usernameTopLabel.text = user.username;
        cell.usernameBottomLabel.text = user.username;
    } else {
        // No user found, set default username
        cell.usernameTopLabel.text = @"user";
        cell.usernameBottomLabel.text = @"user";
    }
    cell.captionLabel.text = postObject[@"caption"];
    cell.locationLabel.text = postObject[@"location"];
    cell.timeLabel.text = [postObject.createdAt timeAgoSinceNow];
    [cell setPost:postObject];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postsArray.count;
}

- (IBAction)logoutButtonPressed:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [PFUser logOutInBackground];
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if([segue.identifier isEqualToString:@"detailsSegue"]){
         DetailsViewController *detailsViewController = [segue destinationViewController];
         PostCell *cell = sender;
         detailsViewController.cell = cell;
         detailsViewController.post = cell.post;
     }
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
