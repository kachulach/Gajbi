//
//  NSDictionary+FIrebaseBugFix.h
//  Gajbi
//
//  Created by Boris Kachulachki on 1/24/16.
//  Copyright © 2016 Kachulach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (DeepCopy)
- (NSDictionary*)mutableDeepCopy;
@end
