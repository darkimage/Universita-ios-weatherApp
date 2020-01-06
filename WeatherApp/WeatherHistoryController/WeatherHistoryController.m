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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

@end
