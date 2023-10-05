//
//  logInViewController.m
//  assignmentProject
//
//  Created by Jignesh Patel on 04/10/23.
//

#import "logInViewController.h"
#import "registerViewController.h"

@interface logInViewController ()

@end

@implementation logInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//Log in button action
- (IBAction)loginButtonTapped:(id)sender {
    [self.view endEditing:true];
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;

    
    
    if ([email isEqualToString:@""]) {
        // Authentication successful, navigate to the next screen or perform the desired action
        NSLog(@"Enter Email");
        [AlertManager showAlertWithTitle:@"Email"
                                 message:@"Please enter email."
                        inViewController:self];

    } else if ([password isEqualToString:@""]) {
        [AlertManager showAlertWithTitle:@"Password"
                                 message:@"Please enter password."
                        inViewController:self];

    } else {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        FIRAuth *auth = [FIRAuth auth];
        [auth signInWithEmail:email
                     password:password
                   completion:^(FIRAuthDataResult * _Nullable authResult,
                                NSError * _Nullable error) {
            if (error) {
                NSLog(@"Error signing in: %@", error.localizedDescription);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                });

                [AlertManager showAlertWithTitle:@"Error"
                                         message:@"Invalid email or password"
                                inViewController:self];

            } else {
                NSLog(@"User signed in!");
                // Navigate to the next screen or perform other actions.
                
                // Get the authenticated user's UID
                NSString *uid = authResult.user.uid;
                
                FIRDocumentReference *docRef = [[[FirebaseReferenceManager sharedManager] userReference] documentWithPath:uid];

                [docRef getDocumentWithCompletion:^(FIRDocumentSnapshot *snapshot, NSError *error) {
                  if (snapshot.exists) {
                    // Document data may be nil if the document exists but has no keys or values.
                      NSDictionary *userData = snapshot.data;
                      NSLog(@"User Data: %@", userData);

                      NSString *email = [userData valueForKey:@"email"];
                      NSString *username = [userData valueForKey:@"username"];
                      NSString *bio = [userData valueForKey:@"bio"];
                      
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

                  } else {
                    NSLog(@"Document does not exist");
                  }
                }];
            }
        }];
    }
}

//Register in button action
- (IBAction)registerButtonTapped:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    registerViewController *registerVC = (registerViewController *)[storyboard instantiateViewControllerWithIdentifier:@"registerViewController"];
    [self.navigationController pushViewController:registerVC animated:YES];
}


@end
