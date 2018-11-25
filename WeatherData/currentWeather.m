//
//  cityWeather.m
//  WeatherApp
//
//  Created by Luca Faggion on 24/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import "currentWeather.h"

@implementation currentWeather

-(instancetype) initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        
        //usimo la notazione lunga perche alcune key potrebbero non essere presenti nel json come
        //specificato dalle API di OpenWeatherMap
        //API SPECIFICATIONS @ https://openweathermap.org/current#parameter
        /*If you do not see some of the parameters in your API response it means that these weather
         phenomena are just not happened for the time of measurement for the city or location chosen.
         Only really measured or calculated data is displayed in API response.*/
        
        self.weatherMain = [[dict objectForKey:@"weather"][0] objectForKey:@"main"];
        self.weatherDescription = [[dict objectForKey:@"weather"][0] objectForKey:@"description"];
        self.weatherIcon = [[dict objectForKey:@"weather"][0] objectForKey:@"icon"];
        self.mainTemp = [[dict objectForKey:@"main"] objectForKey:@"temp"];
        self.mainPressure = [[dict objectForKey:@"main"] objectForKey:@"pressure"];
        self.mainHumidity = [[dict objectForKey:@"main"] objectForKey:@"humidity"];
        self.mainMin_Temp = [[dict objectForKey:@"main"] objectForKey:@"temp_min"];
        self.mainMax_Temp = [[dict objectForKey:@"main"] objectForKey:@"temp_max"];
        self.mainSea_Level = [[dict objectForKey:@"main"] objectForKey:@"sea_level"];
        self.mainGround_Level = [[dict objectForKey:@"main"] objectForKey:@"grnd_level"];
        self.windSpeed = [[dict objectForKey:@"wind"] objectForKey:@"speed"];
        self.windDeg = [[dict objectForKey:@"wind"] objectForKey:@"deg"];
        self.cloudiness = [[dict objectForKey:@"clouds"] objectForKey:@"all"];
        self.rainVol_1h = [[dict objectForKey:@"rain"] objectForKey:@"1h"];
        self.rainVol_3h = [[dict objectForKey:@"rain"] objectForKey:@"3h"];
        self.snowVol_1h = [[dict objectForKey:@"snow"] objectForKey:@"1h"];
        self.snowVol_3h = [[dict objectForKey:@"snow"] objectForKey:@"3h"];
        self.date = [NSDate dateWithTimeIntervalSince1970:[dict[@"dt"]doubleValue]];
    }
    return self;
}
@end
