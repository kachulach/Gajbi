//
//  GlobalUser.h
//  Gajbi
//
//  Created by Boris Kachulachki on 1/5/16.
//  Copyright © 2016 Kachulach. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface GlobalUser : NSObject

+ (void)loadUser:(User *)user;
+ (void)unloadUser;
+ (User *)getUser;

@end
