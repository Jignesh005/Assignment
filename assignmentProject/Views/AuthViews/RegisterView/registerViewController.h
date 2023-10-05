//
//  registerViewController.h
//  assignmentProject
//
//  Created by Jignesh Patel on 04/10/23.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "AlertManager.h"
#import "FirebaseReferenceManager.h"
#import "UserDefaultsManager.h"
#import "profileViewController.h"
#import "MBProgressHUD.h"
@import FirebaseAuth;
@import FirebaseFirestore;
@import Firebase;

NS_ASSUME_NONNULL_BEGIN

@interface registerViewController : UIViewController {
    UIImage *profileImage;
    NSString *profileImageName;
}

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confpasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *bioTextField;


@end

NS_ASSUME_NONNULL_END
