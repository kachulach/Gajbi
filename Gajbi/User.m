//
//  User.m
//  Gajbi
//
//  Created by Boris Kachulachki on 12/8/15.
//  Copyright © 2015 Kachulach. All rights reserved.
//

#import "User.h"
#import <Firebase/Firebase.h>
#import "Utility.h"

@interface User()

@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) Firebase *ref;

@end

@implementation User

-(instancetype)initWithSnapshot:(FDataSnapshot *)snapshot {
    self.key = snapshot.key;
    NSString *uid = (NSString *)snapshot.value[[User uidKey]];
    NSString *email = (NSString *)snapshot.value[[User emailKey]];
    NSString *name = (NSString *)snapshot.value[[User nameKey]];
    NSString *surname = (NSString *)snapshot.value[[User surnameKey]];
    NSString *password = (NSString *)snapshot.value[[User passwordKey]];
    NSNumber *sexNumber = (NSNumber *)snapshot.value[[User sexKey]];
    Sex sex = [sexNumber integerValue];
    NSInteger birthdayTimestamp = [snapshot.value[[User birthdayTimestampKey]] integerValue];
    
    NSString *aboutMe = (NSString *)snapshot.value[[User aboutMeKey]];
    NSString *likes = (NSString *)snapshot.value[[User likesKey]];
    NSString *dislikes = (NSString *)snapshot.value[[User dislikesKey]];
    NSString *tolerations = (NSString *)snapshot.value[[User tolerationsKey]];
    NSNumber *numberOfCribsNumber = (NSNumber *)snapshot.value[[User numberOfCribsKey]];
    NSInteger numberOfCribs = [numberOfCribsNumber integerValue];
    
    return [self initWithUid:uid
                       email:email
                    password:password
                        name:name
                     surname:surname
           birthdayTimestamp:birthdayTimestamp
                         sex:sex
                     aboutMe:aboutMe
                       likes:likes
                    dislikes:dislikes
                 tolerations:tolerations
               numberOfCribs:numberOfCribs];
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *uid = (NSString *)dictionary[[User uidKey]];
    NSString *email = (NSString *)dictionary[[User emailKey]];
    NSString *name = (NSString *)dictionary[[User nameKey]];
    NSString *surname = (NSString *)dictionary[[User surnameKey]];
    NSString *password = (NSString *)dictionary[[User passwordKey]];
    NSNumber *sexNumber = (NSNumber *)dictionary[[User sexKey]];
    Sex sex = [sexNumber integerValue];
    
     NSInteger birthdayTimestamp = [dictionary[[User birthdayTimestampKey]] integerValue];
    
    NSString *aboutMe = (NSString *)dictionary[[User aboutMeKey]];
    NSString *likes = (NSString *)dictionary[[User likesKey]];
    NSString *dislikes = (NSString *)dictionary[[User dislikesKey]];
    NSString *tolerations = (NSString *)dictionary[[User tolerationsKey]];
    NSNumber *numberOfCribsNumber = (NSNumber *)dictionary[[User numberOfCribsKey]];
    NSInteger numberOfCribs = [numberOfCribsNumber integerValue];
    
    return [self initWithUid:uid
                       email:email
                    password:password
                        name:name
                     surname:surname
           birthdayTimestamp:birthdayTimestamp
                         sex:sex
                     aboutMe:aboutMe
                       likes:likes
                    dislikes:dislikes
                 tolerations:tolerations
               numberOfCribs:numberOfCribs];
}

#pragma mark Designated Initializer

-(instancetype)initWithUid:(NSString *)uid
                     email:(NSString *)email
                  password:(NSString *)password
                      name:(NSString *)name
                   surname:(NSString *)surname
         birthdayTimestamp:(NSInteger)birthdayTimestamp
                       sex:(Sex)sex aboutMe:(NSString *)aboutMe
                     likes:(NSString *)likes
                  dislikes:(NSString *)dislikes
               tolerations:(NSString *)tolerations
             numberOfCribs:(NSInteger)numberOfCribs{
    self = [self init];
    self.uid = uid;
    self.email = email;
    self.password = password;
    self.name = name;
    self.surname = surname;
    self.birthdayTimestamp = birthdayTimestamp;
    self.sex = sex;
    
    self.aboutMe = aboutMe;
    self.likes = likes;
    self.dislikes = dislikes;
    self.tolerations = tolerations;
    self.numberOfCribs = numberOfCribs;
    
    return self;
}

-(NSDictionary *)toDictionary {
    return @{
             [User uidKey] : self.uid,
             [User emailKey] : self.email,
             [User passwordKey] : self.password,
             [User nameKey] : self.name,
             [User surnameKey] : self.surname,
             [User birthdayTimestampKey] : [NSNumber numberWithInteger:self.birthdayTimestamp],
             [User sexKey] : [NSNumber numberWithInt:self.sex],
             [User aboutMeKey] : self.aboutMe,
             [User likesKey] : self.likes,
             [User dislikesKey] : self.dislikes,
             [User tolerationsKey] : self.tolerations,
             [User numberOfCribsKey] : [NSNumber numberWithInteger:self.numberOfCribs]
             };
}

//Dictionary keys init

+ (NSString *)uidKey {
    static NSString *uidKey = nil;
    if (uidKey == nil) {
        uidKey = @"uid";
    }
    return uidKey;
}

+ (NSString *)emailKey {
    static NSString *emailKey = nil;
    if (emailKey == nil) {
        emailKey = @"email";
    }
    return emailKey;
}

+ (NSString *)nameKey {
    static NSString *nameKey = nil;
    if (nameKey == nil) {
        nameKey = @"name";
    }
    return nameKey;
}

+ (NSString *)surnameKey {
    static NSString *surnameKey = nil;
    if (surnameKey == nil) {
        surnameKey = @"surname";
    }
    return surnameKey;
}

+ (NSString *)passwordKey {
    static NSString *passwordKey = nil;
    if (passwordKey == nil) {
        passwordKey = @"password";
    }
    return passwordKey;
}

+ (NSString *)birthdayTimestampKey {
    static NSString *birthdayTimestampKey = nil;
    if (birthdayTimestampKey == nil) {
        birthdayTimestampKey = @"birthdayTimestampKey";
    }
    return birthdayTimestampKey;
}

+ (NSString *)sexKey {
    static NSString *sexKey = nil;
    if (sexKey == nil) {
        sexKey = @"sex";
    }
    return sexKey;
}

+ (NSString *)aboutMeKey {
    static NSString *aboutMeKey = nil;
    if (aboutMeKey == nil) {
        aboutMeKey = @"aboutMe";
    }
    return aboutMeKey;
}

+ (NSString *)likesKey {
    static NSString *likes = nil;
    if (likes == nil) {
        likes = @"likes";
    }
    return likes;
}

+ (NSString *)dislikesKey {
    static NSString *dislikesKey = nil;
    if (dislikesKey == nil) {
        dislikesKey = @"dislikes";
    }
    return dislikesKey;
}

+ (NSString *)tolerationsKey {
    static NSString *tolerationsKey = nil;
    if (tolerationsKey == nil) {
        tolerationsKey = @"tolerations";
    }
    return tolerationsKey;
}

+ (NSString *)numberOfCribsKey {
    static NSString *numberOfCribsKey = nil;
    if (numberOfCribsKey == nil) {
        numberOfCribsKey = @"numberOfCribs";
    }
    return numberOfCribsKey;
}

@end
