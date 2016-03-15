//
//  PublisherProfileTableViewController.h
//  Gajbi
//
//  Created by Boris Kachulachki on 1/27/16.
//  Copyright © 2016 Kachulach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@class User;
@class MFMailComposeViewController;

@interface PublisherProfileTableViewController : UITableViewController<MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) User *publisher;

@end
