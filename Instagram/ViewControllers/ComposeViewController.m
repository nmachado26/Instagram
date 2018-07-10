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


@interface ComposeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong,nonatomic) UIImage *cameraPicture;
@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [Post postUserImage:image withCaption:self.captionTextField.text withLocation:self.locationTextField.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)captionTextField:(id)sender {
}

- (IBAction)locationTextField:(id)sender {
}
@end
