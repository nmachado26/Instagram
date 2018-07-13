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

@interface FeedViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *postsArray;
@property (strong, nonatomic) UIRefreshControl *refreshControl;


@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 272;
    
    [self fetchPosts];
    
    // Initialize a UIRefreshControl
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self fetchPosts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchPosts{
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
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) { //why not NSArray *posts, like ParseChat?
        if(objects != nil){
            self.postsArray = objects;
            [self.tableView reloadData];
            
            // Tell the refreshControl to stop spinning
            [self.refreshControl endRefreshing];
        }
        else{
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}
- (void)onTimer {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
   //[query includeKey:@"author"];
    [query includeKey:@"user"];
    [query includeKey:@"caption"];
    [query includeKey:@"likeCount"];
    [query includeKey:@"commentCount"];
    [query includeKey:@"image"];
    [query includeKey:@"location"];
    query.limit = 20;
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) { //why not NSArray *posts, like ParseChat?
        if(objects != nil){
            self.postsArray = objects;
            [self.tableView reloadData];
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
        cell.usernameTopLabel.text = @"🌮";
        cell.usernameBottomLabel.text = @"🌮";
    }
    cell.captionLabel.text = postObject[@"caption"];
    cell.locationLabel.text = postObject[@"location"];
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
         UINavigationController *navigationController = [segue destinationViewController];
         DetailsViewController *detailsViewController = (DetailsViewController*)navigationController.topViewController;
         PostCell *cell = sender;
         detailsViewController.cell = cell;
         detailsViewController.post = cell.post;
         
     }
//     else{ //compose
//         UINavigationController *navigationController = [segue destinationViewController];
//         ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
//         composeController.delegate = self;
//     }
 }



@end
