//
//  CribExtraDetailsViewController.m
//  Gajbi
//
//  Created by Boris Kachulachki on 1/26/16.
//  Copyright © 2016 Kachulach. All rights reserved.
//

#import "CribExtraDetailsViewController.h"
#import "Utility.h"
#import "UserService.h"
#import "PublisherProfileTableViewController.h"
#import "Crib.h"

@interface CribExtraDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *postTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cribTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalRoomiesLabel;
@property (weak, nonatomic) IBOutlet UILabel *missingRoomiesLabel;
@property (weak, nonatomic) IBOutlet UILabel *floorLabel;
@property (weak, nonatomic) IBOutlet UILabel *heatingTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *elevatorLabel;
@property (weak, nonatomic) IBOutlet UILabel *balconyLabel;
@property (weak, nonatomic) IBOutlet UILabel *furnitureLabel;
@property (weak, nonatomic) IBOutlet UILabel *parkingLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UIButton *usernameLabel;

@property (strong, nonatomic) User *user;

@end

@implementation CribExtraDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.user = [[User alloc] init];
    
    if(self.crib.postType == HaveCribPostType) {
        self.postTypeLabel.text = @"СЕ ИЗДАВА";
    } else {
        self.postTypeLabel.text = @"СЕ БАРА";
    }
    
    switch (self.crib.cribType) {
        case RoomCribType:
            self.cribTypeLabel.text = @"Соба";
            break;
        case HouseCribType:
            self.cribTypeLabel.text = @"Куќа";
            break;
        case ApartmentCribType:
            self.cribTypeLabel.text = @"Стан";
            break;
        default:
            break;
    }
    NSString *priceValueString;
    switch (self.crib.priceValueType) {
        case MKD:
            priceValueString = @"МКД";
            break;
        case EUR:
            priceValueString = @"EUR";
            break;
        default:
            break;
    }
    
    switch (self.crib.postType) {
        case NeedCribPostType:
            self.areaLabel.text = [NSString stringWithFormat:@"%.2f - %.2f%@", self.crib.areaFrom, self.crib.areaTo, @"m²"];
            self.priceLabel.text = [NSString stringWithFormat:@"%.2f - %.2f %@", self.crib.priceFrom, self.crib.priceTo, priceValueString];
            break;
        case HaveCribPostType:
            self.areaLabel.text = [NSString stringWithFormat:@"%.2f%@", self.crib.totalArea, @"m²"];
            self.priceLabel.text = [NSString stringWithFormat:@"%.2f %@", self.crib.totalPrice, priceValueString];
            break;
        default:
            break;
    }
    
    NSDate *dateFromTimestamp = [NSDate dateWithTimeIntervalSince1970:self.crib.timestamp];
    NSDateFormatter *dateFormatter = [Utility getDateFormatter];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    self.dateLabel.text = [dateFormatter stringFromDate:dateFromTimestamp];
    
    self.locationLabel.text = [NSString stringWithFormat:@"%@, %@", self.crib.subPlace, self.crib.place];
    self.totalRoomiesLabel.text = [NSString stringWithFormat:@"%lu", (long)self.crib.numberOfTotalRoomies];
    self.missingRoomiesLabel.text = [NSString stringWithFormat:@"%lu", (long)self.crib.numberOfMissingRoomies];
    
    self.floorLabel.text = [NSString stringWithFormat:@"%lu", (long)self.crib.floor];
    
    switch (self.crib.heatingType) {
        case ElectricityHeatingType:
            self.heatingTypeLabel.text = @"Струја";
            break;
        case RadiatorHeatingType:
            self.heatingTypeLabel.text = @"Парно";
            break;
        case OtherHeatingType:
            self.heatingTypeLabel.text = @"Друго";
            break;
        default:
            break;
    }
    
    if(self.crib.elevator) {
        self.elevatorLabel.text = @"Да";
    } else {
        self.elevatorLabel.text = @"Не";
    }
    if(self.crib.parking) {
        self.parkingLabel.text = @"Да";
    } else {
        self.parkingLabel.text = @"Не";
    }
    if(self.crib.balcony) {
        self.balconyLabel.text = @"Да";
    } else {
        self.balconyLabel.text = @"Не";
    }
    if(self.crib.furniture) {
        self.furnitureLabel.text = @"Да";
    } else {
        self.furnitureLabel.text = @"Не";
    }
    
    self.commentTextView.text = self.crib.comment;
    
    [Utility invokeInternetConnectionAction:^{
        [UserService getWithUid:self.crib.uid successHandler:^(User *u) {
            self.user = u;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.usernameLabel setTitle:[NSString stringWithFormat:@"%@ %@", u.name, u.surname] forState:UIControlStateNormal];
            });
        } errorHandler:^{
            //Handle error gracefully
        }];
    }];
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
    return 8;
}

static NSString *extraCribDetailsPublisherProfileSegueID = @"extraCribDetails-publisherProfile";

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:extraCribDetailsPublisherProfileSegueID]) {
        PublisherProfileTableViewController *publisherProfileTableViewController = (PublisherProfileTableViewController *)segue.destinationViewController;
        publisherProfileTableViewController.publisher = self.user;
    }
}


@end
