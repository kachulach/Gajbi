//
//  CribDetailsTableViewController.m
//  Gajbi
//
//  Created by Boris Kachulachki on 1/28/16.
//  Copyright © 2016 Kachulach. All rights reserved.
//

#import "CribDetailsTableViewController.h"
#import "CribDoneViewController.h"
#import "Crib.h"
#import "Utility.h"
#import "NSString+Validation.h"

@interface CribDetailsTableViewController ()

@property (weak, nonatomic) IBOutlet UIView *toFromPriceView;
@property (weak, nonatomic) IBOutlet UIView *priceView;
@property (weak, nonatomic) IBOutlet UIView *toFromAreaView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *cribTypeSegmentedControl;

@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceFromTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceToTextField;

@property (weak, nonatomic) IBOutlet UISegmentedControl *eurMkdTotalPriceSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *eurMkdFromToPriceSegmentedControl;

@property (weak, nonatomic) IBOutlet UIStepper *floorStepper;
@property (weak, nonatomic) IBOutlet UITextField *floorTextField;

@property (weak, nonatomic) IBOutlet UISwitch *parkingSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *balconySwitch;
@property (weak, nonatomic) IBOutlet UISwitch *furnitureSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *elevatorSwitch;

@property (weak, nonatomic) IBOutlet UISegmentedControl *heatingTypeSegmentedControl;

@property (weak, nonatomic) IBOutlet UITextField *areaTextField;
@property (weak, nonatomic) IBOutlet UITextField *areaFromTextField;
@property (weak, nonatomic) IBOutlet UITextField *areaToTextField;

@property (nonatomic, strong) NSMutableArray *inputErrors;

@end

@implementation CribDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSNumber *postTypeNumber = self.cribDictionary[[Crib postTypeKey]];
    PostType postType = [postTypeNumber integerValue];
    if(postType == NeedCribPostType) {
        self.priceView.hidden = YES;
        self.areaTextField.hidden = YES;
        self.toFromPriceView.hidden = NO;
        self.toFromAreaView.hidden = NO;
    } else {
        self.priceView.hidden = NO;
        self.areaTextField.hidden = NO;
        self.toFromPriceView.hidden = YES;
        self.toFromAreaView.hidden = YES;
    }
    self.inputErrors = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

static NSString *detailsDoneSegueID = @"details-done-segue";

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:detailsDoneSegueID]) {
        
        NSNumber *cribType = [NSNumber numberWithInteger:[self.cribTypeSegmentedControl selectedSegmentIndex]];
        [self.cribDictionary setObject:cribType forKey:[Crib cribTypeKey]];
        
        [self.cribDictionary setObject:self.priceTextField.text forKey:[Crib totalPriceKey]];
        [self.cribDictionary setObject:self.priceToTextField.text forKey:[Crib priceToKey]];
        [self.cribDictionary setObject:self.priceFromTextField.text forKey:[Crib priceFromKey]];
        
        NSNumber *priceValueType;
        if(!self.toFromPriceView.hidden) {
            priceValueType = [NSNumber numberWithInteger:[self.eurMkdFromToPriceSegmentedControl selectedSegmentIndex]];
        } else {
            priceValueType = [NSNumber numberWithInteger:[self.eurMkdTotalPriceSegmentedControl selectedSegmentIndex]];
        }
        [self.cribDictionary setObject:priceValueType forKey:[Crib priceValueTypeKey]];
        
        [self.cribDictionary setObject:[NSNumber numberWithInteger:[self.floorTextField.text integerValue]] forKey:[Crib floorKey]];
        [self.cribDictionary setObject:[NSNumber numberWithBool:self.parkingSwitch.on] forKey:[Crib parkingKey]];
        [self.cribDictionary setObject:[NSNumber numberWithBool:self.balconySwitch.on] forKey:[Crib balconyKey]];
        [self.cribDictionary setObject:[NSNumber numberWithBool:self.elevatorSwitch.on] forKey:[Crib elevatorKey]];
        [self.cribDictionary setObject:[NSNumber numberWithBool:self.furnitureSwitch.on] forKey:[Crib furnitureKey]];
        
        NSNumber *heatingType = [NSNumber numberWithInteger:[self.heatingTypeSegmentedControl selectedSegmentIndex]];
        [self.cribDictionary setObject:heatingType forKey:[Crib heatingTypeKey]];
        
        [self.cribDictionary setObject:self.areaTextField.text forKey:[Crib totalAreaKey]];
        [self.cribDictionary setObject:self.areaToTextField.text forKey:[Crib areaToKey]];
        [self.cribDictionary setObject:self.areaFromTextField.text forKey:[Crib areaFromKey]];
        
        CribDoneViewController *cribDoneViewController = (CribDoneViewController *)segue.destinationViewController;
        cribDoneViewController.cribDictionary = self.cribDictionary;
    }
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if([identifier isEqualToString:detailsDoneSegueID]) {
        if(![self validateInput]) {
            [Utility showAlertWithErrors:self.inputErrors onParent:self];
            return NO;
        } else {
            return YES;
        }
    }
    return NO;
}

- (BOOL)validateInput {
    BOOL isValid = YES;
    
    if(!self.toFromPriceView.hidden) {
        if(self.priceToTextField.text.length <= 0 && ![self.priceToTextField.text isValidNumber]){
            isValid = NO;
            [self.inputErrors addObject:[NSNumber numberWithInt:InvalidToAreaError]];
        }
        if(self.priceFromTextField.text.length <= 0 && ![self.priceFromTextField.text isValidNumber]){
            isValid = NO;
            [self.inputErrors addObject:[NSNumber numberWithInt:InvalidFromAreaError]];
        }
    } else {
        if(self.priceTextField.text.length <= 0 && ![self.priceTextField.text isValidNumber]){
            isValid = NO;
            [self.inputErrors addObject:[NSNumber numberWithInt:InvalidPriceError]];
        }
    }
    
    if(!self.toFromAreaView.hidden) {
        if(self.areaToTextField.text.length <= 0 && ![self.areaToTextField.text isValidNumber]){
            isValid = NO;
            [self.inputErrors addObject:[NSNumber numberWithInt:InvalidToAreaError]];
        }
        if(self.areaFromTextField.text.length <= 0 && ![self.areaFromTextField.text isValidNumber]){
            isValid = NO;
            [self.inputErrors addObject:[NSNumber numberWithInt:InvalidFromAreaError]];
        }
    } else {
        if(self.areaTextField.text.length <= 0 && ![self.areaTextField.text isValidNumber]){
            isValid = NO;
            [self.inputErrors addObject:[NSNumber numberWithInt:InvalidAreaError]];
        }
    }
    
    if(self.floorTextField.text.length <= 0 && ![self.floorTextField.text isValidNumber]){
        isValid = NO;
        [self.inputErrors addObject:[NSNumber numberWithInt:InvalidFloorError]];
    }
    
    return isValid;
}

- (IBAction)floorStepperValueChanged:(UIStepper *)sender {
    double value = sender.value;
    self.floorTextField.text = [NSString stringWithFormat:@"%d", (int)value];
}



@end
