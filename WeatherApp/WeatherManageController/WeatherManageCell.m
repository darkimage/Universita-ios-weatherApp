//
//  WeatherManageCell.m
//  WeatherApp
//
//  Created by Luca Faggion on 30/12/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import "WeatherManageCell.h"
@interface WeatherManageCell()
@property (strong, nonatomic) IBOutlet UILabel *cityName;
@property (strong, nonatomic) IBOutlet UILabel *cityTemperature;
@property (strong, nonatomic) IBOutlet UILabel *weatherDescription;

@end

@implementation WeatherManageCell

-(void) initCellWithData:(CityWeather*)data{
    self.cityName.text = data.name;
    self.cityTemperature.text = [NSString stringWithFormat:@"%.00f°",[data.current.mainTemp floatValue]];
    self.weatherDescription.text = data.current.weatherDescription;
}

@end
