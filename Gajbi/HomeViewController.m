//
//  HomeViewController.m
//  Gajbi
//
//  Created by Boris Kachulachki on 12/20/15.
//  Copyright © 2015 Kachulach. All rights reserved.
//

#import "HomeViewController.h"
#import "CribCell.h"
#import "CribService.h"
#import "Utility.h"
#import "CribExtraDetailsViewController.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *cribs;
@property (weak, nonatomic) IBOutlet UIView *loadingCribsView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    [self setUpCribs];
}

-(void)viewWillAppear:(BOOL)animated {
    [self setUpCribs];
}

-(void)setUpCribs {
    [Utility invokeInternetConnectionAction:^{
        [self cribsLoading];
        [CribService getAllCribsWithCompletion:^(NSArray *array) {
            self.cribs = (NSMutableArray *)array;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self cribsDidLoad];
                [self.tableView reloadData];
            });
        } errorHandler:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self cribsDidLoad];
            });
            //TODO: HANDLE ERROR;
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cribs.count;
}

static NSString *cribCellID = @"crib-cell";

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CribCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cribCellID];
    Crib *crib = self.cribs[indexPath.row];
    if(!crib) {
        return cell;
    }
    [cell setCrib:crib];
    
    return cell;
}

static NSString *cribDetailsSegueID = @"crib-details-segue";

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:cribDetailsSegueID]) {
        CribCell *cell = (CribCell *)sender;
        if(!cell) {
            return;
        }
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        if(!indexPath) {
            return;
        }
        Crib *crib = self.cribs[indexPath.row];
        if(!crib) {
            return;
        }
        CribExtraDetailsViewController *cribExtraDetailsViewController = (CribExtraDetailsViewController *)segue.destinationViewController;
        cribExtraDetailsViewController.crib = crib;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)cribsLoading {
    self.tableView.hidden = YES;
    self.loadingCribsView.hidden = NO;
    [self.activityIndicator startAnimating];
}

-(void)cribsDidLoad {
    self.tableView.hidden = NO;
    self.loadingCribsView.hidden = YES;
    [self.activityIndicator stopAnimating];
}

@end
