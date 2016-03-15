//
//  CribCell.m
//  Gajbi
//
//  Created by Boris Kachulachki on 1/24/16.
//  Copyright © 2016 Kachulach. All rights reserved.
//

#import "CribCell.h"
#import "Crib.h"
#import "Utility.h"

@interface CribCell()
@property (weak, nonatomic) IBOutlet UILabel *postTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cribTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalRoomiesLabel;
@property (weak, nonatomic) IBOutlet UILabel *missingRoomiesLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceValueTypeLabel;

@end

@implementation CribCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCrib:(Crib *)crib {
    self.totalRoomiesLabel.text = [NSString stringWithFormat:@"%lu", (long)crib.numberOfTotalRoomies];
    self.missingRoomiesLabel.text = [NSString stringWithFormat:@"%lu", (long)crib.numberOfMissingRoomies];
    self.placeLabel.text = crib.place;
    
    NSDate *dateFromTimestamp = [NSDate dateWithTimeIntervalSince1970:crib.timestamp];
    NSDateFormatter *dateFormatter = [Utility getDateFormatter];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    self.dateLabel.text = [dateFormatter stringFromDate:dateFromTimestamp];
    
    switch (crib.priceValueType) {
        case MKD:
            self.priceValueTypeLabel.text = @"МКД";
            break;
        case EUR:
            self.priceValueTypeLabel.text = @"EUR";
            break;
            
        default:
            break;
    }
    
    switch (crib.cribType) {
        case ApartmentCribType:
            self.cribTypeLabel.text = @"СТАН";
            break;
        case RoomCribType:
            self.cribTypeLabel.text = @"СОБА";
            break;
        case HouseCribType:
            self.cribTypeLabel.text = @"КУЌА";
            break;
        default:
            break;
    }
    switch (crib.postType) {
        case NeedCribPostType:
            self.postTypeLabel.text = @"СЕ БАРА";
            self.areaLabel.text = [NSString stringWithFormat:@"%.2f - %.2f", crib.areaFrom, crib.areaTo];
            self.priceLabel.text = [NSString stringWithFormat:@"%.2f - %.2f", crib.priceFrom, crib.priceTo];
            break;
        case HaveCribPostType:
            self.postTypeLabel.text = @"СЕ ИЗДАВА";
            self.areaLabel.text = [NSString stringWithFormat:@"%.2f", crib.totalArea];
            self.priceLabel.text = [NSString stringWithFormat:@"%.2f", crib.totalPrice];
            break;
        default:
            break;
    }
}

@end
