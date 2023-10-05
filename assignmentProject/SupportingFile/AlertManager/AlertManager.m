//
//  AlertManager.m
//  assignmentProject
//
//  Created by Jignesh Patel on 04/10/23.
//

#import "AlertManager.h"

@implementation AlertManager

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
          inViewController:(UIViewController *)viewController {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    
    [alertController addAction:okAction];
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}

@end
