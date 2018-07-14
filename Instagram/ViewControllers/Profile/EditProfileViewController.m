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

@property (strong,nonatomic) UIImage *cameraPicture;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)setUpUI {
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
}

//update user profile information
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
        NSLog(@"Camera not available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    self.cameraPicture = editedImage;
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenWidth = screenSize.width;
    self.cameraPicture = [self resizeImage:self.cameraPicture withSize:CGSizeMake(screenWidth, screenWidth)];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
