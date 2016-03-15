//
//  Crib.m
//  Gajbi
//
//  Created by Boris Kachulachki on 1/17/16.
//  Copyright © 2016 Kachulach. All rights reserved.
//

#import "Crib.h"
#import <Firebase/Firebase.h>

@interface Crib()

@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) Firebase *ref;

@end

@implementation Crib

-(instancetype)initWithSnapshot:(FDataSnapshot *)snapshot {
    self.key = snapshot.key;
    NSString *cid = (NSString *)snapshot.value[[Crib cidKey]];
    
    PostType postType = [snapshot.value[[Crib postTypeKey]] integerValue];
    
    NSString *place = (NSString *)snapshot.value[[Crib placeKey]];
    NSString *subPlace = (NSString *)snapshot.value[[Crib placeKey]];
    
    NSInteger numberOfTotalRoomies = [snapshot.value[[Crib numberOfTotalRoomiesKey]] integerValue];
    
    NSInteger numberOfMissingRoomies = [snapshot.value[[Crib numberOfMissingRoomiesKey]] integerValue];

    NSNumber *cribTypeNumber = snapshot.value[[Crib cribTypeKey]];
    CribType cribType = [cribTypeNumber integerValue];
    
    float priceTo = [snapshot.value[[Crib priceToKey]] floatValue];
    float priceFrom = [snapshot.value[[Crib priceFromKey]] floatValue];
    float totalPrice = [snapshot.value[[Crib totalPriceKey]] floatValue];
    
    NSUInteger floor = [snapshot.value[[Crib floorKey]] integerValue];
    
    BOOL parking = [snapshot.value[[Crib parkingKey]] boolValue];
    BOOL elevator = [snapshot.value[[Crib elevatorKey]] boolValue];
    BOOL balcony = [snapshot.value[[Crib balconyKey]] boolValue];
    BOOL furniture = [snapshot.value[[Crib furnitureKey]] boolValue];
    
    HeatingType heatingType = [snapshot.value[[Crib heatingTypeKey]] integerValue];
    
    float areaTo = [snapshot.value[[Crib areaToKey]] floatValue];
    float areaFrom = [snapshot.value[[Crib areaFromKey]] floatValue];
    float totalArea = [snapshot.value[[Crib totalAreaKey]] floatValue];
    
    NSString *comment = (NSString *)snapshot.value[[Crib commentKey]];
    
    PriceValueType priceValueType = [snapshot.value[[Crib priceValueTypeKey]] integerValue];
    
    NSString *uid = (NSString *)snapshot.value[[Crib uidKey]];
    
    NSInteger timestamp = [snapshot.value[[Crib timestampKey]] integerValue];
    
    return [self initWithCid:cid
                    postType:postType
                       place:place
                    subPlace:subPlace
        numberOfTotalRoomies:numberOfTotalRoomies
      numberOfMissingRoomies:numberOfMissingRoomies
                    cribType:cribType
                     priceTo:priceTo
                   priceFrom:priceFrom
                  totalPrice:totalPrice
                       floor:floor
                     parking:parking
                    elevator:elevator
                     balcony:balcony
                   furniture:furniture
                 heatingType:heatingType
                    areaFrom:areaFrom
                      areaTo:areaTo
                   totalArea:totalArea
                     comment:comment
              priceValueType:priceValueType
                         uid:uid
                   timestamp:timestamp];
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *cid = (NSString *)dictionary[[Crib cidKey]];
    
    PostType postType = [dictionary[[Crib postTypeKey]] integerValue];
    
    NSString *place = (NSString *)dictionary[[Crib placeKey]];
    NSString *subPlace = (NSString *)dictionary[[Crib placeKey]];
    
    NSInteger numberOfTotalRoomies = [dictionary[[Crib numberOfTotalRoomiesKey]] integerValue];
    NSInteger numberOfMissingRoomies = [dictionary[[Crib numberOfMissingRoomiesKey]] integerValue];
    
    CribType cribType = [dictionary[[Crib cribTypeKey]] integerValue];
    
    float priceTo = [dictionary[[Crib priceToKey]] floatValue];
    float priceFrom = [dictionary[[Crib priceFromKey]] floatValue];
    float totalPrice = [dictionary[[Crib totalPriceKey]] floatValue];
    
    NSUInteger floor = [dictionary[[Crib floorKey]] integerValue];
    
    BOOL parking = [dictionary[[Crib parkingKey]] boolValue];
    BOOL elevator = [dictionary[[Crib elevatorKey]] boolValue];
    BOOL balcony = [dictionary[[Crib balconyKey]] boolValue];
    BOOL furniture = [dictionary[[Crib furnitureKey]] boolValue];
    
    HeatingType heatingType = [dictionary[[Crib heatingTypeKey]] integerValue];
    
    float areaTo = [dictionary[[Crib areaToKey]] floatValue];
    float areaFrom = [dictionary[[Crib areaFromKey]] floatValue];
    float totalArea = [dictionary[[Crib totalAreaKey]] floatValue];
    
    NSString *comment = (NSString *)dictionary[[Crib commentKey]];
    
    PriceValueType priceValueType = [dictionary[[Crib priceValueTypeKey]] integerValue];
    
    NSString *uid = (NSString *)dictionary[[Crib uidKey]];
    
    NSInteger timestamp = [dictionary[[Crib timestampKey]] integerValue];
    
    return [self initWithCid:cid
                    postType:postType
                       place:place
                    subPlace:subPlace
        numberOfTotalRoomies:numberOfTotalRoomies
      numberOfMissingRoomies:numberOfMissingRoomies
                    cribType:cribType
                     priceTo:priceTo
                   priceFrom:priceFrom
                  totalPrice:totalPrice
                       floor:floor
                     parking:parking
                    elevator:elevator
                     balcony:balcony
                   furniture:furniture
                 heatingType:heatingType
                    areaFrom:areaFrom
                      areaTo:areaTo
                   totalArea:totalArea
                     comment:comment
              priceValueType:priceValueType
                         uid:uid
                   timestamp:timestamp];
}

