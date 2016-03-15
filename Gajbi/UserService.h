//
//  UserService.h
//  Gajbi
//
//  Created by Boris Kachulachki on 12/8/15.
//  Copyright © 2015 Kachulach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@class FAuthData;

@interface UserService : NSObject

+ (void)getWithUid:(NSString *)uid successHandler:(void(^)(User *))successHandler errorHandler:(void(^)())errorHandler;

+ (void)updateWithDictionary:(NSDictionary *)dictionary forUid:(NSString *)uid;

+ (void)logInWithEmail:(NSString *)email password:(NSString *)password successHandler:(void (^)(NSString *))successHandler errorHandler:(void (^)(NSError *))errorHandler;

+ (void)signUpWithDictionary:(NSDictionary *)dictionary successHandler:(void (^)(NSString *))successHandler errorHandler:(void (^)(NSError *))errorHandler;

+ (void)changePasswordWithEmail:(NSString *)email oldPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword successHandler:(void(^)())successHandler errorHandler:(void(^)(NSError *error))errorHandler;

+ (void)changeEmailWithEmail:(NSString *)email password:(NSString *)password newEmail:(NSString *)newEmail succsessHandler:(void(^)())successHandler errorHandler:(void(^)(NSError *error))errorHandler;

+ (void)removeWithUser:(User *)user successHandler:(void(^)())successHandler errorHandler:(void(^)(NSError *error))errorHandler;

@end
