//
//  WeatherResultCell.m
//  WeatherApp
//
//  Created by Luca Faggion on 02/01/2020.
//  Copyright © 2020 Luca Faggion. All rights reserved.
//

#import "WeatherResultCell.h"
#import "CityWeather.h"

@interface WeatherResultCell()
@property (strong, nonatomic) CityWeather* data;
@property (strong, nonatomic) IBOutlet UILabel *cityName;
@property (strong, nonatomic) IBOutlet UILabel *cityCountry;
@end

@implementation WeatherResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void) setCellData:(CityWeather*)weather{
    if(weather){
        self.data = weather;
        self.cityName.text = weather.name;
        self.cityCountry.text = weather.country;
    }
}

- (NSInteger) getCityID{
    if(self.data){
        return [self.data.ID integerValue];
    }
    return -1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