#pragma mark Designated Initializer

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
                      timestamp:(NSInteger)timestamp {
    self = [self init];
    self.cid = cid;
    self.postType = postType;
    self.place = place;
    self.subPlace = subPlace;
    self.numberOfTotalRoomies = numberOfTotalRoomies;
    self.numberOfMissingRoomies = numberOfMissingRoomies;
    self.cribType = cribType;
    self.priceTo = priceTo;
    self.priceFrom = priceFrom;
    self.totalPrice = totalPrice;
    self.floor = floor;
    self.parking = parking;
    self.elevator = elevator;
    self.balcony = balcony;
    self.furniture = furniture;
    self.heatingType = heatingType;
    self.areaFrom = areaFrom;
    self.areaTo = areaTo;
    self.totalArea = totalArea;
    self.comment = comment;
    self.priceValueType = priceValueType;
    self.uid = uid;
    self.timestamp = timestamp;
    
    return self;
}

-(NSDictionary *)toDictionary {
    return @{
             [Crib cidKey] : self.cid,
             [Crib postTypeKey] : [NSNumber numberWithInteger:self.postType],
             [Crib placeKey] : self.place,
             [Crib subPlaceKey] : self.subPlace,
             [Crib numberOfTotalRoomiesKey] : [NSNumber numberWithFloat:self.numberOfTotalRoomies],
             [Crib numberOfMissingRoomiesKey] : [NSNumber numberWithFloat:self.numberOfMissingRoomies],
             [Crib cribTypeKey] : [NSNumber numberWithInteger:self.cribType],
             [Crib priceToKey] : [NSNumber numberWithFloat:self.priceTo],
             [Crib priceFromKey] : [NSNumber numberWithFloat:self.priceFrom],
             [Crib totalPriceKey] : [NSNumber numberWithFloat:self.totalPrice],
             [Crib floorKey] : [NSNumber numberWithFloat:self.floor],
             [Crib parkingKey] : [NSNumber numberWithBool:self.parking],
             [Crib elevatorKey] : [NSNumber numberWithBool:self.elevator],
             [Crib balconyKey] : [NSNumber numberWithBool:self.balcony],
             [Crib furnitureKey] : [NSNumber numberWithBool:self.furniture],
             [Crib heatingTypeKey] : [NSNumber numberWithInteger:self.heatingType],
             [Crib areaToKey] : [NSNumber numberWithFloat:self.areaTo],
             [Crib areaFromKey] : [NSNumber numberWithFloat:self.areaFrom],
             [Crib totalAreaKey] : [NSNumber numberWithFloat:self.totalArea],
             [Crib commentKey] : self.comment,
             [Crib priceValueTypeKey] : [NSNumber numberWithInteger:self.priceValueType],
             [Crib uidKey] : self.uid,
             [Crib timestampKey] : [NSNumber numberWithInteger:self.timestamp]
             };
}

//Dictionary keys init

+ (NSString *)cidKey {
    static NSString *cidKey = nil;
    if (cidKey == nil) {
        cidKey = @"cid";
    }
    return cidKey;
}

