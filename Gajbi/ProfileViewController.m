//
//  ProfileViewController.m
//  Gajbi
//
//  Created by Boris Kachulachki on 12/21/15.
//  Copyright © 2015 Kachulach. All rights reserved.
//

#import "ProfileViewController.h"
#import "UserService.h"
#import "Utility.h"
#import "GlobalUser.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UITextView *aboutMeTextView;
@property (weak, nonatomic) IBOutlet UITextView *likesTextView;
@property (weak, nonatomic) IBOutlet UITextView *dislikesTextView;
@property (weak, nonatomic) IBOutlet UITextView *tolerationsTextView;
@property (weak, nonatomic) IBOutlet UILabel *nameAndSurnameLabel;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

static NSString *emptyString = @"";

- (void)loadData {
    self.nameAndSurnameLabel.text = [NSString stringWithFormat:@"%@ %@", [GlobalUser getUser].name, [GlobalUser getUser].surname];
    self.aboutMeTextView.text = [GlobalUser getUser].aboutMe;
    self.likesTextView.text = [GlobalUser getUser].likes;
    self.dislikesTextView.text = [GlobalUser getUser].dislikes;
    self.tolerationsTextView.text = [GlobalUser getUser].tolerations;
}

- (IBAction)save:(id)sender {
    NSString *aboutMe = emptyString;
    NSString *likes = emptyString;
    NSString *dislikes = emptyString;
    NSString *tolerations = emptyString;
    
    if(self.aboutMeTextView.text.length != 0) {
        aboutMe = self.aboutMeTextView.text;
    }
    if(self.likesTextView.text.length != 0) {
        likes = self.likesTextView.text;
    }
    if(self.dislikesTextView.text.length != 0) {
        dislikes = self.dislikesTextView.text;
    }
    if(self.tolerationsTextView.text.length != 0) {
        tolerations = self.tolerationsTextView.text;
    }
    NSDictionary *dictionary = @{
                                 [User aboutMeKey] : aboutMe,
                                 [User likesKey] : likes,
                                 [User dislikesKey] : dislikes,
                                 [User tolerationsKey] : tolerations
                                 };
    [UserService updateWithDictionary:dictionary forUid:[GlobalUser getUser].uid];
    UIAlertController *alert = [Utility getAlertWithTitle:@"Успешно!"
                                                  message:@"Вашите промени се успешно зачувани."
                                              cancelTitle:nil
                                         cancelCompletion:nil
                                                  okTitle:@"OK"
                                             okCompletion:nil
                                         destructiveTitle:nil
                                    destructiveCompletion:nil];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
