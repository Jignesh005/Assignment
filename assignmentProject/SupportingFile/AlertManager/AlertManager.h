//
//  AlertManager.h
//  assignmentProject
//
//  Created by Jignesh Patel on 04/10/23.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlertManager : NSObject

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
          inViewController:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
