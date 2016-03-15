//
//  CribService.m
//  Gajbi
//
//  Created by Boris Kachulachki on 1/20/16.
//  Copyright © 2016 Kachulach. All rights reserved.
//

#import "CribService.h"
#import "ServiceUtility.h"
#import <Firebase/Firebase.h>
#import "Crib.h"
#import "User.h"
#import "NSDictionary+DeepCopy.h"

@implementation CribService

static NSString *cribCidPath = @"cribs/%@/%@";

+(void)createCribWithDictionary:(NSDictionary *)dictionary successHandler:(void(^)())successHandler errorHandler:(void(^)(NSError *))errorHandler {
    
    Firebase *cribRef = [[ServiceUtility getSharedFirebaseRootRef] childByAppendingPath:[NSString stringWithFormat:cribCidPath, dictionary[[Crib uidKey]], dictionary[[Crib cidKey]]]];
    [cribRef setValue:dictionary withCompletionBlock:^(NSError *error, Firebase *ref) {
        if(error) {
            errorHandler(error);
        } else {
            successHandler();
        }
    }];
}

static NSString *cribsPath = @"cribs";

+ (void)getAllCribsWithCompletion:(void(^)(NSArray *))successHandler errorHandler:(void(^)())errorHandler {
    Firebase* userRef = [[ServiceUtility getSharedFirebaseRootRef] childByAppendingPath:cribsPath];
    [userRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if(snapshot.exists) {
            NSMutableArray *cribs = [NSMutableArray array];
            for(FDataSnapshot *userSnapshot in snapshot.children) {
                for(FDataSnapshot *cribSnapshot in userSnapshot.children) {
                    Crib *crib = [[Crib alloc] initWithSnapshot:cribSnapshot];
                    [cribs addObject:crib];
                }
            }
            successHandler(cribs);
        }
    }];
}

@end
