//
//  NSString+Validation.m
//  Gajbi
//
//  Created by Boris Kachulachki on 12/4/15.
//  Copyright © 2015 Kachulach. All rights reserved.
//

#import "NSString+Validation.h"
#import "Utility.h"

@implementation NSString (validation)
-(BOOL)isValidEmail {
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

-(BOOL)isValidPassword {
    BOOL isValid = self.length > 5 ? YES : NO;
    return isValid;
}

-(BOOL)isValidName {
    BOOL isValid = self.length > 2 ? YES : NO;
    NSString *emailRegex = @"[a-zA-z]+([ '-][a-zA-Z]+)*$";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    isValid = [nameTest evaluateWithObject:self];
    return isValid;
}

- (BOOL)isValidDate {
    NSDate *dateFormat = [[Utility getDateFormatter] dateFromString:self];
    if(dateFormat) {
        return YES;
    }
    return NO;
}

- (BOOL)isValidNumber {
    NSCharacterSet* nonNumbers = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSRange r = [self rangeOfCharacterFromSet: nonNumbers];
    return r.location == NSNotFound;
}


@end
