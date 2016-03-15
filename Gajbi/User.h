//
//  User.h
//  Gajbi
//
//  Created by Boris Kachulachki on 12/8/15.
//  Copyright © 2015 Kachulach. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FDataSnapshot;

//Dictionary keys

@interface User : NSObject {
    
}

+ (NSString *)uidKey;
+ (NSString *)emailKey;
+ (NSString *)nameKey;
+ (NSString *)surnameKey;
+ (NSString *)passwordKey;
+ (NSString *)birthdayTimestampKey;
+ (NSString *)sexKey;
+ (NSString *)aboutMeKey;
+ (NSString *)likesKey;
+ (NSString *)dislikesKey;
+ (NSString *)tolerationsKey;

typedef NS_ENUM(NSInteger, Sex) {
    Male,
    Female
};

@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *surname;
@property (nonatomic) NSInteger birthdayTimestamp;
@property (nonatomic) Sex sex;

@property (strong, nonatomic) NSString *aboutMe;
@property (strong, nonatomic) NSString *likes;
@property (strong, nonatomic) NSString *dislikes;
@property (strong, nonatomic) NSString *tolerations;

@property (nonatomic) NSInteger numberOfCribs;

-(instancetype)initWithUid:(NSString *)uid
                     email:(NSString *)email
                  password:(NSString *)password
                      name:(NSString *)name
                   surname:(NSString *)surname
         birthdayTimestamp:(NSInteger)birthdayTimestamp
                       sex:(Sex)sex
                   aboutMe:(NSString *)aboutMe
                     likes:(NSString *)likes
                  dislikes:(NSString *)dislikes
               tolerations:(NSString *)tolerations
             numberOfCribs:(NSInteger)numberOfCribs;

-(instancetype)initWithSnapshot:(FDataSnapshot *)snapshot;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end
