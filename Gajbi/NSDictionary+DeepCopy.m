//
//  NSDictionary+FIrebaseBugFix.m
//  Gajbi
//
//  Created by Boris Kachulachki on 1/24/16.
//  Copyright © 2016 Kachulach. All rights reserved.
//

#import "NSDictionary+DeepCopy.h"

@implementation NSDictionary (DeepCopy)

-(NSDictionary *)mutableDeepCopy {
    return (NSMutableDictionary *)CFBridgingRelease(CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (CFDictionaryRef)self, kCFPropertyListMutableContainers));
}

@end
