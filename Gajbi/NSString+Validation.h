//
//  NSString+Validation.h
//  Gajbi
//
//  Created by Boris Kachulachki on 12/4/15.
//  Copyright © 2015 Kachulach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (validation)
- (BOOL)isValidEmail;
- (BOOL)isValidPassword;
- (BOOL)isValidName;
@end
