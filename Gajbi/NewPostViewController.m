//
//  NewPostViewController.m
//  Gajbi
//
//  Created by Boris Kachulachki on 1/17/16.
//  Copyright © 2016 Kachulach. All rights reserved.
//

#import "NewPostViewController.h"
#import "CribLocationViewController.h"
#import "Crib.h"

@interface NewPostViewController ()

@end

@implementation NewPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

static NSString *needCribSegueID = @"need-crib-segue";
static NSString *haveCribSegueID = @"have-crib-segue";

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:needCribSegueID]) {
        CribLocationViewController *cribLocationViewController = (CribLocationViewController *)segue.destinationViewController;
        NSMutableDictionary *tempDictionary = [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:NeedCribPostType] forKey:[Crib postTypeKey]];
        cribLocationViewController.cribDictionary = tempDictionary;
    } else if([segue.identifier isEqualToString:haveCribSegueID]) {
        CribLocationViewController *cribLocationViewController = (CribLocationViewController *)segue.destinationViewController;
        NSMutableDictionary *tempDictionary = [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:HaveCribPostType] forKey:[Crib postTypeKey]];
        cribLocationViewController.cribDictionary = tempDictionary;
    }
}

@end
