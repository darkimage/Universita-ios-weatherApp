//
//  cityWeather.m
//  WeatherApp
//
//  Created by Luca Faggion on 24/11/2018.
//  Copyright © 2018 Luca Faggion. All rights reserved.
//

#import "CurrentWeather.h"

@implementation CurrentWeather

-(instancetype) initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        
        //usimo la notazione lunga perche alcune key potrebbero non essere presenti nel json come
        //specificato dalle API di OpenWeatherMap
        //API SPECIFICATIONS @ https://openweathermap.org/current#parameter
        /*If you do not see some of the parameters in your API response it means that these weather
         phenomena are just not happened for the time of measurement for the city or location chosen.
         Only really measured or calculated data is displayed in API response.*/
        
        _weatherMain = [[dict objectForKey:@"weather"][0] objectForKey:@"main"];
        _weatherId = [[dict objectForKey:@"weather"][0] objectForKey:@"id"];
        _weatherDescription = [[dict objectForKey:@"weather"][0] objectForKey:@"description"];
        _weatherIcon = [[dict objectForKey:@"weather"][0] objectForKey:@"icon"];
        _mainTemp = [[dict objectForKey:@"main"] objectForKey:@"temp"];
        _mainPressure = [[dict objectForKey:@"main"] objectForKey:@"pressure"];
        _mainHumidity = [[dict objectForKey:@"main"] objectForKey:@"humidity"];
        _mainMin_Temp = [[dict objectForKey:@"main"] objectForKey:@"temp_min"];
        _mainMax_Temp = [[dict objectForKey:@"main"] objectForKey:@"temp_max"];
        _mainSea_Level = [[dict objectForKey:@"main"] objectForKey:@"sea_level"];
        _mainGround_Level = [[dict objectForKey:@"main"] objectForKey:@"grnd_level"];
        _windSpeed = [[dict objectForKey:@"wind"] objectForKey:@"speed"];
        _windDeg = [[dict objectForKey:@"wind"] objectForKey:@"deg"];
        _cloudiness = [[dict objectForKey:@"clouds"] objectForKey:@"all"];
        _rainVol_1h = [[dict objectForKey:@"rain"] objectForKey:@"1h"];
        _rainVol_3h = [[dict objectForKey:@"rain"] objectForKey:@"3h"];
        _snowVol_1h = [[dict objectForKey:@"snow"] objectForKey:@"1h"];
        _snowVol_3h = [[dict objectForKey:@"snow"] objectForKey:@"3h"];
        _date = [NSDate dateWithTimeIntervalSince1970:[dict[@"dt"]doubleValue]];
    }
    return self;
}
@end
