//
//  WeatherAppModel.m
//  WeatherApp
//
//  Created by Luca Faggion on 24/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import "WeatherAppModel.h"

@interface WeatherAppModel()

@property (nonatomic, strong) DBManager* DBData;
@property (nonatomic, strong) WeatherData* WeatherData;

@end

@implementation WeatherAppModel

//Singleton Pattern
+(id) sharedModel{
    static WeatherAppModel* sharedAppModel;
    @synchronized (self) {
        if(sharedAppModel == nil){
            sharedAppModel = [[self alloc]init];
        }
        return sharedAppModel;
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.DBData = [[SQLManager alloc] init];
        self.WeatherData = [[WeatherData alloc]init];
    }
    return self;
}

-(DBManager*) getDatabase{
    return self.DBData;
}

-(WeatherData*) getWeatherData{
    return self.WeatherData;
}

@end
