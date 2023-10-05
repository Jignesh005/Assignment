//
//  FirebaseReferenceManager.m
//  assignmentProject
//
//  Created by Jignesh Patel on 04/10/23.
//

#import "FirebaseReferenceManager.h"

@implementation FirebaseReferenceManager

+ (instancetype)sharedManager {
    static FirebaseReferenceManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[FirebaseReferenceManager alloc] init];
    });
    return sharedManager;
}

- (FIRFirestore *)rootReference {
    return [FIRFirestore firestore];
}

- (FIRCollectionReference *)userReference {
    FIRFirestore *db = [self rootReference];
    FIRCollectionReference *collRef = [db collectionWithPath:@"users"];
    return collRef;
}

- (FIRStorageReference *)rootStorage {
    return [[FIRStorage storage] reference];
}

- (FIRStorageReference *)userProfileForName:(NSString *)name {
    FIRStorageReference *rootRef = [self rootStorage];
    FIRStorageReference *storageRef = [rootRef child:[NSString stringWithFormat:@"images/%@", name]];
    return storageRef;
}


@end
