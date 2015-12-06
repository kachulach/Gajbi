//
//  LogInViewController.m
//  Gajbi
//
//  Created by Boris Kachulachki on 12/4/15.
//  Copyright © 2015 Kachulach. All rights reserved.
//

#import "LogInViewController.h"
#import "NSString+Validation.h"
#import "Utility.h"
#import <Firebase/Firebase.h>

@interface LogInViewController (){
    BOOL _emailIsValid;
    BOOL _passwordIsValid;
}
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;

@property (nonatomic, strong) NSMutableArray *inputErrors;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.logInButton.enabled = NO;
    
    self.inputErrors = [NSMutableArray array];
    _emailIsValid = NO;
    _passwordIsValid = NO;
    
    [self setUpGestureRecognizer];
    [self setUpEmailTextField];
    [self setUpPasswordTextField];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setUpGestureRecognizer {
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    gesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:gesture];
}

-(void)viewTapped {
    [self.view endEditing:YES];
}

- (void)setUpEmailTextField {
    [self.emailTextField addTarget:self
                  action:@selector(emailTextFieldDidChange)
        forControlEvents:UIControlEventEditingChanged];
}

- (void) emailTextFieldDidChange {
    if(self.emailTextField.text.length > 0){
        _passwordIsValid = YES;
        if(_emailIsValid){
            self.logInButton.enabled = YES;
        }
    } else {
        _passwordIsValid = NO;
        self.logInButton.enabled = NO;
    }
}

- (void)setUpPasswordTextField {
    [self.passwordTextField addTarget:self
                               action:@selector(passwordTextFieldDidChange)
                     forControlEvents:UIControlEventEditingChanged];
}

- (void) passwordTextFieldDidChange {
    if(self.passwordTextField.text.length > 0){
        _emailIsValid = YES;
        if(_passwordIsValid){
            self.logInButton.enabled = YES;
        }
    } else {
        _emailIsValid = NO;
        self.logInButton.enabled = NO;
    }
}

static NSString* showDashboardSegueID = @"ShowDashboardSegue";
- (IBAction)logIn:(id)sender {
    if([self validateInput]){
        Firebase *firebase = [Utility getSharedFirebase];
        [firebase authUser:self.emailTextField.text password:self.passwordTextField.text withCompletionBlock:^(NSError *error, FAuthData *authData) {
            if(error){
                NSLog(@"%@", error.localizedDescription);
            } else {
                [self performSegueWithIdentifier:showDashboardSegueID sender:nil];
            }
        }];
    } else {
        for(NSNumber *errorType in self.inputErrors){
            NSInteger errorInt = errorType.integerValue;
            NSLog(@"%@", [self stringFromErrorType:errorInt]);
        }
    }
    [self.inputErrors removeAllObjects];
}

- (NSString *)stringFromErrorType:(InputValidationError)errorType {
    NSString *errorString;
    switch (errorType) {
        case EmailValidationError:
            errorString = @"Email error!";
            break;
        case PasswordValidationError:
            errorString = @"Password error!";
            break;
        default:
            break;
    }
    return errorString;
}

- (BOOL)validateInput {
    BOOL isValid = YES;
    if(![self.emailTextField.text isValidEmail]){
        isValid = NO;
        [self.inputErrors addObject:[NSNumber numberWithInt:EmailValidationError]];
    }
    if(![self.passwordTextField.text isValidPassword]){
        isValid = NO;
        [self.inputErrors addObject:[NSNumber numberWithInt:PasswordValidationError]];
    }
    
    return isValid;
}

@end
