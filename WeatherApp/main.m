//
//  main.m
//  WeatherApp
//
//  Created by Luca Faggion on 22/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SQLManager.h"
#import "WeatherData.h"
#import "Test.h"
#import "CityWeather.h"
#import "forecastWeather.h"

int main(int argc, char * argv[]) {
    //SQLManager* sql = [[SQLManager alloc]initWithDatabaseName:@"WeatherDB.sql"];
    //[sql executeQuery:@"insert into peopleInfo values(null, 'Test', 'Test1', 23)"];
    //NSArray* query2 = [sql loadDataFromDB:@"select * from city_data where id=707860"];
    
    WeatherData* data = [WeatherData sharedData];
    Test* t = [[Test alloc]init];
    [data getCityCurrentWeatherbyId:[NSNumber numberWithInt:2172797] withSelector:@selector(updateAfterGetCity:) ofObject:t];
    [data getCityForecastWeatherbyId:[NSNumber numberWithInt:2172797] withSelector:@selector(updateAfterGetCityforecast:) ofObject:t];
    
    CityWeather* city = [[CityWeather alloc]initWithDatabase:[[SQLManager alloc]init] fromId:[NSNumber numberWithInt:2172797]];
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
