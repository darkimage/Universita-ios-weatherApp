//
//  WeatherManageController.m
//  WeatherApp
//
//  Created by Luca Faggion on 29/12/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import "WeatherManageController.h"
#import "WeatherAppModel.h"
#import "WeatherManageCell.h"
#import "WeatherAppModel.h"
#import "WeatherSearchController.h"

@interface WeatherManageController ()
@property (strong, nonatomic) IBOutlet UINavigationItem *navigationBar;

@property (strong, nonatomic) NSMutableArray* favoriteCities;
@property (strong, nonatomic) NSMutableArray<CityWeather*>* citiesWeather;

-(void) goToSearch;
-(Boolean) deleteFavoriteCityWithId:(NSInteger)index;
-(void) saveCities;
@end

@implementation WeatherManageController

#pragma mark - Controller Life Cycles
- (void)viewDidLoad{
    [super viewDidLoad];
    if(self.delegate){
        self.favoriteCities = [[NSMutableArray alloc] initWithArray:[self.delegate getCities]];
        self.citiesWeather = [[NSMutableArray<CityWeather*> alloc] initWithArray:[self.delegate getCitiesWeather]];
        UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(goToSearch)];
        [addButton setTintColor:[UIColor whiteColor]];
        UIBarButtonItem* save = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_save"] style:UIBarButtonItemStylePlain target:self action:@selector(saveCities)];
        [save setTintColor:[UIColor whiteColor]];
        self.navigationBar.rightBarButtonItems = @[save, addButton];
        self.tableView.delegate = self;
    }
}

#pragma mark - WeatherSearchDelegate
-(void) onSelectedCityFromSearch:(NSInteger)city_id{
    if([[[WeatherAppModel sharedModel] getDatabase] addFavoriteCity:[NSNumber numberWithInteger:city_id]]){
        NSNumber* cityID = [NSNumber numberWithInteger:city_id];
        [self.favoriteCities addObject:@[cityID]];
        CityWeather* weather = [[CityWeather alloc] initWithCityID:cityID];
        [self.citiesWeather addObject:weather];
        [self.tableView reloadData];
        [self.delegate onAddCity:weather];
    }else{
        [WeatherAppModel displayToastWithMessage:@"Can't add city! \n please try again later." andDuration:10 from:self];
    }
}

#pragma mark - Private Methods
-(void) goToSearch{
    [self performSegueWithIdentifier:@"goToSearch" sender:self];
}

-(Boolean) deleteFavoriteCityWithId:(NSInteger)index{
    NSInteger city_id = [self.favoriteCities[index][0] integerValue];
    if([[[WeatherAppModel sharedModel] getDatabase] deleteFavoriteCitybyId:city_id]){
        [self.favoriteCities removeObjectAtIndex:index];
        [self.delegate onDeleteCityAtIndex:index];
        return YES;
    }
    return NO;
}

-(void) saveCities{
    NSMutableString* csv = [[NSMutableString alloc] init];
    NSArray* cities = [[[WeatherAppModel sharedModel] getDatabase] getFavoriteCities];
    if(cities.count != 0){
        for (int i = 0; i < cities.count; i++) {
            if(i+1 <= cities.count){
                [csv appendString:cities[i][0]];
            }
            if(i+1 != cities.count){
                [csv appendString:@","];
            }
        }
        UIActivityViewController*  saveController = [[UIActivityViewController alloc] initWithActivityItems:@[csv] applicationActivities:nil];
        [self presentViewController:saveController animated:YES completion:nil];
    }else{
        [WeatherAppModel displayToastWithMessage:@"No favorites cities to export!" andDuration:2.0 from:self];
    }
}

#pragma mark - TableView Interfaces
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.favoriteCities.count;
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     WeatherManageCell *cell = (WeatherManageCell*)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
     CityWeather* weather = self.citiesWeather[indexPath.row];
     [cell initCellWithData:weather];
//     [[[WeatherAppModel sharedModel] getWeatherBackgroundPreset] setWeatherBackgroundPreset:@"clear_sky" toView:cell.contentView];
     // TODO: backgroud della cella che rispecchia la condizione metereologica
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
 }

 // Supporto per edit condizionale
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
     // Se abbiamo una sola citta non possiamo cancellarla
     if(self.favoriteCities.count == 1){
         return NO;
     }
     return YES;
 }


 // Support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
     if (editingStyle == UITableViewCellEditingStyleDelete) {
         // Delete the row from the data source
         //RIMUOVI IL VALORE DALL'ARRAY self.favoriteCities AGGIORNANDO IL DATABASE E POI RIMUOVI LA RIGA
         if([self deleteFavoriteCityWithId:indexPath.row]){
             [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
         }else{
             [WeatherAppModel displayToastWithMessage:@"Can't remove city! \n please try again later." andDuration:10 from:self];
         }
     }
 }

 #pragma mark - Navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     WeatherSearchController* searchController = (WeatherSearchController*)[segue destinationViewController];
     searchController.delegate = self;
 }

@end
