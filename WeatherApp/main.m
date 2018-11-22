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
#import <SBJson5/SBJson5.h>

int main(int argc, char * argv[]) {
    SQLManager* sql = [[SQLManager alloc]initWithDatabaseName:@"sampledb.sql"];
    //[sql executeQuery:@"insert into peopleInfo values(null, 'Test', 'Test1', 23)"];
    NSArray* query2 = [sql loadDataFromDB:@"select * from peopleInfo"];
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
