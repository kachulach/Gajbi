//
//  CribLocationViewController.m
//  Gajbi
//
//  Created by Boris Kachulachki on 1/17/16.
//  Copyright © 2016 Kachulach. All rights reserved.
//

#import "CribLocationViewController.h"
#import <DownPicker.h>
#import "CribRoomiesViewController.h"
#import "Crib.h"
#import "Utility.h"

@interface CribLocationViewController ()

@property (strong, nonatomic) DownPicker *placesDownPicker;
@property (weak, nonatomic) IBOutlet UITextField *placeTextField;
@property (weak, nonatomic) IBOutlet UITextField *subPlaceTextField;

@end

@implementation CribLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSArray *placesArray = @[@"Берово", @"Битола", @"Скопје", @"Охрид", @"Куманово", @"Кавадарци", @"Велес", @"Струмица",@"Кичево", @"Кратово", @"Демир Капија"];
    
    self.placesDownPicker = [[DownPicker alloc] initWithTextField:self.placeTextField withData:placesArray];
    
    [self.placesDownPicker setPlaceholder:@"Изберете место..."];
    [self.placesDownPicker setPlaceholderWhileSelecting:@"Изберете место..."];
    [self.placesDownPicker setToolbarCancelButtonText:@"Откажи"];
    [self.placesDownPicker setToolbarDoneButtonText:@"Избери"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

static NSString *locationRoomiesSegueID = @"location-roomies-segue";

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:locationRoomiesSegueID]) {
        [self.cribDictionary setObject:self.placeTextField.text forKey:[Crib placeKey]];
        [self.cribDictionary setObject:self.subPlaceTextField.text forKey:[Crib subPlaceKey]];
        
        CribRoomiesViewController *cribRoomiesViewController = (CribRoomiesViewController *)segue.destinationViewController;
        cribRoomiesViewController.cribDictionary = self.cribDictionary;
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if([identifier isEqualToString:locationRoomiesSegueID]) {
        if(![self validateInput]) {
            [Utility showAlertWithErrors:@[[NSNumber numberWithInt:InvalidPlaceError]] onParent:self];
            return NO;
        } else {
            return YES;
        }
    }
    return NO;
}

-(BOOL)validateInput {
    if(self.placeTextField.text.length > 0) {
        return YES;
    }
    return NO;
}

@end
