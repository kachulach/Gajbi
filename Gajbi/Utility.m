//
//  Utility.m
//  Gajbi
//
//  Created by Boris Kachulachki on 12/6/15.
//  Copyright © 2015 Kachulach. All rights reserved.
//

#import "Utility.h"
#import <Firebase/Firebase.h>

@implementation Utility

+(void)invokeControlledInternetConnectionAction:(void(^)())successHandler errorHandler:(void(^)(NSError *error))errorHandler{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    if([reachability currentReachabilityStatus] == NotReachable){
        //NOTE: implement no internet
        NSLog(@"No internet connection!");
    } else {
        successHandler();
    }
}

static NSString *fireBaseKey = @"FirebaseURL";
+ (Firebase *)getSharedFirebase {
    static dispatch_once_t shared_initialized;
    static Firebase *shared_instance = nil;
    dispatch_once(&shared_initialized, ^ {
        shared_instance = [[Firebase alloc] initWithUrl:[[[NSBundle mainBundle] infoDictionary] objectForKey:fireBaseKey]];
    });
    
    return shared_instance;
}

@end
