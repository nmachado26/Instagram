//
//  EditProfileViewController.m
//  Instagram
//
//  Created by Nicolas Machado on 7/11/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
//

#import "EditProfileViewController.h"
#import "ProfileViewController.h"

@interface EditProfileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong,nonatomic) UIImage *cameraPicture;

@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UIView *line3;
@property (weak, nonatomic) IBOutlet UIView *line4;
@property (weak, nonatomic) IBOutlet UIView *line5;
@property (weak, nonatomic) IBOutlet UIView *line6;
@property (weak, nonatomic) IBOutlet UIView *line7;
@property (weak, nonatomic) IBOutlet UIView *line8;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;


@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.biographyTextView.layer.borderWidth = 1;
    self.biographyTextView.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:.1f].CGColor;
    self.profilePicture.layer.cornerRadius = 37;
    self.profilePicture.clipsToBounds = YES;
    self.biographyTextView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.view4.layer.borderWidth = 1;
    self.view4.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.view4.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:.1f].CGColor;
    
    self.line1.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:.1f].CGColor;
    self.line2.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:.1f].CGColor;
    self.line3.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:.1f].CGColor;
    self.line4.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:.1f].CGColor;
    self.line5.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:.1f].CGColor;
    self.line6.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:.1f].CGColor;
    self.line7.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:.1f].CGColor;
    self.line8.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:.1f].CGColor;

    
    /*
    self.editProfileButton.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:.2f].CGColor;
     self.editProfileButton.layer.borderWidth = 1;
     self.editProfileButton.layer.cornerRadius = 5;
     self.settingsButtonView.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:.2f].CGColor;
     self.settingsButtonView.layer.borderWidth = 1;
     self.settingsButtonView.layer.cornerRadius = 5;
     self.profileImage.layer.cornerRadius = 39;
     //self.usernameTextField.layer.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.1f].CGColor;
     self.topView.layer.backgroundColor = [UIColor whiteColor].CGColor;
     self.bottomView.layer.backgroundColor = [UIColor whiteColor].CGColor;
     self.topView.layer.borderWidth = 1;
     self.bottomView.layer.borderWidth = 1;
     self.topView.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:.1f].CGColor;
     self.bottomView.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:.1f].CGColor;
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)doneButtonPressed:(id)sender {
    PFUser *user = [PFUser currentUser];
    self.biography = self.biographyTextView.text;
    self.website = self.websiteTextField.text;
    self.name = self.nameTextField.text;
    if(self.cameraPicture != nil){
        user[@"profile_image"] = [self getPFFileFromImage:self.cameraPicture];
    }
    if(![self.biography isEqualToString:@""]){
    user[@"biography"] = self.biography;
    }
    if(![self.website isEqualToString:@""]){
    user[@"website"] = self.website;
    }
    if(![self.name isEqualToString:@""]){
    user[@"profile_name"] = self.name;
    }
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(error){
            NSLog(@"error");
        }
        else{
            NSLog(@"success");
        }
    }];
    
    [self dismissViewControllerAnimated:true completion:nil];
}

- (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image {
    
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

- (IBAction)choosePictureButtonPressed:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (IBAction)takePictureButtonPressed:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    self.cameraPicture = editedImage;
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenWidth = screenSize.width;
    self.cameraPicture = [self resizeImage:self.cameraPicture withSize:CGSizeMake(screenWidth, screenWidth)];
    //postObject[@"image"] = originalImage;
    // Do something with the images (based on your use case)
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    ProfileViewController *profileViewController = [segue destinationViewController];
//    profileViewController.bioLabel.text = self.biographyTextView.text;
//    profileViewController.websiteLabel.text = self.websiteTextField.text;
//    profileViewController.nameLabel.text = self.nameTextField.text;
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end