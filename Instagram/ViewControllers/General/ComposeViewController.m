//
//  ComposeViewController.m
//  Instagram
//
//  Created by Nicolas Machado on 7/9/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
//

#import "ComposeViewController.h"
#import "Parse.h"
#import "Post.h"
#import "PhotoMapViewController.h"
#import <MapKit/MapKit.h>


@interface ComposeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong,nonatomic) UIImage *cameraPicture;

//@property (strong, nonatomic) CLLocationCoordinate2D *location;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.captionTextView.layer.borderWidth = 1;
    self.captionTextView.layer.borderColor = [UIColor blackColor].CGColor;
    self.locationButton.layer.cornerRadius = 15;
    self.locationButton.clipsToBounds = YES;
    self.openCameraButton.layer.cornerRadius = 15;
    self.openCameraButton.clipsToBounds = YES;
    self.choosePhotoButton.layer.cornerRadius = 15;
    self.choosePhotoButton.clipsToBounds = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)postButtonPressed:(id)sender {
    NSLog(@"post  pressed???");
    UIImage *image;
    if(self.cameraPicture != nil){
        image = self.cameraPicture;
    }
    NSLog(@"after camera if");
    [Post postUserImage:image withCaption:self.captionTextView.text withLocation:self.address withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        NSLog(@"in completion");
        if (succeeded) {
            NSLog(@"The post was saved!");
            [self performSegueWithIdentifier:@"homeSegue" sender:nil];
        } else {
            NSLog(@"Problem saving message: %@", error.localizedDescription);
        }
    }];
}
- (IBAction)choosePhotoButtonClicked:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}


- (IBAction)openCameraButtonClicked:(id)sender {
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
    
    self.image.image = self.cameraPicture;
    /*
     self.postedPicture.file = self.post.image;
     [self.postedPicture loadInBackground];
     */
//    self.image.file = [self getPFFileFromImage:self.cameraPicture];
//    [self.image loadInBackground];

    
    //postObject[@"image"] = originalImage;
    // Do something with the images (based on your use case)
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
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
    //PhotoMapViewController *photoMapViewController = [segue destinationViewController];
   // photoMapViewController.address = self.address;
 //   photoMapViewController.location = self.location;
}


- (IBAction)captionTextField:(id)sender {
}

- (IBAction)locationTextField:(id)sender {
}
@end
