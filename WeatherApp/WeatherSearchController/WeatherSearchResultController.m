//
//  WeatherSearchResultController.m
//  WeatherApp
//
//  Created by Luca Faggion on 30/12/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import "WeatherSearchResultController.h"
#import "WeatherManageCell.h"
#import "CityWeather.h"
#import "WeatherResultCell.h"

@interface WeatherSearchResultController ()
@end

@implementation WeatherSearchResultController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeatherResultCell *cell = (WeatherResultCell*)[tableView dequeueReusableCellWithIdentifier:@"resultcell" forIndexPath:indexPath];
    [cell setCellData:[[CityWeather alloc] initWithCityID:self.data[indexPath.row][0] update:false]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeatherResultCell *selectedCell = (WeatherResultCell*)[tableView cellForRowAtIndexPath:indexPath];
    if(self.delegate){
        [self.delegate onSelectedCityFromSearch:[selectedCell getCityID]];
    }
}
@end
