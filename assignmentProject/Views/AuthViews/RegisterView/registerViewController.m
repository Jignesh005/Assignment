//
//  registerViewController.m
//  assignmentProject
//
//  Created by Jignesh Patel on 04/10/23.
//

#import "registerViewController.h"


@interface registerViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation registerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - For Profile Picture

- (IBAction)showImagePickerActionSheet:(id)sender {
    [self.view endEditing:true];
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil
                                                                         message:nil
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Take Photo"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
                                                             [self openCamera];
                                                         }];

    UIAlertAction *galleryAction = [UIAlertAction actionWithTitle:@"Choose from Library"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              [self openPhotoLibrary];
                                                          }];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];

    [actionSheet addAction:cameraAction];
    [actionSheet addAction:galleryAction];
    [actionSheet addAction:cancelAction];

    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void)openCamera {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else {
        // Handle the case where the device doesn't have a camera
    }
}

- (void)openPhotoLibrary {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (NSString *)generateRandomImageName {
    // Generate a random string
    NSString *randomString = [NSString stringWithFormat:@"%08X%08X", arc4random(), arc4random()];
    
    // Get the current timestamp as a string
    NSString *timestamp = [NSString stringWithFormat:@"%lld", (long long)([[NSDate date] timeIntervalSince1970] * 1000)];
    
    // Combine the random string and timestamp to create a unique name
    NSString *imageName = [NSString stringWithFormat:@"%@_%@.jpg", timestamp, randomString];
    
    return imageName;
}

- (void)uploadImageToFirebaseStorage:(UIImage *)image withName:(NSString *)name withCompletion:(void (^)(NSURL * _Nullable downloadURL, NSError * _Nullable error))completion {
    FIRStorageReference *imageRef = [[FirebaseReferenceManager sharedManager] userProfileForName:name];
    // Convert the UIImage to NSData
    NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
    
    // Create metadata for the image (optional)
    FIRStorageMetadata *metadata = [[FIRStorageMetadata alloc] init];
    metadata.contentType = @"image/jpeg";
    
    // Upload the image
    [imageRef putData:imageData
             metadata:metadata
           completion:^(FIRStorageMetadata *metadata, NSError *error) {
        if (error) {
            // Handle the error
            NSLog(@"Error uploading image: %@", error.localizedDescription);
            completion(nil, error);
        } else {
            // Image uploaded successfully,
            completion(nil, error);
        }
    }];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // Handle the selected image as needed, e.g., display it or save it.
    profileImage = info[UIImagePickerControllerOriginalImage];
    self.profileImageView.image = profileImage;
    profileImageName = [self generateRandomImageName];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - For Sign up user
- (IBAction)signupButtonClick:(id)sender {
    [self.view endEditing:true];
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *confpassword = self.confpasswordTextField.text;
    NSString *username = self.usernameTextField.text;
    NSString *bio = self.bioTextField.text;

    if ([email isEqualToString:@""]) {
        [AlertManager showAlertWithTitle:@"Email"
                                 message:@"Please enter email."
                        inViewController:self];

    } else if ([password isEqualToString:@""]) {
        [AlertManager showAlertWithTitle:@"Password"
                                 message:@"Please enter password."
                        inViewController:self];

    } else if ([confpassword isEqualToString:@""]) {
        [AlertManager showAlertWithTitle:@"Password"
                                 message:@"Please enter confirm password."
                        inViewController:self];

    } else if (![password isEqualToString:confpassword]) {
        [AlertManager showAlertWithTitle:@"Password"
                                 message:@"Check your confirm password."
                        inViewController:self];

    } else if ([username isEqualToString:@""]) {
        [AlertManager showAlertWithTitle:@"Username"
                                 message:@"Please enter username."
                        inViewController:self];

    } else if ([bio isEqualToString:@""]) {
        [AlertManager showAlertWithTitle:@"Bio"
                                 message:@"Please enter short bio."
                        inViewController:self];

    } else {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self createUser];
    }
}

-(void)createUser {
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *username = self.usernameTextField.text;
    NSString *bio = self.bioTextField.text;

    FIRAuth *auth = [FIRAuth auth];
    [auth createUserWithEmail:email
                     password:password
                   completion:^(FIRAuthDataResult * _Nullable authResult,
                                NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error registering user: %@", error.localizedDescription);
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });

            [AlertManager showAlertWithTitle:@"Error"
                                     message:error.localizedDescription
                            inViewController:self];

        } else {
            NSLog(@"User registered and signed in!");
            // Navigate to the next screen or perform other actions.
            NSString *uid = authResult.user.uid;
            
            FIRCollectionReference *docRef = [[FirebaseReferenceManager sharedManager] userReference];

            if (self->profileImage != nil) {
                [self uploadImageToFirebaseStorage:self->profileImage withName:[NSString stringWithFormat:@"%@.jpeg",uid] withCompletion:^(NSURL * _Nullable downloadURL, NSError * _Nullable error) {
                    if (error) {
                        NSLog(@"Error upload user profile image: %@", error.localizedDescription);
                    } else {
                        NSDictionary *userData = @{
                            @"email": email,
                            @"username": username,
                            @"bio": bio,
                        };
                        
                        [[docRef documentWithPath:uid] setData:userData completion:^(NSError * _Nullable error) {
                            if (error != nil) {
                                NSLog(@"Error writing document: %@", error);
                            } else {
                                NSLog(@"Document successfully written!");
                                
                                [UserDefaultsManager setString:uid forKey:@"userId"];
                                [UserDefaultsManager setString:email forKey:@"userEmail"];
                                [UserDefaultsManager setString:username forKey:@"userUsername"];
                                [UserDefaultsManager setString:bio forKey:@"userBio"];
                                [UserDefaultsManager setString:@"true" forKey:@"userLogIn"];
                                
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                                });
                                
                                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                profileViewController *logIn = (profileViewController *)[storyboard instantiateViewControllerWithIdentifier:@"profileViewController"];
                                [self.navigationController pushViewController:logIn animated:YES];
                            }
                        }];
                    }
                }];
            } else {
                
                NSDictionary *userData = @{
                    @"email": email,
                    @"username": username,
                    @"bio": bio,
                };
                
                [[docRef documentWithPath:uid] setData:userData completion:^(NSError * _Nullable error) {
                    if (error != nil) {
                        NSLog(@"Error writing document: %@", error);
                    } else {
                        NSLog(@"Document successfully written!");
                        
                        [UserDefaultsManager setString:uid forKey:@"userId"];
                        [UserDefaultsManager setString:email forKey:@"userEmail"];
                        [UserDefaultsManager setString:username forKey:@"userUsername"];
                        [UserDefaultsManager setString:bio forKey:@"userBio"];
                        [UserDefaultsManager setString:@"true" forKey:@"userLogIn"];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                        });
                        
                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                        profileViewController *logIn = (profileViewController *)[storyboard instantiateViewControllerWithIdentifier:@"profileViewController"];
                        [self.navigationController pushViewController:logIn animated:YES];
                    }
                }];
            }
        }
    }];
}
@end
