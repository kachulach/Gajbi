//
//  ServiceUtility.h
//  Gajbi
//
//  Created by Boris Kachulachki on 12/9/15.
//  Copyright © 2015 Kachulach. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Firebase;

@interface ServiceUtility : NSObject

+ (Firebase *)getSharedFirebaseRootRef;

@end
