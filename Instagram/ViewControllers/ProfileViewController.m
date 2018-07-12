//
//  ProfileViewController.m
//  Instagram
//
//  Created by Nicolas Machado on 7/10/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileCollectionCell.h"

@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *picturesArray;
@property (nonatomic, strong) NSArray *userArray;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self fetchPosts];
    [self setUpUI];
    [self configureObjects];
    
}

//is this necessary?
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self fetchPosts];
    [self setUpUI];
    [self configureObjects];
}

- (void)configureObjects{
//    if(self.user != NSNull){
        self.bioLabel.text = self.user[@"biography"];
        self.nameOfUserLabel.text = self.user[@"profile_name"];
        self.websiteLabel.text = self.user[@"website"];
        //if data is not null
    if(self.user[@"profile_image"] != nil){
    self.profileImage.file = self.user[@"profile_image"];
    [self.profileImage loadInBackground];
    }
    else{
     self.profileImage.image = [UIImage imageNamed:@"my-button"];
    }
    //else put stock image

}
- (void)setUpUI{
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    CGFloat postersPerLine = 3;
    CGFloat itemWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing * (postersPerLine - 1)) / postersPerLine;
    CGFloat itemHeight = 1 * itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    self.editProfileButton.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:.2f].CGColor;
    self.editProfileButton.layer.borderWidth = 1;
    self.editProfileButton.layer.cornerRadius = 5;
    self.settingsButtonView.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:.2f].CGColor;
    self.settingsButtonView.layer.borderWidth = 1;
    self.settingsButtonView.layer.cornerRadius = 5;
    self.profileImage.layer.cornerRadius = 42;
}

- (void)fetchPosts{
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    self.user = [PFUser currentUser];
    //[query includeKey:@"author"];
    [query includeKey:@"author"];
    [query includeKey:@"caption"];
    [query includeKey:@"likeCount"];
    [query includeKey:@"commentCount"];
    [query includeKey:@"image"];
    [query whereKey:@"author" equalTo:self.user];
    query.limit = 20;
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) { //why not NSArray *posts, like ParseChat?
        if(objects != nil){
            self.picturesArray = objects;
            [self.collectionView reloadData];
            
            // Tell the refreshControl to stop spinning
            //[self.refreshControl endRefreshing];
        }
        else{
            NSLog(@"%@", error.localizedDescription);
        }
    }];
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

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ProfileCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileCollectionCell" forIndexPath:indexPath];
    cell.layer.masksToBounds = YES;
    
    Post *postObject = self.picturesArray[indexPath.row];
    PFUser *user = postObject[@"author"];
    cell.profilePost.file = postObject[@"image"];
    [cell.profilePost loadInBackground];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.picturesArray.count;
}

- (IBAction)editProfileButtonPressed:(id)sender {
    
}

@end
