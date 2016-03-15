//
//  SignUpViewController.m
//  Gajbi
//
//  Created by Boris Kachulachki on 12/4/15.
//  Copyright © 2015 Kachulach. All rights reserved.
//

#import "SignUpViewController.h"
#import "NSString+Validation.h"
#import <Firebase/Firebase.h>
#import "Utility.h"
#import "User.h"
#import "UserService.h"
#import "ServiceUtility.h"
#import "GlobalUser.h"

@interface SignUpViewController ()

#pragma mark Outlets
@property (weak, nonatomic) IBOutlet UIView *signUpActivityIndicatorWrapperView;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *signUpProgressActivityIndicator;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *surnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirmTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sexSegmentedControl;
@property (weak, nonatomic) IBOutlet UITextField *birthdayTextField;

@property (strong, nonatomic) UIDatePicker *datePicker;

@property (nonatomic, strong) NSMutableArray *inputErrors;

@end

@implementation SignUpViewController

#pragma mark ViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    
    [self setUpGestureRecognizer];
    [self setUpBirthdayTextField];
    
    self.inputErrors = [NSMutableArray array];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Actions

static NSString* signUpHomeSegueID = @"SignUpHomeSegue";

- (IBAction)signUp:(id)sender {
    if([self validateInput]){
        NSDate *birthday = [[Utility getDateFormatter] dateFromString:self.birthdayTextField.text];
        NSInteger nowTimeInterval = (NSInteger)[birthday timeIntervalSince1970];
        NSNumber *birthdayTimestampNumber = [NSNumber numberWithInteger:nowTimeInterval];
        
        NSNumber *sex = [NSNumber numberWithInt:[self.sexSegmentedControl selectedSegmentIndex] == 0 ? Male : Female];
        NSDictionary *dictionary = @{
                                     [User emailKey] : self.emailTextField.text,
                                     [User passwordKey] : self.passwordTextField.text,
                                     [User nameKey] : self.nameTextField.text,
                                     [User surnameKey] : self.surnameTextField.text,
                                     [User birthdayTimestampKey] : birthdayTimestampNumber,
                                     [User sexKey] : sex
                                     };
        [self isSigningUp];
        [Utility invokeInternetConnectionAction:^{
            [UserService signUpWithDictionary:dictionary successHandler:^(NSString *uid){
                UIAlertController *alert = [Utility getAlertWithTitle:@"Успешна регистрација!"
                                                              message:[NSString stringWithFormat:@"Почитуван %@, добредојде во Гајби!", self.nameTextField.text]
                                                          cancelTitle:nil
                                                     cancelCompletion:nil
                                                              okTitle:@"Продолжи..."
                                                         okCompletion:^{
                                                             [UserService getWithUid:uid successHandler:^(User *user) {
                                                                 [GlobalUser loadUser:user];
                                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                                     [self performSegueWithIdentifier:signUpHomeSegueID sender:self];
                                                                 });
                                                             } errorHandler:^() {
                                                                 //DO ERROR HANDLE!
                                                             }];
                                                         }
                                                     destructiveTitle:nil
                                                destructiveCompletion:nil];
                [self didSignUp];
                [self presentViewController:alert animated:YES completion:nil];
            } errorHandler:^(NSError *error) {
                NSString *errorDescription = error.localizedDescription;
                UIAlertController *alert = [Utility getAlertWithTitle:@"Грешка!"
                                                              message:[NSString stringWithFormat:@"Неуспешна регистрација: %@", errorDescription]
                                                          cancelTitle:@"Обидете се повторно..."
                                                     cancelCompletion:nil
                                                              okTitle:nil
                                                         okCompletion:nil
                                                     destructiveTitle:nil
                                                destructiveCompletion:nil];
                [self didSignUp];
                [self presentViewController:alert animated:YES completion:nil];
            }];
        }];
    } else {
        [Utility showAlertWithErrors:self.inputErrors onParent:self];
    }
    [self.inputErrors removeAllObjects];
}

#pragma mark Gesture Recognizers

-(void)setUpGestureRecognizer {
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    gesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:gesture];
}

-(void)viewTapped {
    [self.view endEditing:YES];
}

#pragma mark UI Functionalities

static NSString *chooseString = @"Избери";
static NSString *cancelString = @"Откажи";

- (void)setUpBirthdayTextField {
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:chooseString style:UIBarButtonItemStyleDone target:self action:@selector(showSelectedDate)];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:cancelString style:UIBarButtonItemStylePlain target:self action:@selector(closeDatePicker)];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(10.0, 0.0, self.view.frame.size.width, 40.0)];
    [toolbar setItems:@[cancelButton, flexibleSpace, doneButton]];
    
    [self.birthdayTextField setInputView:self.datePicker];
    [self.birthdayTextField setInputAccessoryView:toolbar];
}

- (void)showSelectedDate {
    self.birthdayTextField.text = [NSString stringWithFormat:@"%@", [[Utility getDateFormatter] stringFromDate:self.datePicker.date]];
    [self.birthdayTextField resignFirstResponder];
}

-(void)closeDatePicker {
    [self.birthdayTextField resignFirstResponder];
}

#pragma mark Helpers

- (BOOL)validateInput {
    BOOL isValid = YES;
    
    if(![self.nameTextField.text isValidName]){
        isValid = NO;
        [self.inputErrors addObject:[NSNumber numberWithInt:NameValidationError]];
    }
    if(![self.surnameTextField.text isValidName]){
        isValid = NO;
        [self.inputErrors addObject:[NSNumber numberWithInt:SurnameValidationError]];
    }
    if(![self.emailTextField.text isValidEmail]){
        isValid = NO;
        [self.inputErrors addObject:[NSNumber numberWithInt:EmailValidationError]];
    }
    if(![self.passwordTextField.text isValidPassword]){
        isValid = NO;
        [self.inputErrors addObject:[NSNumber numberWithInt:PasswordValidationError]];
    }
    if(![self.passwordTextField.text isValidPassword] || ![self.passwordTextField.text isEqualToString:self.passwordConfirmTextField.text]){
        isValid = NO;
        [self.inputErrors addObject:[NSNumber numberWithInt:DifferentPasswordsValidationError]];
    }
    if(![self.birthdayTextField.text isValidDate]){
        isValid = NO;
        [self.inputErrors addObject:[NSNumber numberWithInt:BirthdayValidationError]];
    }
    
    return isValid;
}

-(void)isSigningUp {
    self.signUpButton.hidden = YES;
    [self.signUpProgressActivityIndicator startAnimating];
    self.signUpActivityIndicatorWrapperView.hidden = NO;
}

-(void)didSignUp {
    self.signUpButton.hidden = NO;
    [self.signUpProgressActivityIndicator stopAnimating];
    self.signUpActivityIndicatorWrapperView.hidden = YES;
}

@end
