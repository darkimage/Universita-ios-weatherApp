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
#import "CityWeather.h"
#import "ForecastWeather.h"

int main(int argc, char * argv[]) {
    //SQLManager* sql = [[SQLManager alloc]initWithDatabaseName:@"WeatherDB.sql"];
    //[sql executeQuery:@"insert into peopleInfo values(null, 'Test', 'Test1', 23)"];
    //NSArray* query2 = [sql loadDataFromDB:@"select * from city_data where id=707860"];
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
