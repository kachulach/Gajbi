//
//  UserService.m
//  Gajbi
//
//  Created by Boris Kachulachki on 12/8/15.
//  Copyright © 2015 Kachulach. All rights reserved.
//

#import "UserService.h"
#import <Firebase/Firebase.h>
#import "ServiceUtility.h"

@implementation UserService

static NSString *emptyString = @"";

static NSString *userPath = @"users/%@";

+ (void)getWithUid:(NSString *)uid successHandler:(void(^)(User *))successHandler errorHandler:(void(^)())errorHandler {
    Firebase* userRef = [[ServiceUtility getSharedFirebaseRootRef] childByAppendingPath:[NSString stringWithFormat:userPath, uid]];
    [userRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if(snapshot.exists) {
            User *user = [[User alloc] initWithSnapshot:snapshot];
            successHandler(user);
        } else {
            errorHandler();
        }
    }];
}

+ (void)updateWithDictionary:(NSDictionary *)dictionary forUid:(NSString *)uid {
    Firebase* userRef = [[ServiceUtility getSharedFirebaseRootRef] childByAppendingPath:[NSString stringWithFormat:userPath, uid]];
    [userRef updateChildValues:dictionary];
}

+ (void)logInWithEmail:(NSString *)email password:(NSString *)password successHandler:(void (^)(NSString *))successHandler errorHandler:(void (^)(NSError *))errorHandler {
    Firebase *rootRef = [ServiceUtility getSharedFirebaseRootRef];
    [rootRef authUser:email password:password withCompletionBlock:^(NSError *error, FAuthData *authData) {
        if(error) {
            errorHandler(error);
        } else {
            successHandler(authData.uid);
        }
    }];
}

+ (void)signUpWithDictionary:(NSDictionary *)dictionary successHandler:(void (^)(NSString *))successHandler errorHandler:(void (^)(NSError *))errorHandler {
    Firebase *ref = [ServiceUtility getSharedFirebaseRootRef];
    NSString *email = dictionary[[User emailKey]];
    NSString *password = dictionary[[User passwordKey]];
    NSString *name = dictionary[[User nameKey]];
    NSString *surname = dictionary[[User surnameKey]];
    NSInteger birthdayTimestamp = [dictionary[[User birthdayTimestampKey]] integerValue];
    
    NSNumber *sexNumber = dictionary[[User sexKey]];
    Sex sex = sexNumber.integerValue;
    
    [ref createUser:email password:password withValueCompletionBlock:^(NSError *error, NSDictionary *result) {
        if(error) {
            Firebase *ref = [ServiceUtility getSharedFirebaseRootRef];
            [ref removeUser:email password:password withCompletionBlock:nil];
            errorHandler(error);
        } else {
            NSString *uid = result[[User uidKey]];
            
            User *user = [[User alloc] initWithUid:uid email:email password:password name:name surname:surname birthdayTimestamp:birthdayTimestamp sex:sex aboutMe:emptyString likes:emptyString dislikes:emptyString tolerations:emptyString numberOfCribs:0];
            
            NSDictionary *dictionaryUser = [user toDictionary];
            [self createUserRef:dictionaryUser];
            
            successHandler(uid);
        }
    }];
}

+ (void)createUserRef:(NSDictionary *)userDictionary {
    
    Firebase *userRef = [[ServiceUtility getSharedFirebaseRootRef] childByAppendingPath:[NSString stringWithFormat:userPath, userDictionary[[User uidKey]]]];
    
    [userRef setValue:userDictionary];
}

+ (void)changePasswordWithEmail:(NSString *)email oldPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword successHandler:(void(^)())successHandler errorHandler:(void(^)(NSError *error))errorHandler {
    Firebase *ref = [ServiceUtility getSharedFirebaseRootRef];
    [ref changePasswordForUser:email fromOld:oldPassword toNew:newPassword withCompletionBlock:^(NSError *error) {
        if(error) {
            errorHandler(error);
        } else {
            successHandler();
        }
    }];
}

+ (void)changeEmailWithEmail:(NSString *)email password:(NSString *)password newEmail:(NSString *)newEmail succsessHandler:(void(^)())successHandler errorHandler:(void(^)(NSError *error))errorHandler {
    Firebase *ref = [ServiceUtility getSharedFirebaseRootRef];
    [ref changeEmailForUser:email password:password toNewEmail:newEmail withCompletionBlock:^(NSError *error) {
        if(error) {
            errorHandler(error);
        } else {
            successHandler();
        }
    }];
}

+ (void)removeWithUser:(User *)user successHandler:(void(^)())successHandler errorHandler:(void(^)(NSError *error))errorHandler {
    Firebase *ref = [ServiceUtility getSharedFirebaseRootRef];
    [ref removeUser:user.email password:user.password withCompletionBlock:^(NSError *error) {
        if(error) {
            errorHandler(error);
        } else {
            Firebase *userRef = [[ServiceUtility getSharedFirebaseRootRef] childByAppendingPath:[NSString stringWithFormat:userPath, user.uid]];
            [userRef removeValue];
            
            successHandler();
        }
    }];
}


@end
