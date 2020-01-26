//
//  WeatherHistoryController.m
//  WeatherApp
//
//  Created by Luca Faggion on 04/01/2020.
//  Copyright © 2020 Luca Faggion. All rights reserved.
//

#import "WeatherHistoryController.h"
#import "WeatherHistoryEntry.h"
#import "WeatherHistoryCell.h"
#import "WeatherAppModel.h"

@interface WeatherHistoryController ()
@property (strong, nonatomic) IBOutlet UINavigationItem* navigationItem;
@property (strong, nonatomic) NSMutableArray<WeatherHistoryEntry*>* weatherHistory;
@end

@implementation WeatherHistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [NSString stringWithFormat:@"Weather history for %@",self.data.name];
    self.weatherHistory = [[NSMutableArray alloc] init];
    NSArray* history = [[[WeatherAppModel sharedModel] getDatabase] getHistoryOfCity:self.data.ID];
    for (NSArray* entry in history) {
        [self.weatherHistory addObject:[[WeatherHistoryEntry alloc]initFromData:entry]];
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.weatherHistory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeatherHistoryCell *cell = (WeatherHistoryCell*)[tableView dequeueReusableCellWithIdentifier:@"historycell" forIndexPath:indexPath];
    [cell setCellData:self.weatherHistory[indexPath.row]];
    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        if([[[WeatherAppModel sharedModel] getDatabase] deleteHistoryEntryForCity:self.weatherHistory[indexPath.row].ID ofTime:self.weatherHistory[indexPath.row].time]){
            [self.weatherHistory removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

@end
