//
//  CribRoomiesViewController.m
//  Gajbi
//
//  Created by Boris Kachulachki on 1/17/16.
//  Copyright © 2016 Kachulach. All rights reserved.
//

#import "CribRoomiesViewController.h"
#import "Crib.h"
#import "CribDetailsTableViewController.h"

@interface CribRoomiesViewController ()
@property (weak, nonatomic) IBOutlet UITextField *numberOfTotalRoomiesTextField;
@property (weak, nonatomic) IBOutlet UIStepper *numberOfMissingRoomiesStepper;
@property (weak, nonatomic) IBOutlet UITextField *numberOfMissingRoomiesTextField;
@end

@implementation CribRoomiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)totalRoomiesStepperValueChanged:(UIStepper *)sender {
    double value = sender.value;
    [self.numberOfTotalRoomiesTextField setText:[NSString stringWithFormat:@"%d", (int)value]];
    self.numberOfMissingRoomiesStepper.maximumValue = value;
}

- (IBAction)missingRoomiesStepperValueChanged:(UIStepper *)sender {
    double value = sender.value;
    [self.numberOfMissingRoomiesTextField setText:[NSString stringWithFormat:@"%d", (int)value]];
}

static NSString *roomiesDetailsSegueID = @"roomies-details-segue";

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:roomiesDetailsSegueID]) {
        [self.cribDictionary setObject:[NSNumber numberWithInteger:[self.numberOfTotalRoomiesTextField.text integerValue]] forKey:[Crib numberOfTotalRoomiesKey]];
        [self.cribDictionary setObject:[NSNumber numberWithInteger:[self.numberOfMissingRoomiesTextField.text integerValue]] forKey:[Crib numberOfMissingRoomiesKey]];
        
        CribDetailsTableViewController *cribDetailsTableViewController = (CribDetailsTableViewController *)segue.destinationViewController;
        cribDetailsTableViewController.cribDictionary = self.cribDictionary;
    }
}


@end
