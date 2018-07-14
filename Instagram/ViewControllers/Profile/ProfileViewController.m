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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self fetchPosts];
    [self setUpUI];
    [self configureObjects];
}

- (void)configureObjects{
    //if user is not null
    self.bioLabel.text = self.user[@"biography"];
    self.nameOfUserLabel.text = self.user[@"profile_name"];
    self.websiteLabel.text = self.user[@"website"];
    
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
    //collection cell layout
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    CGFloat postersPerLine = 3;
    CGFloat itemWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing * (postersPerLine - 1)) / postersPerLine;
    CGFloat itemHeight = 1 * itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    //UI layout
    self.editProfileButton.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:.2f].CGColor;
    self.editProfileButton.layer.borderWidth = 1;
    self.editProfileButton.layer.cornerRadius = 5;
    self.settingsButtonView.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:.2f].CGColor;
    self.settingsButtonView.layer.borderWidth = 1;
    self.settingsButtonView.layer.cornerRadius = 5;
    self.profileImage.layer.cornerRadius = 39;
    self.topView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.bottomView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.topView.layer.borderWidth = 1;
    self.bottomView.layer.borderWidth = 1;
    self.topView.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:.1f].CGColor;
    self.bottomView.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:.1f].CGColor;
}

- (void)fetchPosts{
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    self.user = [PFUser currentUser];
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
        }
        else{
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ProfileCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileCollectionCell" forIndexPath:indexPath];
    cell.layer.masksToBounds = YES;
    Post *postObject = self.picturesArray[indexPath.row];
    cell.profilePost.file = postObject[@"image"];
    [cell.profilePost loadInBackground];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.picturesArray.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
