//
//  Utility.m
//  Gajbi
//
//  Created by Boris Kachulachki on 12/6/15.
//  Copyright © 2015 Kachulach. All rights reserved.
//

#import "Utility.h"
#import <Firebase/Firebase.h>
#import <UIKit/UIKit.h>

@implementation Utility

+(void)invokeInternetConnectionAction:(void(^)())successHandler {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    if([reachability currentReachabilityStatus] == NotReachable){
        [self getAlertWithTitle:@"Грешка!" message:@"Немате активна интернет конекција."
                    cancelTitle:@"Во ред" cancelCompletion:nil
                        okTitle:@"Обидете се повторно" okCompletion:^{
                            //NOTE: implement try again
                        } destructiveTitle:nil destructiveCompletion:nil];
    } else {
        successHandler();
    }
}

+ (UIAlertController *)getAlertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelCompletion:(void(^)())cancelCompletion okTitle:(NSString *)okTitle okCompletion:(void(^)())okCompletion destructiveTitle:(NSString *)destructiveTitle destructiveCompletion:(void(^)())destructiveCompletion {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if(cancelTitle) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if(cancelCompletion) {
                cancelCompletion();
            }
        }];
        [alertController addAction:cancelAction];
    }
    if(okTitle) {
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:okTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if(okCompletion) {
                okCompletion();
            }
        }];
        [alertController addAction:okAction];
    }
    if(destructiveTitle) {
        UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            if(destructiveCompletion) {
                destructiveCompletion();
            }
        }];
        [alertController addAction:destructiveAction];
    }
    return alertController;
}

+ (NSDateFormatter *)getDateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:@"d MMMM YYYY"];
    
    return dateFormatter;
}

+ (void)showAlertWithErrors:(NSArray *)errors onParent:(UIViewController *)parent {
    NSString *errorsString = @"";
    for(NSNumber *errorType in errors){
        NSInteger errorInt = errorType.integerValue;
        errorsString = [errorsString stringByAppendingString:@"\n"];
        errorsString = [errorsString stringByAppendingString:[self stringFromErrorType:errorInt]];
    }
    UIAlertController *alert = [Utility getAlertWithTitle:@"Невалидни податоци!"
                                                  message:errorsString
                                              cancelTitle:@"Обидете се повторно"
                                         cancelCompletion:nil
                                                  okTitle:nil
                                             okCompletion:nil
                                         destructiveTitle:nil
                                    destructiveCompletion:nil];
    
    [parent presentViewController:alert animated:YES completion:nil];
}

+ (NSString *)stringFromErrorType:(InputValidationError)errorType {
    NSString *errorString;
    switch (errorType) {
        case NameValidationError:
            errorString = @"Внесовте невалидно име.";
            break;
        case SurnameValidationError:
            errorString = @"Внесовте невалидно презиме.";
            break;
        case EmailValidationError:
            errorString = @"Внесовте невалидна е-пошта.";
            break;
        case PasswordValidationError:
            errorString = @"Внесовте невалидна лозинка.";
            break;
        case DifferentPasswordsValidationError:
            errorString = @"Внесовте различна лозинка за потврда.";
            break;
        case BirthdayValidationError:
            errorString = @"Внесовте невалидна дата на раѓање";
            break;
        case WrongOldPasswordError:
            errorString = @"Внесовте погрешна стара лозинка";
            break;
        case InvalidPlaceError:
            errorString = @"Внесовте невалидно место";
            break;
        case InvalidPriceError:
            errorString = @"Внесовте невалидна цена";
            break;
        case InvalidToPriceError:
            errorString = @"Внесовте невалидна \"До:\" цена";
            break;
        case InvalidFromPriceError:
            errorString = @"Внесовте невалидна \"Од:\" цена";
            break;
        case InvalidAreaError:
            errorString = @"Внесовте невалидна квадратура";
            break;
        case InvalidToAreaError:
            errorString = @"Внесовте невалидна \"До:\" квадратура";
            break;
        case InvalidFromAreaError:
            errorString = @"Внесовте невалидна \"Од:\" квадратура";
            break;
        case InvalidFloorError:
            errorString = @"Внесовте невалиден кат";
            break;
        default:
            break;
    }
    return errorString;
}

@end
