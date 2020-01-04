//
//  WeatherManageCell.m
//  WeatherApp
//
//  Created by Luca Faggion on 30/12/2019.
//  Copyright © 2019 Luca Faggion. All rights reserved.
//

#import "WeatherManageCell.h"
#import "SkeletonView.h"

@interface WeatherManageCell()
@property (strong, nonatomic) CityWeather* data;
@property (strong, nonatomic) IBOutlet UILabel *cityName;
@property (strong, nonatomic) IBOutlet UILabel *cityTemperature;
@property (strong, nonatomic) IBOutlet UILabel *weatherDescription;
@property (strong, nonatomic) IBOutlet UIStackView *stackView;
@property (strong, nonatomic) SkeletonView* skeletonView;

-(void) setUpSkeletons;
@end

@implementation WeatherManageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.skeletonView = [[SkeletonView alloc] init];
}

-(void) initCellWithData:(CityWeather*)data{
    self.data = data;
    if(data.hasData){
        self.cityName.text = data.name;
        [self.skeletonView addView:self.cityName];
        [self.skeletonView addView:self.stackView withBorder:40];
        self.cityTemperature.text = [NSString stringWithFormat:@"%.00f°",[data.current.mainTemp floatValue]];
        self.weatherDescription.text = data.current.weatherDescription;
    }else{
        data.delegate = self;
        [self setUpSkeletons];
    }
}

#pragma mark - Private Methods
-(void) setUpSkeletons{
    [self.skeletonView addView:self.cityName];
    [self.skeletonView addView:self.stackView withBorder:40];
    self.cityName.text = @"";
    self.cityTemperature.text = @"";
    self.weatherDescription.text = @"";
    [self.skeletonView displaySkeletons];
}

#pragma mark - WeatherModelDelegate
- (void) onUpdatedWeatherData:(NSObject*)currentData{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.skeletonView stopDisplaySkeletons];
        [self initCellWithData:self.data];
    });
}

- (void) onUpdateWeatherDataError:(NSString*)message{
    
}

@end
