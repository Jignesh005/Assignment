//
//  profileViewController.h
//  assignmentProject
//
//  Created by Jignesh Patel on 04/10/23.
//

#import <UIKit/UIKit.h>
#import "UserDefaultsManager.h"
#import "UIImageView+WebCache.h"
#import "FirebaseReferenceManager.h"
#import <QuartzCore/QuartzCore.h>

@import Firebase;

NS_ASSUME_NONNULL_BEGIN

@interface profileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;

@property (weak, nonatomic) IBOutlet UIView *weatherCard;

@end

NS_ASSUME_NONNULL_END
