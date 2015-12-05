//
//  SignUpViewController.m
//  Gajbi
//
//  Created by Boris Kachulachki on 12/4/15.
//  Copyright © 2015 Kachulach. All rights reserved.
//

#import "SignUpViewController.h"
#import "NSString+Validation.h"

@interface SignUpViewController ()
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    
    [self setUpGestureRecognizer];
    [self setUpBirthdayTextField];
    
    self.inputErrors = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpGestureRecognizer {
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    gesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:gesture];
}

-(void)viewTapped {
    [self.view endEditing:YES];
}

#pragma mark Validating User Input

- (IBAction)signUp:(id)sender {
    if([self validateInput]){
        //register
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
        case NameValidationError:
            errorString = @"Name error!";
            break;
        case SurnameValidationError:
            errorString = @"Surname error!";
            break;
        case EmailValidationError:
            errorString = @"Email error!";
            break;
        case PasswordValidationError:
            errorString = @"Password error!";
            break;
        case DifferentPasswordsError:
            errorString = @"Different passwords error!";
            break;
        default:
            break;
    }
    return errorString;
}

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
        [self.inputErrors addObject:[NSNumber numberWithInt:DifferentPasswordsError]];
    }
    
    return isValid;
}

#pragma mark Setting Subviews

- (void)setUpBirthdayTextField {
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Избери" style:UIBarButtonItemStyleDone target:self action:@selector(showSelectedDate)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Откажи" style:UIBarButtonItemStylePlain target:self action:@selector(closeDatePicker)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(10.0, 0.0, 310.0, 40.0)];
    [toolbar setItems:@[cancelButton, flexibleSpace, doneButton]];
    
    [self.birthdayTextField setInputView:self.datePicker];
    [self.birthdayTextField setInputAccessoryView:toolbar];
}

- (void)showSelectedDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:@"d MMMM YYYY"];
    self.birthdayTextField.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:self.datePicker.date]];
    [self.birthdayTextField resignFirstResponder];
}

-(void)closeDatePicker {
    [self.birthdayTextField resignFirstResponder];
}

@end
