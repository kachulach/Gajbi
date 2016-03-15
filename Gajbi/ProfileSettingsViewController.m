//
//  ProfileSettingsViewController.m
//  Gajbi
//
//  Created by Boris Kachulachki on 12/30/15.
//  Copyright © 2015 Kachulach. All rights reserved.
//

#import "ProfileSettingsViewController.h"
#import "UserService.h"
#import "GlobalUser.h"
#import "NSString+Validation.h"
#import "Utility.h"
#import "AppDelegate.h"

@interface ProfileSettingsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *surnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextFIeld;

@end

@implementation ProfileSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData {
    self.nameTextField.text = [GlobalUser getUser].name;
    self.surnameTextField.text = [GlobalUser getUser].surname;
    self.emailTextField.text = [GlobalUser getUser].email;
}

- (IBAction)changeNameTouchUp:(id)sender {
    if(![self.nameTextField.text isValidName]){
        NSArray *errorArray = @[[NSNumber numberWithInt:NameValidationError]];
        [Utility showAlertWithErrors:errorArray onParent:self];
        return;
    }
    NSDictionary *dictionary = @{[User nameKey] : self.nameTextField.text};
    [UserService updateWithDictionary:dictionary forUid:[GlobalUser getUser].uid];
    [self showSuccessUpdateCompletedAlert];
}
- (IBAction)changeSurnameTouchUp:(id)sender {
    if(![self.surnameTextField.text isValidName]){
        NSArray *errorArray = @[[NSNumber numberWithInt:NameValidationError]];
        [Utility showAlertWithErrors:errorArray onParent:self];
        return;
    }
    NSDictionary *dictionary = @{[User surnameKey] : self.surnameTextField.text};
    [UserService updateWithDictionary:dictionary forUid:[GlobalUser getUser].uid];
    [self showSuccessUpdateCompletedAlert];
}
- (IBAction)changeEmailTouchUp:(id)sender {
    if(![self.emailTextField.text isValidEmail]){
        NSArray *errorArray = @[[NSNumber numberWithInt:EmailValidationError]];
        [Utility showAlertWithErrors:errorArray onParent:self];
        return;
    }
    [UserService changeEmailWithEmail:[GlobalUser getUser].email password:[GlobalUser getUser].password newEmail:self.emailTextField.text succsessHandler:^{
        NSDictionary *dictionary = @{[User emailKey] : self.emailTextField.text};
        [UserService updateWithDictionary:dictionary forUid:[GlobalUser getUser].uid];
        [self showSuccessUpdateCompletedAlert];
    } errorHandler:^(NSError *error) {
        [self showErrorUpdateCompletedAlertWithErrorMessage:error.localizedDescription];
    }];
}
- (IBAction)updatePasswordTouchUp:(id)sender {
    if(![self.oldPasswordTextField.text isEqualToString:[GlobalUser getUser].password]) {
        NSArray *errorArray = @[[NSNumber numberWithInt:WrongOldPasswordError]];
        [Utility showAlertWithErrors:errorArray onParent:self];
        return;
    }
    if(![self.passwordTextField.text isValidPassword] || ![self.confirmPasswordTextFIeld.text isValidPassword]){
        NSArray *errorArray = @[[NSNumber numberWithInt:PasswordValidationError]];
        [Utility showAlertWithErrors:errorArray onParent:self];
        return;
    }
    if(![self.passwordTextField.text isEqualToString:self.confirmPasswordTextFIeld.text]) {
        NSArray *errorArray = @[[NSNumber numberWithInt:DifferentPasswordsValidationError]];
        [Utility showAlertWithErrors:errorArray onParent:self];
        return;
    }
    [UserService changePasswordWithEmail:[GlobalUser getUser].email oldPassword:self.oldPasswordTextField.text newPassword:self.passwordTextField.text successHandler:^{
        NSDictionary *dictionary = @{[User passwordKey] : self.passwordTextField.text};
        [UserService updateWithDictionary:dictionary forUid:[GlobalUser getUser].uid];
        [self showSuccessUpdateCompletedAlert];
    } errorHandler:^(NSError *error) {
        [self showErrorUpdateCompletedAlertWithErrorMessage:error.localizedDescription];
    }];
}

static NSString *showLogInSegueID = @"ShowLogInSegue";

- (IBAction)deleteProfileTouchUp:(id)sender {
    UIAlertController *alert = [Utility getAlertWithTitle:@"Дали сте сигурни?"
                                                  message:@"Дали сте сигурни дека сакате да го избришете вашиот профил?"
                                              cancelTitle:@"Откажи"
                                         cancelCompletion:nil
                                                  okTitle:nil
                                             okCompletion:nil
                                         destructiveTitle:@"Избриши го профилот"
                                    destructiveCompletion:^{
                                        [UserService removeWithUser:[GlobalUser getUser] successHandler:^{
                                            [GlobalUser unloadUser];
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                [self performSegueWithIdentifier:showLogInSegueID sender:self];
                                            });
                                            } errorHandler:^(NSError *error) {
                                                [self showErrorUpdateCompletedAlertWithErrorMessage:error.localizedDescription];
                                            }];
                                    }];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showSuccessUpdateCompletedAlert {
    UIAlertController *alert = [Utility getAlertWithTitle:@"Успешно!"
                                                  message:@"Вашите промени се зачувани."
                                              cancelTitle:nil
                                         cancelCompletion:nil
                                                  okTitle:@"OK"
                                             okCompletion:nil
                                         destructiveTitle:nil
                                    destructiveCompletion:nil];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showErrorUpdateCompletedAlertWithErrorMessage:(NSString *)errorMessage {
    UIAlertController *alert = [Utility getAlertWithTitle:@"Грешка!"
                                                  message:[NSString stringWithFormat:@"Настана грешка при ажурирањето на податоците: %@", errorMessage]
                                              cancelTitle:@"Обидете се повторно..."
                                         cancelCompletion:nil
                                                  okTitle:nil
                                             okCompletion:nil
                                         destructiveTitle:nil
                                    destructiveCompletion:nil];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
