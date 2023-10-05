//
//  UserDefaultsManager.h
//  assignmentProject
//
//  Created by Jignesh Patel on 04/10/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserDefaultsManager : NSObject
+ (void)setInteger:(NSInteger)value forKey:(NSString *)key;
+ (NSInteger)integerForKey:(NSString *)key;

+ (void)setString:(NSString *)value forKey:(NSString *)key;
+ (NSString *)stringForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
