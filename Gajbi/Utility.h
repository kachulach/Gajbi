//
//  Utility.h
//  Gajbi
//
//  Created by Boris Kachulachki on 12/6/15.
//  Copyright © 2015 Kachulach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@class UIAlertController;
@class Firebase;
@class UIViewController;

@interface Utility : NSObject

typedef NS_ENUM(NSInteger, InputValidationError) {
    NameValidationError,
    SurnameValidationError,
    PasswordValidationError,
    EmailValidationError,
    DifferentPasswordsValidationError,
    BirthdayValidationError,
    WrongOldPasswordError,
    InvalidPlaceError,
    InvalidPriceError,
    InvalidToPriceError,
    InvalidFromPriceError,
    InvalidAreaError,
    InvalidFromAreaError,
    InvalidToAreaError,
    InvalidFloorError
};

+ (void)invokeInternetConnectionAction:(void(^)())successHandler;

+ (UIAlertController *)getAlertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelCompletion:(void(^)())cancelCompletion okTitle:(NSString *)okTitle okCompletion:(void(^)())okCompletion destructiveTitle:(NSString *)destructiveTitle destructiveCompletion:(void(^)())destructiveCompletion;

+ (NSDateFormatter *)getDateFormatter;

+ (void)showAlertWithErrors:(NSArray *)errors onParent:(UIViewController *)parent;

@end
