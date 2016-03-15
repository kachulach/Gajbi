//
//  PublisherProfileTableViewController.m
//  Gajbi
//
//  Created by Boris Kachulachki on 1/27/16.
//  Copyright © 2016 Kachulach. All rights reserved.
//

#import "PublisherProfileTableViewController.h"
#import "User.h"
#import "Utility.h"
#import "GlobalUser.h"

@interface PublisherProfileTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameSurnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UITextView *aboutMeTextView;
@property (weak, nonatomic) IBOutlet UITextView *likesTextView;
@property (weak, nonatomic) IBOutlet UITextView *dislikesTextView;
@property (weak, nonatomic) IBOutlet UITextView *tolerationsTextView;

@end

@implementation PublisherProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameSurnameLabel.text = [NSString stringWithFormat:@"%@ %@", self.publisher.name, self.publisher.surname];
    
    switch (self.publisher.sex) {
        case Male:
            self.sexLabel.text = @"Машки";
            break;
        case Female:
            self.sexLabel.text = @"Женски";
            break;
        default:
            break;
    }
    
    NSDate *dateFromTimestamp = [NSDate dateWithTimeIntervalSince1970:self.publisher.birthdayTimestamp];
    NSDateFormatter *dateFormatter = [Utility getDateFormatter];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    self.birthdayLabel.text = [dateFormatter stringFromDate:dateFromTimestamp];
    self.aboutMeTextView.text = self.publisher.aboutMe;
    self.likesTextView.text = self.publisher.likes;
    self.dislikesTextView.text = self.publisher.dislikes;
    self.tolerationsTextView.text = self.publisher.tolerations;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

static NSString *mailBodyFormat = @"Здраво,\n Јас сум @% @% и би сакал да поразговараме твојата Гајба";

- (IBAction)contact:(id)sender {
    MFMailComposeViewController* mailController = [[MFMailComposeViewController alloc] init];
    mailController.mailComposeDelegate = self;
    User *selfUser = [GlobalUser getUser];
    [mailController setSubject:[NSString stringWithFormat:@"Гајби: Барање за контакт од %@ %@", selfUser.name, selfUser.surname]];
    [mailController setMessageBody:[NSString stringWithFormat:mailBodyFormat, selfUser.name, selfUser.surname] isHTML:NO];
    [mailController setCcRecipients:nil];
    [mailController setBccRecipients:nil];
    [mailController setToRecipients:@[self.publisher.email]];
    if (mailController) {
        [self presentViewController:mailController animated:YES completion:nil];
    }
}

@end
