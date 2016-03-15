//
//  GlobalUser.m
//  Gajbi
//
//  Created by Boris Kachulachki on 1/5/16.
//  Copyright © 2016 Kachulach. All rights reserved.
//

#import "GlobalUser.h"
#import "User.h"

@implementation GlobalUser

static User * _user = nil;

static NSString *uidKey = @"uid";

+ (void)loadUser:(User *)user {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:user.uid forKey:uidKey];
    _user = user;
}

+ (void)unloadUser {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:uidKey];
    _user = nil;
}

+ (User *)getUser {
    return _user;
}

@end
