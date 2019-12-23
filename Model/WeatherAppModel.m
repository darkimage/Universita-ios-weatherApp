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
@property (nonatomic, strong) WeatherBackgroundPresets* WeatherBackgroundData;

@end

@implementation WeatherAppModel

//Singleton Pattern
+(instancetype) sharedModel{
    static WeatherAppModel* sharedAppModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
            sharedAppModel = [[self alloc]init];
    });
    return sharedAppModel;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.DBData = [[SQLManager alloc] init];
        self.WeatherData = [[WeatherData alloc]init];
        self.WeatherBackgroundData = [[WeatherBackgroundPresets alloc] init];
    }
    return self;
}

-(DBManager*) getDatabase{
    return self.DBData;
}

-(WeatherData*) getWeatherData{
    return self.WeatherData;
}

- (nonnull CAShapeLayer *)getPlaceHolderShapeLayerStyled { 
    CAShapeLayer *placeHolderLayer = [CAShapeLayer layer];
    placeHolderLayer.fillColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:0.8].CGColor;
    return placeHolderLayer;
}

- (nonnull WeatherBackgroundPresets *)getWeatherBackgroundPreset { 
    return self.WeatherBackgroundData;
}

- (nonnull AppDelegate *)getAppDelegate { 
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

@end
