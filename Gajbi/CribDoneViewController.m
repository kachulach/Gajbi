//
//  CribDoneViewController.m
//  Gajbi
//
//  Created by Boris Kachulachki on 1/17/16.
//  Copyright © 2016 Kachulach. All rights reserved.
//

#import "CribDoneViewController.h"
#import "BorderTextView.h"
#import "Crib.h"
#import "GlobalUser.h"
#import "User.h"
#import "CribService.h"
#import "Utility.h"
#import "UserService.h"

@interface CribDoneViewController ()
@property (weak, nonatomic) IBOutlet BorderTextView *commentTextView;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIView *activityIndicatorWrapperView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation CribDoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

static NSString *cribDoneSegueID = @"CribDoneVC-HomeVC";

- (IBAction)cribDoneTouchUp:(id)sender {
    [self.cribDictionary setObject:self.commentTextView.text forKey:[Crib commentKey]];
    [self.cribDictionary setObject:[GlobalUser getUser].uid forKey:[Crib uidKey]];
    
    NSInteger nowTimeInterval = (NSInteger)[[NSDate date] timeIntervalSince1970];
    NSNumber *timestampNumber = [NSNumber numberWithInteger:nowTimeInterval];
    [self.cribDictionary setObject:timestampNumber forKey:[Crib timestampKey]];
    
    NSInteger userNumberOfCribs = [GlobalUser getUser].numberOfCribs + 1;
    NSString *userNumberOfCribsString = [NSString stringWithFormat:@"%ld", (long)userNumberOfCribs];
    NSString *cid = [NSString stringWithFormat:@"%@cid%@", [GlobalUser getUser].uid, userNumberOfCribsString];
    [self.cribDictionary setObject:cid forKey:[Crib cidKey]];
    [self isPosting];
    NSDictionary *dictionary = (NSDictionary *)self.cribDictionary;
    [CribService createCribWithDictionary:dictionary successHandler:^() {
        UIAlertController *alertController = [Utility getAlertWithTitle:@"Успешнa објава!"
                                                                message:@"Вашата гајба е успешно објавена!"
                                                            cancelTitle:nil
                                                       cancelCompletion:nil
                                                                okTitle:@"OK"
                                                           okCompletion:^ {
                                                               User *user = [GlobalUser getUser];
                                                               user.numberOfCribs = [GlobalUser getUser].numberOfCribs + 1;
                                                               [UserService updateWithDictionary:user.toDictionary forUid:user.uid];
                                                               [self.navigationController popToRootViewControllerAnimated:YES];
                                                           }
                                                       destructiveTitle:nil
                                                  destructiveCompletion:nil];
        [self presentViewController:alertController animated:YES completion:nil];
        [self didPost];
    } errorHandler:^(NSError *error) {
        NSString *errorDescription = error.localizedDescription;
        UIAlertController *alertController = [Utility getAlertWithTitle:@"Грешка!"
                                                                message:[NSString stringWithFormat:@"Настана грешка при постирање: %@", errorDescription]
                                                            cancelTitle:@"Затвори"
                                                       cancelCompletion:nil
                                                                okTitle:nil
                                                           okCompletion:nil
                                                       destructiveTitle:nil
                                                  destructiveCompletion:nil];
        [self presentViewController:alertController animated:YES completion:nil];
        [self didPost];
    }];
}

-(void)isPosting {
    self.doneButton.hidden = YES;
    self.activityIndicatorWrapperView.hidden = NO;
    [self.activityIndicator startAnimating];
}

-(void)didPost {
    self.doneButton.hidden = NO;
    self.activityIndicatorWrapperView.hidden = YES;
    [self.activityIndicator stopAnimating];
}

@end
