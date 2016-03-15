//
//  Crib.h
//  Gajbi
//
//  Created by Boris Kachulachki on 1/17/16.
//  Copyright © 2016 Kachulach. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FDataSnapshot;

@interface Crib : NSObject {
    
}

+ (NSString *)cidKey;
+ (NSString *)postTypeKey;
+ (NSString *)placeKey;
+ (NSString *)subPlaceKey;
+ (NSString *)numberOfTotalRoomiesKey;
+ (NSString *)numberOfMissingRoomiesKey;
+ (NSString *)cribTypeKey;
+ (NSString *)priceFromKey;
+ (NSString *)priceToKey;
+ (NSString *)totalPriceKey;
+ (NSString *)floorKey;
+ (NSString *)parkingKey;
+ (NSString *)elevatorKey;
+ (NSString *)balconyKey;
+ (NSString *)furnitureKey;
+ (NSString *)heatingTypeKey;
+ (NSString *)totalAreaKey;
+ (NSString *)areaFromKey;
+ (NSString *)areaToKey;
+ (NSString *)commentKey;
+ (NSString *)priceValueTypeKey;
+ (NSString *)uidKey;
+ (NSString *)timestampKey;


typedef NS_ENUM(NSInteger, PostType) {
    HaveCribPostType,
    NeedCribPostType
};

typedef NS_ENUM(NSInteger, CribType) {
    RoomCribType,
    ApartmentCribType,
    HouseCribType
};

typedef NS_ENUM(NSInteger, HeatingType) {
    ElectricityHeatingType,
    RadiatorHeatingType,
    OtherHeatingType
};

typedef NS_ENUM(NSInteger, PriceValueType) {
    EUR,
    MKD
};

@property (strong, nonatomic) NSString *cid;
@property (nonatomic) PostType postType;
@property (strong, nonatomic) NSString *place;
@property (strong, nonatomic) NSString *subPlace;
@property (nonatomic) NSInteger numberOfTotalRoomies;
@property (nonatomic) NSInteger numberOfMissingRoomies;
@property (nonatomic) CribType cribType;
@property (nonatomic) float priceTo;
@property (nonatomic) float priceFrom;
@property (nonatomic) float totalPrice;
@property (nonatomic) NSUInteger floor;
@property (nonatomic) BOOL parking;
@property (nonatomic) BOOL elevator;
@property (nonatomic) BOOL balcony;
@property (nonatomic) BOOL furniture;
@property (nonatomic) HeatingType heatingType;
@property (nonatomic) float areaFrom;
@property (nonatomic) float areaTo;
@property (nonatomic) float totalArea;
@property (strong, nonatomic) NSString *comment;
@property (nonatomic) PriceValueType priceValueType;
@property (strong, nonatomic) NSString *uid;
@property (nonatomic) NSInteger timestamp;


-(instancetype)initWithCid:(NSString *)cid
                      postType:(PostType)postType
                         place:(NSString *)place
                      subPlace:(NSString *)subPlace
          numberOfTotalRoomies:(NSInteger)numberOfTotalRoomies
        numberOfMissingRoomies:(NSInteger)numberOfMissingRoomies
                      cribType:(CribType)cribType
                       priceTo:(float)priceTo
                     priceFrom:(float)priceFrom
                    totalPrice:(float)totalPrice
                         floor:(NSUInteger)floor
                       parking:(BOOL)parking
                      elevator:(BOOL)elevator
                       balcony:(BOOL)balcony
                     furniture:(BOOL)furniture
                   heatingType:(HeatingType)heatingType
                      areaFrom:(float)areaFrom
                        areaTo:(float)areaTo
                     totalArea:(float)totalArea
                       comment:(NSString *)comment
                priceValueType:(PriceValueType)priceValueType
                           uid:(NSString *)uid
                          timestamp:(NSInteger)timestamp;

-(instancetype)initWithSnapshot:(FDataSnapshot *)snapshot;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
 

@end
