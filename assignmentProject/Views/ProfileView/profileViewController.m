//
//  profileViewController.m
//  assignmentProject
//
//  Created by Jignesh Patel on 04/10/23.
//

#import "profileViewController.h"
#import "logInViewController.h"

@interface profileViewController ()

@end

@implementation profileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nameLabel.text = [UserDefaultsManager stringForKey:@"userUsername"];
    self.bioLabel.text = [UserDefaultsManager stringForKey:@"userBio"];
    NSString *name = [UserDefaultsManager stringForKey:@"userId"];
    FIRStorageReference *imageRef = [[FirebaseReferenceManager sharedManager] userProfileForName:[NSString stringWithFormat:@"%@.jpeg",name]];
    [imageRef downloadURLWithCompletion:^(NSURL *URL, NSError *error) {
        if (error) {
            NSLog(@"Error getting download URL: %@", error.localizedDescription);
        } else {
            // URL of the uploaded image
            [self.profileImageView sd_setImageWithURL:URL
                                     placeholderImage:[UIImage imageNamed:@"usericon"]];

        }
    }];
    
    self.weatherCard.layer.borderWidth = 1.0; // Border width
    self.weatherCard.layer.borderColor = [UIColor blackColor].CGColor; // Border color
    self.weatherCard.layer.cornerRadius = 10.0; // Corner radius
    self.weatherCard.layer.masksToBounds = YES;


}

- (IBAction)logoutButtonTapped:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Logout"
                                                                             message:@"Are you sure you want to logout?"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"No"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSError *signOutError;
        BOOL status = [[FIRAuth auth] signOut:&signOutError];
        if (!status) {
            NSLog(@"Error signing out: %@", signOutError);
            return;
        } else {
            NSLog(@"Successfully Signout");
            [UserDefaultsManager setString:@"false" forKey:@"userLogIn"];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            logInViewController *logIn = (logInViewController *)[storyboard instantiateViewControllerWithIdentifier:@"logInViewController"];
            [self.navigationController pushViewController:logIn animated:NO];
        }

    }];
    [alertController addAction:noAction];
    [alertController addAction:yesAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
