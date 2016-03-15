//
//  CribService.h
//  Gajbi
//
//  Created by Boris Kachulachki on 1/20/16.
//  Copyright © 2016 Kachulach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CribService : NSObject

+(void)createCribWithDictionary:(NSDictionary *)dictionary successHandler:(void(^)())successHandler errorHandler:(void(^)(NSError *))errorHandler;

+ (void)getAllCribsWithCompletion:(void(^)(NSArray *))successHandler errorHandler:(void(^)())errorHandler;

@end
