//
//  logInViewController.h
//  assignmentProject
//
//  Created by Jignesh Patel on 04/10/23.
//

#import <UIKit/UIKit.h>
@import FirebaseAuth;
@import FirebaseFirestore;
#import "FirebaseReferenceManager.h"
#import "AlertManager.h"
#import "UserDefaultsManager.h"
#import "profileViewController.h"
#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface logInViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


- (IBAction)loginButtonTapped:(id)sender;
@end

NS_ASSUME_NONNULL_END
