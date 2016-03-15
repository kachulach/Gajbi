//
//  ServiceUtility.m
//  Gajbi
//
//  Created by Boris Kachulachki on 12/9/15.
//  Copyright © 2015 Kachulach. All rights reserved.
//

#import "ServiceUtility.h"
#import <Firebase/Firebase.h>

@implementation ServiceUtility

static NSString *fireBaseKey = @"FirebaseRootRef";

+ (Firebase *)getSharedFirebaseRootRef {
    static dispatch_once_t shared_initialized;
    static Firebase *shared_instance = nil;
    dispatch_once(&shared_initialized, ^ {
        shared_instance = [[Firebase alloc] initWithUrl:[[[NSBundle mainBundle] infoDictionary] objectForKey:fireBaseKey]];
    });
    
    return shared_instance;
}

@end