+ (NSString *)postTypeKey {
    static NSString *postTypeKey = nil;
    if (postTypeKey == nil) {
        postTypeKey = @"postType";
    }
    return postTypeKey;
}

+ (NSString *)placeKey {
    static NSString *placeKey = nil;
    if (placeKey == nil) {
        placeKey = @"place";
    }
    return placeKey;
}

+ (NSString *)subPlaceKey {
    static NSString *subPlaceKey = nil;
    if (subPlaceKey == nil) {
        subPlaceKey = @"subPlace";
    }
    return subPlaceKey;
}

+ (NSString *)numberOfTotalRoomiesKey {
    static NSString *numberOfTotalRoomiesKey = nil;
    if (numberOfTotalRoomiesKey == nil) {
        numberOfTotalRoomiesKey = @"numberOfTotalRoomies";
    }
    return numberOfTotalRoomiesKey;
}

+ (NSString *)numberOfMissingRoomiesKey {
    static NSString *numberOfMissingRoomiesKey = nil;
    if (numberOfMissingRoomiesKey == nil) {
        numberOfMissingRoomiesKey = @"numberOfMissingRoomies";
    }
    return numberOfMissingRoomiesKey;
}

+ (NSString *)cribTypeKey {
    static NSString *cribTypeKey = nil;
    if (cribTypeKey == nil) {
        cribTypeKey = @"cribType";
    }
    return cribTypeKey;
}

+ (NSString *)priceToKey {
    static NSString *priceToKey = nil;
    if (priceToKey == nil) {
        priceToKey = @"priceTo";
    }
    return priceToKey;
}

+ (NSString *)priceFromKey {
    static NSString *priceFromKey = nil;
    if (priceFromKey == nil) {
        priceFromKey = @"priceFrom";
    }
    return priceFromKey;
}

+ (NSString *)totalPriceKey {
    static NSString *totalPriceKey = nil;
    if (totalPriceKey == nil) {
        totalPriceKey = @"totalPrice";
    }
    return totalPriceKey;
}

+ (NSString *)floorKey {
    static NSString *floorKey = nil;
    if (floorKey == nil) {
        floorKey = @"floor";
    }
    return floorKey;
}

+ (NSString *)parkingKey {
    static NSString *parkingKey = nil;
    if (parkingKey == nil) {
        parkingKey = @"parking";
    }
    return parkingKey;
}

+ (NSString *)elevatorKey {
    static NSString *elevatorKey = nil;
    if (elevatorKey == nil) {
        elevatorKey = @"elevator";
    }
    return elevatorKey;
}

+ (NSString *)balconyKey {
    static NSString *balconyKey = nil;
    if (balconyKey == nil) {
        balconyKey = @"balcony";
    }
    return balconyKey;
}

+ (NSString *)furnitureKey {
    static NSString *furnitureKey = nil;
    if (furnitureKey == nil) {
        furnitureKey = @"furniture";
    }
    return furnitureKey;
}

+ (NSString *)heatingTypeKey {
    static NSString *heatingTypeKey = nil;
    if (heatingTypeKey == nil) {
        heatingTypeKey = @"heatingType";
    }
    return heatingTypeKey;
}

+ (NSString *)areaFromKey {
    static NSString *areaFromKey = nil;
    if (areaFromKey == nil) {
        areaFromKey = @"areaFrom";
    }
    return areaFromKey;
}

+ (NSString *)areaToKey {
    static NSString *areaToKey = nil;
    if (areaToKey == nil) {
        areaToKey = @"areaTo";
    }
    return areaToKey;
}

+ (NSString *)totalAreaKey {
    static NSString *totalAreaKey = nil;
    if (totalAreaKey == nil) {
        totalAreaKey = @"totalArea";
    }
    return totalAreaKey;
}

+ (NSString *)commentKey {
    static NSString *commentKey = nil;
    if (commentKey == nil) {
        commentKey = @"comment";
    }
    return commentKey;
}

+ (NSString *)priceValueTypeKey {
    static NSString *priceValueTypeKey = nil;
    if (priceValueTypeKey == nil) {
        priceValueTypeKey = @"priceValueType";
    }
    return priceValueTypeKey;
}

+ (NSString *)uidKey {
    static NSString *uidKey = nil;
    if (uidKey == nil) {
        uidKey = @"uid";
    }
    return uidKey;
}

+(NSString *)timestampKey {
    static NSString *timestampKey = nil;
    if(!timestampKey) {
        timestampKey = @"timestamp";
    }
    return timestampKey;
}

@end
