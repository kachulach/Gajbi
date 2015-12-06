//
//  Utility.h
//  Gajbi
//
//  Created by Boris Kachulachki on 12/6/15.
//  Copyright © 2015 Kachulach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@class Firebase;

@interface Utility : NSObject

+(void)invokeControlledInternetConnectionAction:(void(^)())successHandler errorHandler:(void(^)(NSError *error))errorHandler;

+ (Firebase *)getSharedFirebase;
@end
