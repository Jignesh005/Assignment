//
//  FirebaseReferenceManager.h
//  assignmentProject
//
//  Created by Jignesh Patel on 04/10/23.
//

#import <Foundation/Foundation.h>
@import Firebase;
@import FirebaseFirestore;

NS_ASSUME_NONNULL_BEGIN

@interface FirebaseReferenceManager : NSObject
+ (instancetype)sharedManager;
- (FIRFirestore *)rootReference;
- (FIRCollectionReference *)userReference;
- (FIRStorageReference *)rootStorage;
- (FIRStorageReference *)userProfileForName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
