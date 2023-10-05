//
//  ViewController.m
//  assignmentProject
//
//  Created by Jignesh Patel on 04/10/23.
//

#import "startViewController.h"
#import "logInViewController.h"

@interface startViewController ()

@end

@implementation startViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([[UserDefaultsManager stringForKey:@"userLogIn"] isEqualToString:@"true"]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        profileViewController *logIn = (profileViewController *)[storyboard instantiateViewControllerWithIdentifier:@"profileViewController"];
        [self.navigationController pushViewController:logIn animated:YES];
    } else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        logInViewController *logIn = (logInViewController *)[storyboard instantiateViewControllerWithIdentifier:@"logInViewController"];
        [self.navigationController pushViewController:logIn animated:YES];
    }

}


@end
