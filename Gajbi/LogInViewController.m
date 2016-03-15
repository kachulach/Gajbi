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
#import "UserService.h"
#import "GlobalUser.h"
#import "AppDelegate.h"

@interface LogInViewController (){
    BOOL _emailIsValid;
    BOOL _passwordIsValid;
}

#pragma mark Outlets
@property (weak, nonatomic) IBOutlet UIView *logInActivityIndicatorWrapperView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *logInProgressActivityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (nonatomic, strong) NSMutableArray *inputErrors;

@end

@implementation LogInViewController

#pragma mark ViewController Lifecycle

static NSString *uidKey = @"uid";

static NSString *storyboardKey = @"Main";
static NSString *dashboardViewControllerID = @"DashboardViewController";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.logInButton.enabled = NO;
    
    self.inputErrors = [NSMutableArray array];
    _emailIsValid = NO;
    _passwordIsValid = NO;
    
    [self setUpTapOnView];
    [self setUpEmailTextField];
    [self setUpPasswordTextField];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = (NSString *)[userDefaults objectForKey:uidKey];
    
    if(uid) {
        [Utility invokeInternetConnectionAction:^{
            [UserService getWithUid:uid successHandler:^(User *user) {
                [GlobalUser loadUser:user];
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIViewController *dashboardViewController = [[UIStoryboard storyboardWithName:storyboardKey bundle:nil] instantiateViewControllerWithIdentifier:dashboardViewControllerID];
                    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
                    appDelegate.window.rootViewController = dashboardViewController;
                });
            } errorHandler:^(NSError *error) {
                NSString *errorDescription = error.localizedDescription;
                UIAlertController *alertController = [Utility getAlertWithTitle:@"Грешка!"
                                                                        message:[NSString stringWithFormat:@"Настана грешка: %@", errorDescription]
                                                                    cancelTitle:@"Затвори"
                                                               cancelCompletion:nil
                                                                        okTitle:nil
                                                                   okCompletion:nil
                                                               destructiveTitle:nil
                                                          destructiveCompletion:nil];
                [self presentViewController:alertController animated:YES completion:nil];
            }];
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Actions

static NSString* logInHomeSegueID = @"LogInHomeSegue";

- (IBAction)logIn:(id)sender {
    if([self validateInput]){
        [self isLoggingIn];
        [UserService logInWithEmail:self.emailTextField.text password:self.passwordTextField.text successHandler:^(NSString *uid){
            [Utility invokeInternetConnectionAction:^{
                [UserService getWithUid:uid successHandler:^(User *user) {
                    [GlobalUser loadUser:user];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self didLogIn];
                        [self performSegueWithIdentifier:logInHomeSegueID sender:self];
                    });
                } errorHandler:^(NSError *error) {
                    [self didLogIn];
                    NSLog(@"%@", error.localizedDescription);
                }];
            }];
            } errorHandler:^(NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertController *alert = [Utility getAlertWithTitle:@"Грешка!"
                                                                  message:error.localizedDescription
                                                              cancelTitle:@"Во ред"
                                                         cancelCompletion:nil
                                                                  okTitle:@"Обидете се повторно"
                                                             okCompletion:^{
                                                                 [self logIn:nil];
                                                             }
                                                         destructiveTitle:nil
                                                    destructiveCompletion:nil];
                    
                    [self presentViewController:alert animated:YES completion:nil];
                    [self didLogIn];
                });
            }
        ];
    } else {
        [Utility showAlertWithErrors:self.inputErrors onParent:self];
    }
    [self.inputErrors removeAllObjects];
}

#pragma mark Gesture Recognizers

-(void)setUpTapOnView{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    gesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:gesture];
}

-(void)viewTapped {
    [self.view endEditing:YES];
}

#pragma mark UI Functionalities

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

#pragma mark Helpers

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

-(void)isLoggingIn {
    self.logInButton.hidden = YES;
    [self.logInProgressActivityIndicator startAnimating];
    self.logInActivityIndicatorWrapperView.hidden = NO;
}

-(void)didLogIn {
    self.logInButton.hidden = NO;
    [self.logInProgressActivityIndicator stopAnimating];
    self.logInActivityIndicatorWrapperView.hidden = YES;
}

@end
