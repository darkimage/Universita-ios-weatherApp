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

@interface WeatherManageController ()
@property (strong, nonatomic) IBOutlet UINavigationItem *navigationBar;

@property (strong, nonatomic) NSMutableArray* favoriteCities;
@property (strong, nonatomic) NSMutableArray<CityWeather*>* citiesWeather;

-(void) goToSearch;
-(Boolean) deleteFavoriteCityWithId:(NSInteger)index;
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
        self.navigationBar.rightBarButtonItem = addButton;
        self.tableView.delegate = self;
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

#pragma mark - TableView Interfaces
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.favoriteCities.count;
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     WeatherManageCell *cell = (WeatherManageCell*)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
     CityWeather* weather = self.citiesWeather[indexPath.row];
     [cell initCellWithData:weather];
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
             // TODO: implementare messagio che dice che non e possibile rimuovere la citta;
         }
     }
 }

 #pragma mark - Navigation
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
 }

@end
