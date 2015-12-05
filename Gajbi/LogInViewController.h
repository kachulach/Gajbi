//
//  LogInViewController.h
//  Gajbi
//
//  Created by Boris Kachulachki on 12/4/15.
//  Copyright © 2015 Kachulach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogInViewController : UIViewController

typedef NS_ENUM(NSInteger, InputValidationError) {
    PasswordValidationError,
    EmailValidationError
};

@end
